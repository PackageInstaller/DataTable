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
local var_0_13 = 0.1
local var_0_14 = 0.7
local var_0_15 = 1.6
local var_0_16 = 1
local var_0_17 = "idle"
local var_0_18 = "happy"

local function var_0_19(...)
	return DormCharacterActionManager.frameTaskRunner:NewTask(...)
end

local var_0_20 = Dorm.LuaBridge.MiniGameBridge.PlayEffect
local var_0_21 = Dorm.DormEntityManager.QueryPosition
local var_0_22 = Dorm.DormEntityManager.QueryForwardDir
local var_0_23 = Dorm.DormEntityManager.QueryEntityAttachPointWorldPos

function var_0_0.Ctor(arg_7_0)
	local var_7_0 = EntityManager.CreateModel.New(var_0_2, var_0_3, var_0_12)

	arg_7_0.entityManager = EntityManager.New(var_7_0)

	local var_7_1 = EntityManager.CreatePlayer.New(var_0_2, var_0_3)

	function arg_7_0.entityManager.OnCreate(arg_8_0, arg_8_1)
		Dorm.DormEntityManager.PlayEffect(arg_8_1, "root", var_0_10, "Dorm/Effect/snowball/fx_snow_effect_spawn", 1)
		Dorm.DormEntityManager.SetFadeCMD(arg_8_1, 0)
		var_0_19():WaitForSec(0.25):Then(function()
			if Dorm.DormEntityManager.IsValidEntityID(arg_8_1) then
				Dorm.DormEntityManager.SetFadeCMD(arg_8_1, 1)
			end
		end):Start()
	end

	function arg_7_0.entityManager.OnRemove(arg_10_0, arg_10_1)
		if DormUtils.GetEntityData(arg_10_1).isHumanoidTarget then
			Dorm.DormEntityManager.StartFadeOutCMD(arg_10_1, var_0_12)
		else
			Dorm.DormEntityManager.SetFadeCMD(arg_10_1, 0)
		end

		Dorm.DormEntityManager.PlayEffectDetached(arg_10_1, "root", "Dorm/Effect/snowball/fx_snow_effect_death", 1)
	end

	arg_7_0.playerManager = EntityManager.New(var_7_1)

	function arg_7_0.playerManager.OnRemove(arg_11_0, arg_11_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_11_1)
	end

	arg_7_0.managers = {
		arg_7_0.entityManager,
		arg_7_0.playerManager
	}
	arg_7_0.listener = EventListener.New()
end

function var_0_0.Init(arg_12_0)
	arg_12_0.targetIdx = 0
	arg_12_0.shootSpeedFactor = 1
	arg_12_0.playerSpawnPos = Dorm.storage:PickData("snowball.pos.player").transform
	arg_12_0.guestSpawnPos = Dorm.storage:PickData("snowball.pos.guest").transform

	arg_12_0.listener:Register(SNOWBALL_GAME_AIM_FINISH, handler(arg_12_0, arg_12_0.OnSnowballAimFinish))
	arg_12_0.listener:Register(SNOWBALL_GAME_TARGET_NEW_WAVE, handler(arg_12_0, arg_12_0.SpawnTarget))
	arg_12_0.listener:Register(SNOWBALL_GAME_INFINITY_POOL_CLICK_MODEL, handlerArg1(arg_12_0, arg_12_0.PlayerPlayAction, var_0_17))
	arg_12_0.listener:Register(SNOWBALL_GAME_INFINITY_POOL_CLICK_ICE, handlerArg1(arg_12_0, arg_12_0.PlayerPlayAction, var_0_18))
	arg_12_0.listener:Register(ON_BEGIN_STORY, handler(arg_12_0, arg_12_0.OnBeginStory))
	arg_12_0.listener:Register(ON_FINISH_STORY, handler(arg_12_0, arg_12_0.OnFinishStory))
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.listener:RemoveAll()
	arg_13_0.entityManager:Clear(true)
	arg_13_0.playerManager:Clear(true)

	arg_13_0.targetIdx = nil
end

function var_0_0.OnBeginStory(arg_14_0, arg_14_1)
	if DormEnum.HasFlag(arg_14_1, DormEnum.BeginStoryFlag.HideCharacter) then
		arg_14_0.playerManager:Clear(true)
	end
end

function var_0_0.OnFinishStory(arg_15_0, arg_15_1)
	if DormEnum.HasFlag(arg_15_1, DormEnum.BeginStoryFlag.HideCharacter) then
		arg_15_0:SetPlayer(arg_15_0.player)
		arg_15_0:SetGuest(arg_15_0.guest)
	end
end

function var_0_0.PlayerPlayAction(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:GetPlayerEID()

	if arg_16_2 then
		Dorm.DormEntityManager.StopAllCmd(var_16_0)
	end

	Dorm.DormEntityManager.SendDoActionCMD(var_16_0, arg_16_1, false)
end

local function var_0_24(arg_17_0, arg_17_1)
	Dorm.DormEntityManager.SetEntitySpeed(arg_17_0, arg_17_1)

	DormUtils.GetEntityData(arg_17_0).speed = arg_17_1
end

local var_0_25 = {
	Guest = 4,
	Player = 0,
	RewardTarget = 2,
	NormalTarget = 1,
	PanishTarget = 3
}

local function var_0_26(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2 and arg_18_2 ~= 0 then
		local var_18_0 = var_0_4(arg_18_2, arg_18_1)
		local var_18_1 = var_18_0.unit_type == var_0_25.PanishTarget

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
		var_0_24(var_18_2, var_18_0.speed)

		return var_18_2
	end
end

local function var_0_27(arg_19_0, arg_19_1)
	if DormUtils.GetEntityData(arg_19_1).type == "target" then
		SnowballGameTargetAI.GetInstance():Remove(arg_19_1)

		local var_19_0 = DormUtils.GetEntityData(arg_19_1)
		local var_19_1 = var_0_4(var_19_0.cfgID)

		arg_19_0.targetCountByType[var_19_1.unit_type] = arg_19_0.targetCountByType[var_19_1.unit_type] - 1
		arg_19_0.targetCountByRow[var_19_0.row] = arg_19_0.targetCountByRow[var_19_0.row] - 1
	end

	EntityManager.FindAndRemoveEntity(arg_19_0.managers, arg_19_1)
end

function var_0_0.GetNormalTargetCount(arg_20_0)
	return nullable(arg_20_0.targetCountByType, var_0_25.NormalTarget) or 0
end

function var_0_0.GetRewardTargetCount(arg_21_0)
	return nullable(arg_21_0.targetCountByType, var_0_25.RewardTarget) or 0
end

function var_0_0.GetPanishTargetCount(arg_22_0)
	return nullable(arg_22_0.targetCountByType, var_0_25.PanishTarget) or 0
end

local var_0_28 = -1
local var_0_29 = -2

function var_0_0.SetPlayer(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetPlayerEID()

	if var_23_0 then
		var_0_0.ClearVfxOnEntity(var_23_0)
		arg_23_0.playerManager:Remove(var_0_28)
	end

	arg_23_0.player = arg_23_1

	if arg_23_1 == nil then
		return
	end

	local var_23_1 = var_0_4(arg_23_1)
	local var_23_2 = arg_23_0.playerManager:Create(var_0_28, {
		complex = true,
		model = var_23_1.model,
		spawnAt = arg_23_0.playerSpawnPos
	}, {
		type = "player",
		cfgID = var_23_1.id
	})
	local var_23_3 = UnityEngine.Camera.main

	Dorm.DormEntityManager.PlayerControlEntity(var_23_2, var_23_3 and var_23_3.transform.forward or Vector3(0, 0, -1))
	Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(var_23_2, true)
	Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_23_2, "snowball_move_L")
	var_0_24(var_23_2, var_23_1.speed)
	var_0_0.CreateHoldSnowballVfx(var_23_2)
end

function var_0_0.SetGuest(arg_24_0, arg_24_1)
	arg_24_0.guest = arg_24_1

	if arg_24_1 == nil then
		return
	end

	arg_24_0.playerManager:Remove(var_0_29)

	local var_24_0 = var_0_4(arg_24_1)
	local var_24_1 = arg_24_0.playerManager:Create(var_0_29, {
		complex = true,
		model = var_24_0.model,
		spawnAt = arg_24_0.guestSpawnPos
	}, {
		row = 0,
		type = "guest",
		cfgID = arg_24_1
	})

	Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(var_24_1, false)
	var_0_24(var_24_1, var_24_0.speed)
end

function var_0_0.RemoveGuest(arg_25_0)
	arg_25_0.guest = nil

	arg_25_0.playerManager:Remove(var_0_29)
end

function var_0_0.ClearAllTargets(arg_26_0)
	SnowballGameTargetAI.GetInstance():Clear()
	arg_26_0.entityManager:Clear(true)

	arg_26_0.targetCountByType = {}
	arg_26_0.targetCountByRow = {}
end

local var_0_30 = {
	var_0_25.NormalTarget,
	var_0_25.RewardTarget,
	var_0_25.PanishTarget
}

function var_0_0.SetLevel(arg_27_0, arg_27_1)
	arg_27_0:ClearAllTargets()

	arg_27_0.level = arg_27_1

	local var_27_0 = SnowballGameCfg[arg_27_1]

	arg_27_0.targets = {}

	for iter_27_0, iter_27_1 in ipairs(var_27_0.enemy_set) do
		local var_27_1 = var_0_30[iter_27_0]

		arg_27_0.targets[var_27_1] = {
			total = iter_27_1[1],
			weight = iter_27_1[2]
		}
	end

	arg_27_0.buffList, arg_27_0.debuffList = var_27_0.level_buff, var_27_0.level_debuff

	arg_27_0:SetGuest(var_0_5(var_27_0.hero_id))
end

local function var_0_31(arg_28_0, arg_28_1)
	local var_28_0 = SnowballGameCfg[arg_28_0]

	if arg_28_1 == var_0_25.NormalTarget then
		return var_28_0.enemy_normal
	elseif arg_28_1 == var_0_25.RewardTarget then
		return var_28_0.enemy_reward
	elseif arg_28_1 == var_0_25.PanishTarget then
		return var_28_0.enemy_punish
	end
end

local function var_0_32(arg_29_0)
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

local function var_0_33(arg_30_0)
	local var_30_0 = DormUtils.GetEntityData(arg_30_0).cfgID

	return nullable(var_0_4(var_30_0), "unit_type") == var_0_25.PanishTarget
end

local function var_0_34(arg_31_0)
	local var_31_0 = DormUtils.GetEntityData(arg_31_0).cfgID

	return nullable(var_0_4(var_31_0), "unit_type") == var_0_25.RewardTarget
end

function var_0_0.GetEachWaveGenLimitPerRow(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = SnowballGameCfg[arg_32_0.level]

	return nullable(var_32_0.refresh_enemy, arg_32_1, arg_32_2) or math.huge
end

function var_0_0.GetTotalGenLimit(arg_33_0)
	return GameSetting.activity_snowball_maxsnowman.value[1]
end

local function var_0_35(arg_34_0)
	return string.format("snowball.pos.row%d", arg_34_0)
end

local function var_0_36(arg_35_0)
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

function var_0_0.SpawnTarget(arg_36_0, arg_36_1)
	local var_36_0 = false

	if arg_36_1 == 0 then
		local var_36_1 = SnowballGameCfg[arg_36_0.level].snowman_pos

		for iter_36_0, iter_36_1 in ipairs(var_36_1) do
			for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
				local var_36_2 = nullable(Dorm.storage:GetData(var_0_35(iter_36_0), iter_36_3[2]), "transform")

				if var_36_2 then
					local var_36_3 = var_0_26(arg_36_0, iter_36_0, iter_36_3[1], var_36_2)

					var_36_0 = var_36_0 or var_36_3 ~= nil
				end
			end
		end
	else
		if arg_36_0.targets == nil then
			return
		end

		for iter_36_4 = 1, var_0_6 do
			local var_36_4 = 0
			local var_36_5 = var_0_36(var_0_35(iter_36_4))

			for iter_36_5, iter_36_6 in ipairs(var_36_5) do
				local var_36_6 = iter_36_6.transform
				local var_36_7 = Dorm.LuaBridge.MiniGameBridge.CheckPosBlocked(var_36_6.position)
				local var_36_8 = arg_36_0.targetCountByRow[iter_36_4] or 0

				if not var_36_7 and var_36_4 < arg_36_0:GetEachWaveGenLimitPerRow(arg_36_1, iter_36_4) and var_36_8 < arg_36_0:GetTotalGenLimit() then
					local var_36_9 = var_0_32(arg_36_0)

					if var_36_9 then
						arg_36_0.targets[var_36_9].total = math.max(0, arg_36_0.targets[var_36_9].total - 1)

						local var_36_10 = var_0_26(arg_36_0, iter_36_4, var_0_5(var_0_31(arg_36_0.level, var_36_9)), var_36_6)

						var_36_0 = var_36_0 or var_36_10 ~= nil
						var_36_4 = var_36_4 + 1
					elseif var_36_4 == 0 then
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

function var_0_0.GetPlayerEID(arg_37_0)
	return arg_37_0.playerManager:GetEntityID(var_0_28)
end

function var_0_0.GetPlayerCfgID(arg_38_0)
	return arg_38_0.player
end

function var_0_0.GetGuestEID(arg_39_0)
	return arg_39_0.playerManager:GetEntityID(var_0_29)
end

function var_0_0.GetGuestCfgID(arg_40_0)
	return arg_40_0.guest
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

local var_0_37 = {
	[2] = 1,
	[3] = 4
}
local var_0_38 = {
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

			local var_45_0 = var_0_21(arg_45_0.entityID)
			local var_45_1

			if Dorm.DormEntityManager.INVALID_ENTITY_ID == arg_45_0.targetID then
				Dorm.DormEntityManager.PlayEffect(arg_45_0.entityID, "gua_biaoqing_bone", var_0_10, "Dorm/Effect/tongyong/fx_jingxia_0501", Vector3(-0.25, 0.25, 0), Quaternion.Euler(0, 0, 60), Vector3.one, 0.25)

				if arg_45_0.hitPos:Magnitude() ~= math.huge then
					var_45_1 = Quaternion.LookRotation(arg_45_0.hitPos - var_45_0)
				else
					var_45_1 = Quaternion.LookRotation(var_0_22(arg_45_0.entityID))
				end

				var_0_20(var_45_0, var_45_1, Vector3.one, "Dorm/Effect/snowball/fx_snow_effect_xueqiu2", 1)
			else
				local var_45_2 = var_0_21(arg_45_0.targetID)
				local var_45_3 = nullable(var_0_37, DormUtils.GetEntityData(arg_45_0.targetID).row) or 0

				var_45_2.y = var_45_2.y + var_45_3

				local var_45_4 = Quaternion.LookRotation(var_45_2 - var_45_0)

				var_0_20(var_45_0, var_45_4, Vector3.one, "Dorm/Effect/snowball/fx_snow_effect_xueqiu", 0.167)
			end
		end,
		[var_0_14 - var_0_13] = function(arg_46_0)
			local var_46_0 = SnowballGameMgr.GetInstance()

			if arg_46_0.targetID == var_46_0:GetPlayerEID() or arg_46_0.targetID == var_46_0:GetGuestEID() then
				Dorm.DormEntityManager.PlayEffect(arg_46_0.targetID, "gua_biaoqing_bone", var_0_10, "Dorm/Effect/tongyong/fx_jingxia_0501", Vector3(-0.25, 0.25, 0), Quaternion.Euler(0, 0, 60), Vector3.one, 0.25)
			end
		end,
		[var_0_14] = function(arg_47_0)
			if arg_47_0.hitAction then
				arg_47_0.hitAction()
			end
		end,
		[1.433] = function(arg_48_0)
			Dorm.DormEntityManager.SetCurInteractToLowPriority(arg_48_0.entityID)
		end
	}
}

local function var_0_39(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	Dorm.DormEntityManager.StopAllCmd(arg_49_0)

	local var_49_0 = DormCharacterInteractBehaviour.MakeCtx(arg_49_0, arg_49_0, {
		hitAction = arg_49_3,
		hitPos = arg_49_2,
		_targetID = arg_49_1
	})

	var_49_0.curActionTask = DormCharacterInteractBehaviour.MakeInteractTask(var_0_38, var_49_0)

	DormUtils.SetEntityInteractContext(arg_49_0, var_49_0)
	Dorm.DormEntityManager.SendInteractToEntityCMD(arg_49_0, arg_49_0, false)
end

local function var_0_40(arg_50_0, arg_50_1)
	Dorm.DormEntityManager.StopAllCmd(arg_50_0)
	Dorm.DormEntityManager.SendDoActionCMD(arg_50_0, var_0_8, nil, false, 0, false)
	Dorm.DormEntityManager.PlayEffect(arg_50_0, "gua_R_hand_bone", var_0_10, "Dorm/Effect/snowball/fx_snow_effect_liwu", 2.833)
	var_0_19():WaitForSec(var_0_15):Then(arg_50_1):Start()
end

function var_0_0.GuestPlaySubtitle(arg_51_0, arg_51_1)
	arg_51_1 = GetTips(arg_51_1)

	manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, arg_51_0:GetGuestEID(), arg_51_1)
end

local function var_0_41(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	if arg_52_1 == Dorm.DormEntityManager.INVALID_ENTITY_ID then
		return
	end

	var_0_20(arg_52_2, "Dorm/Effect/snowball/fx_snow_effect_snowhit", 1)

	local var_52_0 = DormUtils.GetEntityData(arg_52_1)
	local var_52_1 = var_52_0.type

	if var_52_1 == "target" then
		arg_52_0:OnSnowballHitTarget(arg_52_1, var_52_0, arg_52_2, arg_52_3)
	elseif var_52_1 == "guest" then
		var_0_1("minigame_activity_2_6_snowball_hit04")
		manager.notify:Invoke(SNOWBALL_GAME_PLAYER_HIT_GUEST)
		arg_52_0:GuestPlaySubtitle("ACTIVITY_SNOWBALL_HIT_NPC_TALK01")
		arg_52_0:GuestBeatPlayer()
	end
end

function var_0_0.OnSnowballAimFinish(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	local var_53_0 = arg_53_0:GetPlayerEID()

	DormLuaBridge.ResetJoystick(false)
	var_0_0.ClearVfxOnEntity(var_53_0)
	var_0_39(var_53_0, arg_53_1, arg_53_2, function()
		var_0_0.ClearVfxOnEntity(var_53_0)
		var_0_0.CreateHoldSnowballVfx(var_53_0)

		if arg_53_2:Magnitude() ~= math.huge then
			var_0_41(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
		end
	end)
end

function var_0_0.OnSnowballHitTarget(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	local var_55_0 = arg_55_2.cfgID
	local var_55_1 = arg_55_0.lockHeadShot or arg_55_4 == "head"

	if DormUtils.GetEntityData(arg_55_1).isHumanoidTarget then
		Dorm.DormEntityManager.PlaySpacialFacileExpression(arg_55_1, "Effect/Dorm/faint01", 1)
	end

	local var_55_2 = var_55_1 and "minigame_activity_2_6_snowball_hit01" or "minigame_activity_2_6_snowball_hit02"

	var_0_1(var_55_2)

	if var_0_33(arg_55_1) then
		arg_55_0:GuestPlaySubtitle("ACTIVITY_SNOWBALL_HIT_PUNISH_TALK01")
		arg_55_0:GuestBeatPlayer()
	elseif var_0_34(arg_55_1) then
		arg_55_0:GuestSendGift()
	else
		arg_55_0:GuestLiftSign(var_55_1)
	end

	manager.notify:Invoke(SNOWBALL_GAME_HIT, arg_55_2, var_55_1, arg_55_3)
	var_0_27(arg_55_0, arg_55_1)
end

function var_0_0.GetBuffFactor(arg_56_0, arg_56_1)
	return SnowballGameCfg[arg_56_0.level].buff_intensity[arg_56_1]
end

function var_0_0.GetBuffDuration(arg_57_0, arg_57_1)
	local var_57_0 = SnowballGameCfg[arg_57_0.level].buff_duration[arg_57_1]

	if type(var_57_0) == "table" then
		return var_57_0[1] + (var_57_0[2] - var_57_0[1]) * math.random()
	else
		return var_57_0
	end
end

function var_0_0.GuestBeatPlayer(arg_58_0)
	local var_58_0 = arg_58_0:GetPlayerEID()
	local var_58_1 = arg_58_0:GetGuestEID()
	local var_58_2 = var_0_5(arg_58_0.debuffList)
	local var_58_3 = var_0_21(var_58_0)

	Dorm.DormEntityManager.PutEntityLookAt(var_58_1, arg_58_0.guestSpawnPos.position, var_58_3)
	Dorm.DormEntityManager.PlaySpacialFacileExpression(var_58_1, "Effect/Dorm/anger03", 0.5)
	var_0_39(var_58_1, var_58_0, var_0_23(var_58_0, "gua_Hit"), function()
		local var_59_0 = arg_58_0:GetBuffDuration(var_58_2)
		local var_59_1 = arg_58_0:GetBuffFactor(var_58_2)

		manager.notify:Invoke(SNOWBALL_GAME_PLAYER_GET_BUFF, var_58_2, var_59_0, var_59_1)
	end)
end

function var_0_0.GuestSendGift(arg_60_0)
	var_0_1("minigame_activity_2_6_snowball_present")

	local var_60_0 = arg_60_0:GetPlayerEID()
	local var_60_1 = arg_60_0:GetGuestEID()
	local var_60_2 = var_0_5(arg_60_0.buffList)
	local var_60_3 = var_0_21(var_60_0)

	Dorm.DormEntityManager.ClearAllEffectOnAttachPoint(var_60_1, "gua_R_hand_bone")
	Dorm.DormEntityManager.PutEntityLookAt(var_60_1, arg_60_0.guestSpawnPos.position, var_60_3)
	Dorm.DormEntityManager.PlaySpacialFacileExpression(var_60_1, "Effect/Dorm/laugh02", 0.5)
	var_0_40(var_60_1, function()
		Dorm.DormEntityManager.PlayEffectDetached(var_60_1, "gua_R_hand_bone", "Dorm/Effect/snowball/fx_snow_effect_liwu_boom", 2)

		local var_61_0 = arg_60_0:GetBuffDuration(var_60_2)
		local var_61_1 = arg_60_0:GetBuffFactor(var_60_2)

		manager.notify:Invoke(SNOWBALL_GAME_PLAYER_GET_BUFF, var_60_2, var_61_0, var_61_1)
	end)
end

function var_0_0.GuestLiftSign(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_1 and "Dorm/Effect/snowball/fx_snowball_hit_sign_head_shot" or "Dorm/Effect/snowball/fx_snowball_hit_sign"
	local var_62_1 = arg_62_0:GetPlayerEID()
	local var_62_2 = arg_62_0:GetGuestEID()
	local var_62_3 = var_0_21(var_62_1)

	Dorm.DormEntityManager.PutEntityLookAt(var_62_2, arg_62_0.guestSpawnPos.position, var_62_3)
	Dorm.DormEntityManager.StopAllCmd(var_62_2)
	Dorm.DormEntityManager.SendDoActionCMD(var_62_2, var_0_9, nil, false, 0, false)
	Dorm.DormEntityManager.ClearAllEffectOnAttachPoint(var_62_2, "gua_R_hand_bone")
	Dorm.DormEntityManager.PlayEffect(var_62_2, "gua_R_hand_bone", var_0_10, var_62_0, 3.5)
	arg_62_0:GuestPlaySubtitle(arg_62_1 and "ACTIVITY_SNOWBALL_HIT_HEAD" or "ACTIVITY_SNOWBALL_HIT_BODY")
end

return var_0_0
