local function var_0_0(arg_1_0)
	local var_1_0 = arg_1_0.newCharaEID

	if var_1_0 then
		Dorm.DormEntityManager.Instance:RemoveEntity(var_1_0)

		local var_1_1
	end
end

local function var_0_1(arg_2_0, arg_2_1)
	if arg_2_0.newCharaEID then
		var_0_0(arg_2_0)
	end

	local var_2_0

	if arg_2_1.skinOverride then
		var_2_0 = arg_2_1.skinOverride
	else
		var_2_0 = nullable(BackHomeHeroSkinCfg, nullable(arg_2_1, "skinID"), "model")
	end

	local var_2_1 = "CharDorm/" .. var_2_0
	local var_2_2 = Dorm.DormEntityManager.Instance:SpawnPlayerEntity(var_2_1, nil)
	local var_2_3 = DormEnum.Namespace.EntityData
	local var_2_4 = {
		cfgID = arg_2_1.skinID,
		heroID = BackHomeHeroSkinCfg[arg_2_1.skinID].hero_id
	}

	Dorm.storage:RecordData(var_2_3, var_2_2, var_2_4 or {})

	return var_2_2
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
	local var_5_0 = BackHomeHeroSkinCfg[arg_5_0].hero_id
	local var_5_1 = DormHeroTools:GetDormHeroNextCanUseSkin(var_5_0, arg_5_0)

	if var_5_1 == nil and nullable(BackHomeHeroSkinVariantCfg, var_5_0) then
		local var_5_2 = var_0_3(var_5_0)

		if var_5_2 then
			local var_5_3 = DormCharacterManager.GetInstance():GetEntityID(arg_5_0)

			if Dorm.DormEntityManager.CheckIsVariant(var_5_3) then
				return var_5_0, nil
			end

			return var_5_0, var_5_2
		end
	end

	return var_5_1, var_0_3(var_5_1)
end

local var_0_5 = "change_skin_end"
local var_0_6 = {}

var_0_6.fps = 30

local var_0_7 = 43 / var_0_6.fps
local var_0_8 = 1.18

var_0_6.duration = var_0_7
var_0_6.sequence = {
	[0] = function(arg_6_0)
		local var_6_0 = arg_6_0.nextSkin
		local var_6_1 = arg_6_0.entityID
		local var_6_2 = {
			skinID = var_6_0,
			skinOverride = arg_6_0.nextSkinOverride
		}
		local var_6_3 = var_0_1(arg_6_0, var_6_2)

		Dorm.DormEntityManager.SetPlayerMainColliderEnabled(var_6_3, false)

		local var_6_4 = var_6_3

		arg_6_0.newCharaEID = var_6_3

		local var_6_5 = DormUtils.GetEntityData(var_6_1)

		Dorm.DormEntityManager.PutEntityAt(var_6_4, var_6_1, "root")

		local var_6_6 = nullable(var_6_5, "interactCtx", "exitPos")
		local var_6_7 = DormCharacterInteractBehaviour.MakeCtxForInternalAction(var_6_4, arg_6_0.targetID, var_0_5, {
			oldCharaEID = var_6_1,
			exitPos = var_6_6,
			startTime = nullable(arg_6_0.curActionTask, "taskDataCtx", "start"),
			callback = function(arg_7_0)
				if not arg_7_0 then
					DormCharacterManager.FindAndRemove(arg_6_0.entityID)

					local var_7_0, var_7_1 = DormCharacterManager.GetInstance():Generate(arg_6_0.nextSkin, true, {
						skinOverride = arg_6_0.nextSkinOverride
					}, {
						skinVariant = arg_6_0.nextSkinOverrideIdx
					})

					Dorm.DormEntityManager.PutEntityAt(var_7_0, var_6_3, "root")
					Dorm.DormEntityManager.SetPlayerMainColliderEnabled(var_7_0, true)
					Dorm.DormEntityManager.SendRndResumeWanderCMD(var_7_0, 1, true)
				end

				var_0_0(arg_6_0)
			end
		})

		DormUtils.SetEntityInteractContext(var_6_4, var_6_7)
		Dorm.DormEntityManager.TryExecuteInteractToEntityImmediate(var_6_4, arg_6_0.targetID)

		if var_6_6 then
			Dorm.DormEntityManager.SendMoveLookToDirCMD(var_6_4, var_6_6, true, true)
		end

		DormHeroAI:SwitchControl(var_6_1, DormEnum.ControlType.Player)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_6_1, "dressingroom", "01", 0)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_6_0.targetID, "dressingroom", "01", 0)
	end,
	[var_0_8] = function(arg_8_0)
		local var_8_0 = arg_8_0.entityID

		Dorm.DormEntityManager.SetPlayerMainColliderEnabled(var_8_0, false)
	end,
	[var_0_7] = function(arg_9_0)
		if arg_9_0.newCharaEID then
			local var_9_0 = arg_9_0.entityID
			local var_9_1 = arg_9_0.newCharaEID

			Dorm.DormEntityManager.SetFadeCMD(var_9_0, 0)
			Dorm.DormEntityManager.SetFadeCMD(var_9_1, 1)
			DormUtils.MuteEntitySubtitleBubble(var_9_0)
			DormUtils.HideCharaSpecialVfx(var_9_0)
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

local var_0_9 = {
	sequence = {
		[0] = function(arg_14_0)
			Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_14_0.entityID, "dressingroom", "02", 0)
			Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_14_0.targetID, "dressingroom", "02", 0)
		end
	}
}

var_0_9.duration = 3.467

local function var_0_10(arg_15_0)
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

		return var_0_9
	end
end

return function(arg_16_0, arg_16_1)
	if arg_16_1 then
		return var_0_9
	end

	local var_16_0 = var_0_10(arg_16_0)

	return DormCharacterInteractBehaviour.MakeInteractTask(var_16_0, arg_16_0)
end
