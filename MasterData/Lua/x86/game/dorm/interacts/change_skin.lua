local function var_0_0(arg_1_0)
	if arg_1_0.newCharaEID then
		Dorm.DormEntityManager.Instance:RemoveEntity(arg_1_0.newCharaEID)
	end
end

local function var_0_1(arg_2_0, arg_2_1)
	if arg_2_0.newCharaEID then
		var_0_0(arg_2_0)
	end

	local var_2_1 = Dorm.DormEntityManager.Instance:SpawnPlayerEntity("CharDorm/" .. (arg_2_1.skinOverride and arg_2_1.skinOverride or nullable(BackHomeHeroSkinCfg, nullable(arg_2_1, "skinID"), "model")), nil)

	Dorm.storage:RecordData(DormEnum.Namespace.EntityData, var_2_1, {
		cfgID = arg_2_1.skinID,
		heroID = BackHomeHeroSkinCfg[arg_2_1.skinID].hero_id
	} or {})

	return var_2_1
end

local function var_0_2(arg_3_0, arg_3_1)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_3_0 = var_3_0 + iter_3_1
	end

	if var_3_0 > 0 then
		local var_3_1 = math.random() * var_3_0
		local var_3_2 = 1

		while var_3_1 > arg_3_1[var_3_2] do
			var_3_1 = var_3_1 - arg_3_1[var_3_2]
			var_3_2 = var_3_2 + 1
		end

		return arg_3_0[var_3_2], var_3_2
	end
end

local function var_0_3(arg_4_0)
	local var_4_0 = nullable(BackHomeHeroSkinVariantCfg, arg_4_0)

	if var_4_0 and math.random() <= var_4_0.chance then
		return var_0_2(var_4_0.asset_list, var_4_0.weight_list)
	end

	return nil
end

local function var_0_4(arg_5_0)
	local var_5_0 = DormHeroTools:GetDormHeroNextCanUseSkin(BackHomeHeroSkinCfg[arg_5_0].hero_id, arg_5_0)

	if var_5_0 == nil and nullable(BackHomeHeroSkinVariantCfg, BackHomeHeroSkinCfg[arg_5_0].hero_id) then
		local var_5_1 = var_0_3(BackHomeHeroSkinCfg[arg_5_0].hero_id)

		if var_5_1 then
			if Dorm.DormEntityManager.CheckIsVariant((DormCharacterManager.GetInstance():GetEntityID(arg_5_0))) then
				return BackHomeHeroSkinCfg[arg_5_0].hero_id, nil
			end

			return BackHomeHeroSkinCfg[arg_5_0].hero_id, var_5_1
		end
	end

	return var_5_0, var_0_3(var_5_0)
end

local var_0_5 = "change_skin_end"
local var_0_6 = {}

var_0_6.fps = 30
var_0_6.duration = 43 / var_0_6.fps
var_0_6.sequence = {
	[0] = function(arg_6_0)
		local var_6_0 = var_0_1(arg_6_0, {
			skinID = arg_6_0.nextSkin,
			skinOverride = arg_6_0.nextSkinOverride
		})

		Dorm.DormEntityManager.SetPlayerMainColliderEnabled(var_6_0, false)

		arg_6_0.newCharaEID = var_6_0

		Dorm.DormEntityManager:PutEntityAt(arg_6_0.entityID, "root")

		local var_6_1 = nullable(DormUtils.GetEntityData(arg_6_0.entityID), "interactCtx", "exitPos")

		DormUtils.SetEntityInteractContext(var_6_0, (DormCharacterInteractBehaviour.MakeCtxForInternalAction(var_6_0, arg_6_0.targetID, var_0_5, {
			oldCharaEID = arg_6_0.entityID,
			exitPos = var_6_1,
			startTime = nullable(arg_6_0.curActionTask, "taskDataCtx", "start"),
			callback = function(arg_7_0)
				if not arg_7_0 then
					DormCharacterManager.FindAndRemove(arg_6_0.entityID)

					local var_7_0, var_7_1 = DormCharacterManager.GetInstance():Generate(arg_6_0.nextSkin, true, {
						skinOverride = arg_6_0.nextSkinOverride
					}, {
						skinVariant = arg_6_0.nextSkinOverrideIdx
					})

					Dorm.DormEntityManager.PutEntityAt(var_7_0, var_6_0, "root")
					Dorm.DormEntityManager.SetPlayerMainColliderEnabled(var_7_0, true)
					Dorm.DormEntityManager.SendRndResumeWanderCMD(var_7_0, 1, true)
				end

				var_0_0(arg_6_0)
			end
		})))
		Dorm.DormEntityManager:TryExecuteInteractToEntityImmediate(arg_6_0.targetID)

		if var_6_1 then
			Dorm.DormEntityManager:SendMoveLookToDirCMD(var_6_1, true, true)
		end

		DormHeroAI:SwitchControl(arg_6_0.entityID, DormEnum.ControlType.Player)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_6_0.entityID, "dressingroom", "01", 0)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_6_0.targetID, "dressingroom", "01", 0)
	end,
	[1.18] = function(arg_8_0)
		Dorm.DormEntityManager.SetPlayerMainColliderEnabled(arg_8_0.entityID, false)
	end,
	[43 / var_0_6.fps] = function(arg_9_0)
		if arg_9_0.newCharaEID then
			Dorm.DormEntityManager.SetFadeCMD(arg_9_0.entityID, 0)
			Dorm.DormEntityManager.SetFadeCMD(arg_9_0.newCharaEID, 1)
			DormUtils.MuteEntitySubtitleBubble(arg_9_0.entityID)
			DormUtils.HideCharaSpecialVfx(arg_9_0.entityID)
		end
	end
}

function var_0_6.onAbort(arg_10_0)
	DormUtils.CallOnNextUpdate(function()
		if arg_10_0.newCharaEID then
			var_0_0(arg_10_0)
		end
	end)
end

function var_0_6.onComplete(arg_12_0)
	DormUtils.CallOnNextUpdate(function()
		return
	end)
end

local var_0_7 = {
	sequence = {
		[0] = function(arg_14_0)
			Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_14_0.entityID, "dressingroom", "02", 0)
			Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_14_0.targetID, "dressingroom", "02", 0)
		end
	}
}

var_0_7.duration = 3.467

local function var_0_8(arg_15_0)
	local var_15_0 = arg_15_0.entityCfg or DormUtils.GetEntityData(arg_15_0.entityID).cfgID
	local var_15_1, var_15_2, var_15_3 = var_0_4(var_15_0)

	if var_15_1 then
		arg_15_0.beforeSkin = var_15_0
		arg_15_0.nextSkin = var_15_1
		arg_15_0.nextSkinOverride = var_15_2
		arg_15_0.nextSkinOverrideIdx = var_15_3
		arg_15_0.continuous = true

		return var_0_6
	else
		arg_15_0.continuous = false

		return var_0_7
	end
end

return function(arg_16_0, arg_16_1)
	if arg_16_1 then
		return var_0_7
	end

	return DormCharacterInteractBehaviour.MakeInteractTask(var_0_8(arg_16_0), arg_16_0)
end
