local var_0_0 = singletonClass("SnowballGameMgr")

local function var_0_1(arg_1_0)
	manager.audio:PlayEffect("minigame_activity_2_6_snowball", arg_1_0, "")
end

local function var_0_2(arg_2_0)
	return arg_2_0.model
end

local function var_0_3(arg_3_0)
	return arg_3_0.spawnAt
end

local function var_0_4(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or 0

	return SnowballGameUnitCfg[arg_4_0 * 100 + arg_4_1] or SnowballGameUnitCfg[arg_4_0]
end

local function var_0_5(arg_5_0)
	return arg_5_0[math.random(#arg_5_0)]
end

local var_0_6 = 3
local var_0_7 = "snowball_fight"
local var_0_8 = "snowball_gift"
local var_0_9 = "snowball_get_sign"
local var_0_10 = "minigame_snowball"
local var_0_11 = "minigame_snowball_buff"
local var_0_12 = 0.2
local var_0_13 = 1.6
local var_0_15 = "idle"
local var_0_16 = "happy"

local function var_0_17(...)
	return DormCharacterActionManager.frameTaskRunner:NewTask(...)
end

local var_0_18 = Dorm.LuaBridge.MiniGameBridge.PlayEffect
local var_0_19 = Dorm.DormEntityManager.QueryPosition
local var_0_20 = Dorm.DormEntityManager.QueryForwardDir
local var_0_21 = Dorm.DormEntityManager.QueryEntityAttachPointWorldPos

function var_0_0:Ctor()
	self.entityManager = EntityManager.New((EntityManager.CreateModel.New(var_0_2, var_0_3, var_0_12)))

	function self.entityManager.OnCreate(arg_8_0, arg_8_1)
		Dorm.DormEntityManager.PlayEffect(arg_8_1, "root", var_0_10, "Dorm/Effect/snowball/fx_snow_effect_spawn", 1)
		Dorm.DormEntityManager.SetFadeCMD(arg_8_1, 0)
		var_0_17():WaitForSec(0.25):Then(function()
			if Dorm.DormEntityManager.IsValidEntityID(arg_8_1) then
				Dorm.DormEntityManager.SetFadeCMD(arg_8_1, 1)
			end
		end):Start()
	end

	function self.entityManager.OnRemove(arg_10_0, arg_10_1)
		if DormUtils.GetEntityData(arg_10_1).isHumanoidTarget then
			Dorm.DormEntityManager.StartFadeOutCMD(arg_10_1, var_0_12)
		else
			Dorm.DormEntityManager.SetFadeCMD(arg_10_1, 0)
		end

		Dorm.DormEntityManager.PlayEffectDetached(arg_10_1, "root", "Dorm/Effect/snowball/fx_snow_effect_death", 1)
	end

	self.playerManager = EntityManager.New((EntityManager.CreatePlayer.New(var_0_2, var_0_3)))

	function self.playerManager.OnRemove(arg_11_0, arg_11_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_11_1)
	end

	self.managers = {
		self.entityManager,
		self.playerManager
	}
	self.listener = EventListener.New()
end

function var_0_0:Init()
	self.targetIdx = 0
	self.shootSpeedFactor = 1
	self.playerSpawnPos = Dorm.storage:PickData("snowball.pos.player").transform
	self.guestSpawnPos = Dorm.storage:PickData("snowball.pos.guest").transform

	self.listener:Register(SNOWBALL_GAME_AIM_FINISH, handler(self, self.OnSnowballAimFinish))
	self.listener:Register(SNOWBALL_GAME_TARGET_NEW_WAVE, handler(self, self.SpawnTarget))
	self.listener:Register(SNOWBALL_GAME_INFINITY_POOL_CLICK_MODEL, handlerArg1(self, self.PlayerPlayAction, var_0_15))
	self.listener:Register(SNOWBALL_GAME_INFINITY_POOL_CLICK_ICE, handlerArg1(self, self.PlayerPlayAction, var_0_16))
	self.listener:Register(ON_BEGIN_STORY, handler(self, self.OnBeginStory))
	self.listener:Register(ON_FINISH_STORY, handler(self, self.OnFinishStory))
end

function var_0_0:Dispose()
	self.listener:RemoveAll()
	self.entityManager:Clear(true)
	self.playerManager:Clear(true)

	self.targetIdx = nil
end

function var_0_0:OnBeginStory(arg_14_1)
	if DormEnum.HasFlag(arg_14_1, DormEnum.BeginStoryFlag.HideCharacter) then
		self.playerManager:Clear(true)
	end
end

function var_0_0:OnFinishStory(arg_15_1)
	if DormEnum.HasFlag(arg_15_1, DormEnum.BeginStoryFlag.HideCharacter) then
		self:SetPlayer(self.player)
		self:SetGuest(self.guest)
	end
end

function var_0_0:PlayerPlayAction(arg_16_1, arg_16_2)
	local var_16_0 = self:GetPlayerEID()

	if arg_16_2 then
		Dorm.DormEntityManager.StopAllCmd(var_16_0)
	end

	Dorm.DormEntityManager.SendDoActionCMD(var_16_0, arg_16_1, false)
end

local function var_0_22(arg_17_0, arg_17_1)
	Dorm.DormEntityManager.SetEntitySpeed(arg_17_0, arg_17_1)

	DormUtils.GetEntityData(arg_17_0).speed = arg_17_1
end

local var_0_23 = {
	Guest = 4,
	Player = 0,
	RewardTarget = 2,
	NormalTarget = 1,
	PanishTarget = 3
}

local function var_0_24(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2 and arg_18_2 ~= 0 then
		local var_18_0 = var_0_4(arg_18_2, arg_18_1)
		local var_18_1 = var_18_0.unit_type == var_0_23.PanishTarget

		arg_18_0.targetCountByType[var_18_0.unit_type] = (arg_18_0.targetCountByType[var_18_0.unit_type] or 0) + 1
		arg_18_0.targetCountByRow[arg_18_1] = (arg_18_0.targetCountByRow[arg_18_1] or 0) + 1

		local var_18_2 = arg_18_0.entityManager:Create(arg_18_0.targetIdx, {
			complex = true,
			type = "target",
			model = var_18_0.model,
			spawnAt = arg_18_3
		}, {
			type = "target",
			cfgID = var_18_0.id,
			isHumanoidTarget = var_18_1,
			row = arg_18_1
		})

		arg_18_0.targetIdx = arg_18_0.targetIdx + 1

		Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_18_2, "snowball_target_move_L")

		if var_18_1 then
			Dorm.LuaBridge.MiniGameBridge.InitDefaultEntityCollider(var_18_2)
			Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(var_18_2, false)
			Dorm.LuaBridge.MiniGameBridge.InitMoveController(var_18_2)
			Dorm.LuaBridge.MiniGameBridge.SetMoveLookAtEntity(var_18_2, arg_18_0:GetPlayerEID())
		else
			Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(var_18_2, false)
			Dorm.LuaBridge.MiniGameBridge.InitMoveController(var_18_2)
			Dorm.LuaBridge.MiniGameBridge.SetMoveLookAtDir(var_18_2, Vector3(0, 0, 1))
		end

		SnowballGameTargetAI.GetInstance():AddEntityToRow(var_18_2, arg_18_1)
		var_0_22(var_18_2, var_18_0.speed)

		return var_18_2
	end
end

local function var_0_25(arg_19_0, arg_19_1)
	if DormUtils.GetEntityData(arg_19_1).type == "target" then
		SnowballGameTargetAI.GetInstance():Remove(arg_19_1)

		local var_19_0 = DormUtils.GetEntityData(arg_19_1)
		local var_19_1 = var_0_4(var_19_0.cfgID)

		arg_19_0.targetCountByType[var_19_1.unit_type] = arg_19_0.targetCountByType[var_19_1.unit_type] - 1
		arg_19_0.targetCountByRow[var_19_0.row] = arg_19_0.targetCountByRow[var_19_0.row] - 1
	end

	EntityManager.FindAndRemoveEntity(arg_19_0.managers, arg_19_1)
end

function var_0_0:GetNormalTargetCount()
	return nullable(self.targetCountByType, var_0_23.NormalTarget) or 0
end

function var_0_0:GetRewardTargetCount()
	return nullable(self.targetCountByType, var_0_23.RewardTarget) or 0
end

function var_0_0:GetPanishTargetCount()
	return nullable(self.targetCountByType, var_0_23.PanishTarget) or 0
end

local var_0_26 = -1
local var_0_27 = -2

function var_0_0:SetPlayer(arg_23_1)
	local var_23_0 = self:GetPlayerEID()

	if var_23_0 then
		var_0_0.ClearVfxOnEntity(var_23_0)
		self.playerManager:Remove(var_0_26)
	end

	self.player = arg_23_1

	if arg_23_1 == nil then
		return
	end

	local var_23_1 = var_0_4(arg_23_1)
	local var_23_2 = self.playerManager:Create(var_0_26, {
		complex = true,
		model = var_23_1.model,
		spawnAt = self.playerSpawnPos
	}, {
		type = "player",
		cfgID = var_23_1.id
	})

	Dorm.DormEntityManager:PlayerControlEntity((UnityEngine.Camera.main or nil) and (UnityEngine.Camera.main.transform.forward or Vector3(0, 0, -1)))
	Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(var_23_2, true)
	Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_23_2, "snowball_move_L")
	var_0_22(var_23_2, var_23_1.speed)
	var_0_0.CreateHoldSnowballVfx(var_23_2)
end

function var_0_0:SetGuest(arg_24_1)
	self.guest = arg_24_1

	if arg_24_1 == nil then
		return
	end

	self.playerManager:Remove(var_0_27)

	local var_24_0 = var_0_4(arg_24_1)
	local var_24_1 = self.playerManager:Create(var_0_27, {
		complex = true,
		model = var_24_0.model,
		spawnAt = self.guestSpawnPos
	}, {
		row = 0,
		type = "guest",
		cfgID = arg_24_1
	})

	Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(var_24_1, false)
	var_0_22(var_24_1, var_24_0.speed)
end

function var_0_0:RemoveGuest()
	self.guest = nil

	self.playerManager:Remove(var_0_27)
end

function var_0_0:ClearAllTargets()
	SnowballGameTargetAI.GetInstance():Clear()
	self.entityManager:Clear(true)

	self.targetCountByType = {}
	self.targetCountByRow = {}
end

local var_0_28 = {
	var_0_23.NormalTarget,
	var_0_23.RewardTarget,
	var_0_23.PanishTarget
}

function var_0_0:SetLevel(arg_27_1)
	self:ClearAllTargets()

	self.level = arg_27_1
	self.targets = {}

	for iter_27_0, iter_27_1 in ipairs(SnowballGameCfg[arg_27_1].enemy_set) do
		self.targets[var_0_28[iter_27_0]] = {
			total = iter_27_1[1],
			weight = iter_27_1[2]
		}
	end

	self.buffList, self.debuffList = SnowballGameCfg[arg_27_1].level_buff, SnowballGameCfg[arg_27_1].level_debuff

	self:SetGuest(var_0_5(SnowballGameCfg[arg_27_1].hero_id))
end

local function var_0_29(arg_28_0, arg_28_1)
	if arg_28_1 == var_0_23.NormalTarget then
		return SnowballGameCfg[arg_28_0].enemy_normal
	elseif arg_28_1 == var_0_23.RewardTarget then
		return SnowballGameCfg[arg_28_0].enemy_reward
	elseif arg_28_1 == var_0_23.PanishTarget then
		return SnowballGameCfg[arg_28_0].enemy_punish
	end
end

local function var_0_30(arg_29_0)
	local var_29_0 = 0

	for iter_29_0, iter_29_1 in pairs(arg_29_0.targets) do
		if iter_29_1.total > 0 then
			var_29_0 = var_29_0 + iter_29_1.weight
		end
	end

	if var_29_0 == 0 then
		return nil
	end

	local var_29_1 = math.random() * var_29_0

	for iter_29_2, iter_29_3 in pairs(arg_29_0.targets) do
		if iter_29_3.total > 0 then
			var_29_1 = var_29_1 - iter_29_3.weight

			if var_29_1 <= 0 then
				return iter_29_2
			end
		end
	end
end

local function var_0_31(arg_30_0)
	return nullable(var_0_4(DormUtils.GetEntityData(arg_30_0).cfgID), "unit_type") == var_0_23.PanishTarget
end

local function var_0_32(arg_31_0)
	return nullable(var_0_4(DormUtils.GetEntityData(arg_31_0).cfgID), "unit_type") == var_0_23.RewardTarget
end

function var_0_0:GetEachWaveGenLimitPerRow(arg_32_1, arg_32_2)
	return nullable(SnowballGameCfg[self.level].refresh_enemy, arg_32_1, arg_32_2) or math.huge
end

function var_0_0.GetTotalGenLimit(arg_33_0)
	return GameSetting.activity_snowball_maxsnowman.value[1]
end

local function var_0_33(arg_34_0)
	return string.format("snowball.pos.row%d", arg_34_0)
end

local function var_0_34(arg_35_0)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in Dorm.storage:ForeachData(arg_35_0, pairs) do
		table.insert(var_35_0, iter_35_1)
	end

	for iter_35_2 = 1, #var_35_0 do
		local var_35_1 = math.random(#var_35_0)

		var_35_0[iter_35_2], var_35_0[var_35_1] = var_35_0[var_35_1], var_35_0[iter_35_2]
	end

	return var_35_0
end

function var_0_0:SpawnTarget(arg_36_1)
	local var_36_0 = false

	if arg_36_1 == 0 then
		for iter_36_0, iter_36_1 in ipairs(SnowballGameCfg[self.level].snowman_pos) do
			for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
				local var_36_1 = nullable(Dorm.storage:GetData(var_0_33(iter_36_0), iter_36_3[2]), "transform")

				if var_36_1 then
					var_36_0 = var_36_0 or var_0_24(self, iter_36_0, iter_36_3[1], var_36_1) ~= nil
				end
			end
		end
	else
		if self.targets == nil then
			return
		end

		for iter_36_4 = 1, var_0_6 do
			local var_36_2 = 0

			for iter_36_5, iter_36_6 in ipairs((var_0_34(var_0_33(iter_36_4)))) do
				if not Dorm.LuaBridge.MiniGameBridge.CheckPosBlocked(iter_36_6.transform.position) and var_36_2 < self:GetEachWaveGenLimitPerRow(arg_36_1, iter_36_4) and ((not self.targetCountByRow[iter_36_4] or nil) and 0) < self:GetTotalGenLimit() then
					local var_36_4 = var_0_30(self)

					if var_36_4 then
						self.targets[var_36_4].total = math.max(0, self.targets[var_36_4].total - 1)
						var_36_0 = var_36_0 or var_0_24(self, iter_36_4, var_0_5(var_0_29(self.level, var_36_4)), iter_36_6.transform) ~= nil
						var_36_2 = var_36_2 + 1
					elseif var_36_2 == 0 then
						manager.notify:Invoke(SNOWBALL_GAME_ALL_TARGET_SPAWNED)
					end
				end
			end
		end
	end

	if var_36_0 then
		var_0_1("minigame_activity_2_6_snowball_refresh")
	end
end

function var_0_0:GetPlayerEID()
	return self.playerManager:GetEntityID(var_0_26)
end

function var_0_0:GetPlayerCfgID()
	return self.player
end

function var_0_0:GetGuestEID()
	return self.playerManager:GetEntityID(var_0_27)
end

function var_0_0:GetGuestCfgID()
	return self.guest
end

function var_0_0.ClearVfxOnEntity(arg_41_0)
	Dorm.DormEntityManager.ClearAllEffect(arg_41_0, var_0_10)
end

function var_0_0.ClearBuffVfxOnEntity(arg_42_0)
	Dorm.DormEntityManager.ClearAllEffect(arg_42_0, var_0_11)
end

function var_0_0.CreateHoldSnowballVfx(arg_43_0)
	Dorm.DormEntityManager.PlayEffect(arg_43_0, "gua_R_hand_bone", var_0_10, "Dorm/Effect/snowball/fx_snow_effect_xueqiu_static", -1)
end

local var_0_35 = {
	[2] = 1,
	[3] = 4
}
local var_0_36 = {
	duration = 1.933,
	sequence = {
		[0] = function(arg_44_0)
			var_0_0.CreateHoldSnowballVfx(arg_44_0.entityID)

			arg_44_0.targetID = arg_44_0._targetID

			Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_44_0.entityID, var_0_7)
			var_0_1("minigame_activity_2_6_snowball_attack")

			if Dorm.DormEntityManager.INVALID_ENTITY_ID == arg_44_0.targetID then
				var_0_1("minigame_activity_2_6_snowball_hit03")
			end
		end,
		[0.35] = function(arg_45_0)
			var_0_0.ClearVfxOnEntity(arg_45_0.entityID)

			local var_45_0 = var_0_19(arg_45_0.entityID)

			if Dorm.DormEntityManager.INVALID_ENTITY_ID == arg_45_0.targetID then
				Dorm.DormEntityManager.PlayEffect(arg_45_0.entityID, "gua_biaoqing_bone", var_0_10, "Dorm/Effect/tongyong/fx_jingxia_0501", Vector3(-0.25, 0.25, 0), Quaternion.Euler(0, 0, 60), Vector3.one, 0.25)
				var_0_18(var_45_0, arg_45_0.hitPos:Magnitude() ~= math.huge and Quaternion.LookRotation(arg_45_0.hitPos - var_45_0) or Quaternion.LookRotation(var_0_20(arg_45_0.entityID)), Vector3.one, "Dorm/Effect/snowball/fx_snow_effect_xueqiu2", 1)
			else
				local var_45_2 = var_0_19(arg_45_0.targetID)

				var_45_2.y = var_45_2.y + (nullable(var_0_35, DormUtils.GetEntityData(arg_45_0.targetID).row) or 0)

				var_0_18(var_45_0, Quaternion.LookRotation(var_45_2 - var_45_0), Vector3.one, "Dorm/Effect/snowball/fx_snow_effect_xueqiu", 0.167)
			end
		end,
		[0.7 - 0.1] = function(arg_46_0)
			local var_46_0 = SnowballGameMgr.GetInstance()

			if arg_46_0.targetID == var_46_0:GetPlayerEID() or arg_46_0.targetID == var_46_0:GetGuestEID() then
				Dorm.DormEntityManager.PlayEffect(arg_46_0.targetID, "gua_biaoqing_bone", var_0_10, "Dorm/Effect/tongyong/fx_jingxia_0501", Vector3(-0.25, 0.25, 0), Quaternion.Euler(0, 0, 60), Vector3.one, 0.25)
			end
		end,
		[0.7] = function(arg_47_0)
			if arg_47_0.hitAction then
				arg_47_0.hitAction()
			end
		end,
		[1.433] = function(arg_48_0)
			Dorm.DormEntityManager.SetCurInteractToLowPriority(arg_48_0.entityID)
		end
	}
}

local function var_0_37(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	Dorm.DormEntityManager.StopAllCmd(arg_49_0)

	local var_49_0 = DormCharacterInteractBehaviour.MakeCtx(arg_49_0, arg_49_0, {
		hitAction = arg_49_3,
		hitPos = arg_49_2,
		_targetID = arg_49_1
	})

	var_49_0.curActionTask = DormCharacterInteractBehaviour.MakeInteractTask(var_0_36, var_49_0)

	DormUtils.SetEntityInteractContext(arg_49_0, var_49_0)
	Dorm.DormEntityManager.SendInteractToEntityCMD(arg_49_0, arg_49_0, false)
end

local function var_0_38(arg_50_0, arg_50_1)
	Dorm.DormEntityManager.StopAllCmd(arg_50_0)
	Dorm.DormEntityManager.SendDoActionCMD(arg_50_0, var_0_8, nil, false, 0, false)
	Dorm.DormEntityManager.PlayEffect(arg_50_0, "gua_R_hand_bone", var_0_10, "Dorm/Effect/snowball/fx_snow_effect_liwu", 2.833)
	var_0_17():WaitForSec(var_0_13):Then(arg_50_1):Start()
end

function var_0_0:GuestPlaySubtitle(arg_51_1)
	arg_51_1 = GetTips(arg_51_1)

	manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, self:GetGuestEID(), arg_51_1)
end

local function var_0_39(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	if arg_52_1 == Dorm.DormEntityManager.INVALID_ENTITY_ID then
		return
	end

	var_0_18(arg_52_2, "Dorm/Effect/snowball/fx_snow_effect_snowhit", 1)

	local var_52_0 = DormUtils.GetEntityData(arg_52_1)

	if var_52_0.type == "target" then
		arg_52_0:OnSnowballHitTarget(arg_52_1, var_52_0, arg_52_2, arg_52_3)
	elseif var_52_0.type == "guest" then
		var_0_1("minigame_activity_2_6_snowball_hit04")
		manager.notify:Invoke(SNOWBALL_GAME_PLAYER_HIT_GUEST)
		arg_52_0:GuestPlaySubtitle("ACTIVITY_SNOWBALL_HIT_NPC_TALK01")
		arg_52_0:GuestBeatPlayer()
	end
end

function var_0_0:OnSnowballAimFinish(arg_53_1, arg_53_2, arg_53_3)
	local var_53_0 = self:GetPlayerEID()

	DormLuaBridge.ResetJoystick(false)
	var_0_0.ClearVfxOnEntity(var_53_0)
	var_0_37(var_53_0, arg_53_1, arg_53_2, function()
		var_0_0.ClearVfxOnEntity(var_53_0)
		var_0_0.CreateHoldSnowballVfx(var_53_0)

		if arg_53_2:Magnitude() ~= math.huge then
			var_0_39(self, arg_53_1, arg_53_2, arg_53_3)
		end
	end)
end

function var_0_0:OnSnowballHitTarget(arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	local var_55_1 = self.lockHeadShot or arg_55_4 == "head"
	local var_55_2

	if DormUtils.GetEntityData(arg_55_1).isHumanoidTarget then
		Dorm.DormEntityManager.PlaySpacialFacileExpression(arg_55_1, "Effect/Dorm/faint01", 1)

		var_55_2 = var_0_1
	end

	var_55_2(var_55_1 and "minigame_activity_2_6_snowball_hit01" or "minigame_activity_2_6_snowball_hit02")

	if var_0_31(arg_55_1) then
		self:GuestPlaySubtitle("ACTIVITY_SNOWBALL_HIT_PUNISH_TALK01")
		self:GuestBeatPlayer()
	elseif var_0_32(arg_55_1) then
		self:GuestSendGift()
	else
		self:GuestLiftSign(var_55_1)
	end

	manager.notify:Invoke(SNOWBALL_GAME_HIT, arg_55_2, var_55_1, arg_55_3)
	var_0_25(self, arg_55_1)
end

function var_0_0:GetBuffFactor(arg_56_1)
	return SnowballGameCfg[self.level].buff_intensity[arg_56_1]
end

function var_0_0:GetBuffDuration(arg_57_1)
	if type(SnowballGameCfg[self.level].buff_duration[arg_57_1]) == "table" then
		return SnowballGameCfg[self.level].buff_duration[arg_57_1][1] + (SnowballGameCfg[self.level].buff_duration[arg_57_1][2] - SnowballGameCfg[self.level].buff_duration[arg_57_1][1]) * math.random()
	else
		return SnowballGameCfg[self.level].buff_duration[arg_57_1]
	end
end

function var_0_0:GuestBeatPlayer()
	local var_58_0 = self:GetPlayerEID()
	local var_58_1 = self:GetGuestEID()
	local var_58_2 = var_0_5(self.debuffList)

	Dorm.DormEntityManager.PutEntityLookAt(var_58_1, self.guestSpawnPos.position, (var_0_19(var_58_0)))
	Dorm.DormEntityManager.PlaySpacialFacileExpression(var_58_1, "Effect/Dorm/anger03", 0.5)
	var_0_37(var_58_1, var_58_0, var_0_21(var_58_0, "gua_Hit"), function()
		manager.notify:Invoke(SNOWBALL_GAME_PLAYER_GET_BUFF, var_58_2, self:GetBuffDuration(var_58_2), (self:GetBuffFactor(var_58_2)))
	end)
end

function var_0_0:GuestSendGift()
	var_0_1("minigame_activity_2_6_snowball_present")

	local var_60_0 = self:GetGuestEID()
	local var_60_1 = var_0_5(self.buffList)

	Dorm.DormEntityManager.ClearAllEffectOnAttachPoint(var_60_0, "gua_R_hand_bone")
	Dorm.DormEntityManager.PutEntityLookAt(var_60_0, self.guestSpawnPos.position, (var_0_19((self:GetPlayerEID()))))
	Dorm.DormEntityManager.PlaySpacialFacileExpression(var_60_0, "Effect/Dorm/laugh02", 0.5)
	var_0_38(var_60_0, function()
		Dorm.DormEntityManager.PlayEffectDetached(var_60_0, "gua_R_hand_bone", "Dorm/Effect/snowball/fx_snow_effect_liwu_boom", 2)
		manager.notify:Invoke(SNOWBALL_GAME_PLAYER_GET_BUFF, var_60_1, self:GetBuffDuration(var_60_1), (self:GetBuffFactor(var_60_1)))
	end)
end

function var_0_0:GuestLiftSign(arg_62_1)
	local var_62_0 = arg_62_1 and "Dorm/Effect/snowball/fx_snowball_hit_sign_head_shot" or "Dorm/Effect/snowball/fx_snowball_hit_sign"
	local var_62_1 = self:GetGuestEID()

	Dorm.DormEntityManager.PutEntityLookAt(var_62_1, self.guestSpawnPos.position, (var_0_19((self:GetPlayerEID()))))
	Dorm.DormEntityManager.StopAllCmd(var_62_1)
	Dorm.DormEntityManager.SendDoActionCMD(var_62_1, var_0_9, nil, false, 0, false)
	Dorm.DormEntityManager.ClearAllEffectOnAttachPoint(var_62_1, "gua_R_hand_bone")
	Dorm.DormEntityManager.PlayEffect(var_62_1, "gua_R_hand_bone", var_0_10, var_62_0, 3.5)
	self:GuestPlaySubtitle(arg_62_1 and "ACTIVITY_SNOWBALL_HIT_HEAD" or "ACTIVITY_SNOWBALL_HIT_BODY")
end

return var_0_0
