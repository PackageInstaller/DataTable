local var_0_0 = {}
local var_0_1 = {
	AnyPeer = 2,
	Source = 0,
	Target = 1
}

local function var_0_2(arg_1_0, arg_1_1)
	if arg_1_0 == var_0_1.Source then
		return arg_1_1.entityID
	elseif arg_1_0 == var_0_1.Target then
		return arg_1_1.targetID
	elseif arg_1_1.peerIDs and #arg_1_1.peerIDs > 0 then
		return arg_1_1.peerIDs[math.random(#arg_1_1.peerIDs)]
	end

	return nil
end

local var_0_3 = {
	[0] = "music",
	"voice",
	"effect"
}
local var_0_4 = {
	play = function(arg_2_0, arg_2_1)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_0_2(arg_2_0.entity, arg_2_1), arg_2_0.animeActionName, arg_2_0.animeActionSubName, arg_2_0.crossFade)
	end,
	putAt = function(arg_3_0, arg_3_1)
		Dorm.DormEntityManager.PutEntityAt(var_0_2(arg_3_0.entity, arg_3_1), var_0_2(arg_3_0.referenceTarget, arg_3_1), arg_3_0.referencePointName)
	end,
	attachTo = function(arg_4_0, arg_4_1)
		Dorm.DormEntityManager.AttachToEntityCMD(var_0_2(arg_4_0.itemEntity, arg_4_1), var_0_2(arg_4_0.attachTo, arg_4_1), arg_4_0.attachPoint)
	end,
	detachFrom = function(arg_5_0, arg_5_1)
		Dorm.DormEntityManager.DetachFromEntityCMD(var_0_2(arg_5_0.itemEntity, arg_5_1), arg_5_0.resetFacingDirection)
	end,
	grabPart = function(arg_6_0, arg_6_1)
		Dorm.DormEntityManager.GrabItemPartCMD(var_0_2(arg_6_0.grabBy, arg_6_1), var_0_2(arg_6_0.grabFrom, arg_6_1), arg_6_0.itemPartName, arg_6_0.attachPoint)
	end,
	restorePart = function(arg_7_0, arg_7_1)
		Dorm.DormEntityManager.RestoreItemPartCMD(var_0_2(arg_7_0.itemPartHost, arg_7_1), arg_7_0.itemPartName)
	end,
	setPartVisible = function(arg_8_0, arg_8_1)
		Dorm.DormEntityManager.SetPartVisible(var_0_2(arg_8_0.entity, arg_8_1), arg_8_0.itemPartName, arg_8_0.visible)
	end,
	setEntityVisible = function(arg_9_0, arg_9_1)
		Dorm.DormEntityManager.SetEntityVisible(var_0_2(arg_9_0.entity, arg_9_1), arg_9_0.visible)
	end,
	changeScheme = function(arg_10_0, arg_10_1)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_0_2(arg_10_0.entity, arg_10_1), arg_10_0.scheme)
	end,
	setValue = function(arg_11_0, arg_11_1)
		local var_11_0 = var_0_2(arg_11_0.entity, arg_11_1)

		Dorm.storage:GetData(DormEnum.Namespace.EntityData, var_11_0)[arg_11_0.field] = arg_11_0.value
	end,
	setMobility = function(arg_12_0, arg_12_1)
		local var_12_0 = var_0_2(arg_12_0.entity, arg_12_1)

		Dorm.DormEntityManager.SetEntityMobility(var_12_0, arg_12_0.value)
	end,
	setMouth = function(arg_13_0, arg_13_1)
		local var_13_0 = var_0_2(arg_13_0.entity, arg_13_1)

		Dorm.DormEntityManager.SetFacialExpression(var_13_0, arg_13_0.value)
	end,
	restoreMouth = function(arg_14_0, arg_14_1)
		local var_14_0 = var_0_2(arg_14_0.entity, arg_14_1)

		Dorm.DormEntityManager.RestoreFacialExpression(var_14_0)
	end,
	setFace = function(arg_15_0, arg_15_1)
		local var_15_0 = var_0_2(arg_15_0.entity, arg_15_1)

		Dorm.DormEntityManager.PlayNormalFacileExpression(var_15_0, arg_15_0.faceEmoteState, arg_15_0.faceEmoteSubState, arg_15_0.crossFade)
	end,
	keepAsInteract = function(arg_16_0, arg_16_1)
		Dorm.DormEntityManager.KeepAsInteractNotEnd(var_0_2(arg_16_0.entity, arg_16_1), var_0_2(arg_16_0.target, arg_16_1), arg_16_0.value)
	end,
	setSpFace = function(arg_17_0, arg_17_1)
		local var_17_0 = var_0_2(arg_17_0.entity, arg_17_1)

		Dorm.DormEntityManager.PlaySpacialFacileExpression(var_17_0, arg_17_0.faceEfxPath, arg_17_0.duration)
	end,
	playEfx = function(arg_18_0, arg_18_1)
		local var_18_0 = var_0_2(arg_18_0.entity, arg_18_1)

		Dorm.DormEntityManager.PlayEffect(var_18_0, arg_18_0.attachPoint, arg_18_0.efxPath, arg_18_0.offset or Vector3.zero, arg_18_0.rotation or Quaternion.identity, arg_18_0.scale or Vector3.one, arg_18_0.duration)
	end,
	clearEfx = function(arg_19_0, arg_19_1)
		local var_19_0 = var_0_2(arg_19_0.entity, arg_19_1)

		Dorm.DormEntityManager.ClearInteractEffectOnAttachPoint(var_19_0, arg_19_0.attachPoint)
	end,
	playVoice = function(arg_20_0, arg_20_1)
		local var_20_0 = var_0_2(arg_20_0.entity, arg_20_1)
		local var_20_1 = manager.audio:Play(var_0_3[arg_20_0.playerType], arg_20_0.sheet, arg_20_0.cue, arg_20_0.awb)

		var_0_0.AddManagedResource(arg_20_1, var_20_1, var_20_1.Stop)
	end,
	stopVoice = function(arg_21_0, arg_21_1)
		manager.audio:Stop(var_0_3[arg_21_0.playerType])
	end,
	playSubtitle = function(arg_22_0, arg_22_1)
		local var_22_0 = var_0_2(arg_22_0.entity, arg_22_1)

		manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, var_22_0, arg_22_0.subtitleID)
	end
}

function var_0_0.DriveInteractSequenceNode(arg_23_0, arg_23_1)
	if type(arg_23_0) == "table" then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0) do
			if type(iter_23_1) == "table" then
				local var_23_0 = iter_23_1.action
				local var_23_1 = var_0_4[var_23_0]

				if var_23_1 then
					var_23_1(iter_23_1, arg_23_1)
				end
			else
				iter_23_1(arg_23_1)
			end
		end
	elseif type(arg_23_0) == "function" then
		arg_23_0(arg_23_1)
	end
end

local function var_0_5(arg_24_0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_24_0)
end

local function var_0_6(arg_25_0, arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(arg_25_0) do
		table.insert(var_25_0, iter_25_0)
	end

	table.sort(var_25_0, arg_25_1)

	return var_25_0
end

function var_0_0.MakeInteractTask(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0 then
		local var_26_0 = arg_26_0.sequence
		local var_26_1 = arg_26_0.duration
		local var_26_2 = arg_26_0.keys or var_0_6(var_26_0)

		arg_26_1.duration = var_26_1
		arg_26_2 = arg_26_2 or DormCharacterActionManager.frameTaskRunner

		local var_26_3 = arg_26_2:NewTask({
			start = arg_26_1.startTime or arg_26_2:Now()
		})

		var_26_3:WaitUntil(function(arg_27_0)
			local var_27_0 = arg_27_0.taskDataCtx.task.taskRunner
			local var_27_1 = arg_27_0.taskDataCtx.start
			local var_27_2 = arg_27_0.k
			local var_27_3 = var_27_0:Now() - var_27_1

			while var_27_2 <= #var_26_2 and var_27_3 >= var_26_2[var_27_2] do
				local var_27_4 = var_26_0[var_26_2[var_27_2]]

				var_0_0.DriveInteractSequenceNode(var_27_4, arg_26_1)

				var_27_2 = var_27_2 + 1
			end

			arg_27_0.k = var_27_2
			arg_26_1.playTime = var_27_3

			return var_27_2 > #var_26_2 or var_27_3 >= var_26_1
		end, false, {
			k = 1
		})
		var_26_3:WaitUntil(function(arg_28_0)
			local var_28_0 = arg_28_0.taskDataCtx.task.taskRunner
			local var_28_1 = arg_28_0.taskDataCtx.start

			arg_26_1.playTime = var_28_0:Now() - var_28_1

			return arg_26_1.playTime >= var_26_1
		end)

		if arg_26_0.onAbort then
			var_26_3:SetOnAbort(function()
				arg_26_0.onAbort(arg_26_1)
			end)
		end

		if arg_26_0.onComplete then
			var_26_3:SetOnComplete(function()
				arg_26_1.playTime = arg_26_1.duration

				arg_26_0.onComplete(arg_26_1)
			end)
		end

		return var_26_3
	end
end

function var_0_0.Cleanup(arg_31_0)
	if arg_31_0.resources then
		for iter_31_0, iter_31_1 in pairs(arg_31_0.resources) do
			if iter_31_1.Cleanup then
				iter_31_1.Cleanup(iter_31_1.res)
			end
		end

		arg_31_0.resources = nil
	end
end

function var_0_0.AddManagedResource(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0.resources then
		arg_32_0.resources = {}
	end

	table.insert(arg_32_0.resources, {
		Cleanup = arg_32_2,
		res = arg_32_1
	})
end

local function var_0_7(arg_33_0, arg_33_1)
	local var_33_0 = nullable(DormUtils.GetEntityData(arg_33_0), "interactEntities") or {}

	table.insert(var_33_0, arg_33_1)

	return var_33_0
end

local function var_0_8(arg_34_0, arg_34_1)
	local var_34_0 = nullable(DormUtils.GetEntityData(arg_34_0), "interactEntities")

	if var_34_0 then
		for iter_34_0 = #var_34_0, 1, -1 do
			if var_34_0[iter_34_0] == arg_34_1 then
				table.remove(var_34_0, iter_34_0)

				break
			end
		end
	end
end

local function var_0_9(arg_35_0, arg_35_1, arg_35_2)
	Dorm.DormEntityManager.KeepAsInteractNotEnd(arg_35_1.entityID, arg_35_1.targetID, false)

	local var_35_0 = arg_35_1.entityID
	local var_35_1 = DormUtils.GetEntityData(var_35_0)

	var_35_1.isDuringInteract = true
	arg_35_1.peers = var_0_7(arg_35_1.targetID, arg_35_1.entityID)

	arg_35_0:SetCancellationSrc(function()
		return arg_35_2.canceled
	end)

	local var_35_2 = arg_35_0.onComplete

	arg_35_0:SetOnComplete(function()
		if Dorm.DormEntityManager.IsValidEntityID(var_35_0) then
			var_0_8(arg_35_1.targetID, var_35_0)

			if arg_35_1.continuous then
				Dorm.DormEntityManager.KeepAsInteractNotEnd(var_35_0, arg_35_1.targetID, true)

				var_35_1.isDuringInteract = true
			else
				var_35_1.isDuringInteract = false

				DormUtils.ShowCharaSpecialVfx(var_35_0, Dorm.charaVfxActiveType)
				DormUtils.SetEntityInteractContext(var_35_0, nil)
			end
		end

		arg_35_2:Notify(true)

		if var_35_2 then
			var_35_2(arg_35_1)
		end

		var_0_0.Cleanup(arg_35_1)
	end)

	local var_35_3 = arg_35_0.onAbort

	arg_35_0:SetOnAbort(function()
		if Dorm.DormEntityManager.IsValidEntityID(var_35_0) then
			DormUtils.SetEntityInteractContext(var_35_0, nil)

			if var_35_1.isDuringInteract then
				var_35_1.isDuringInteract = false

				DormUtils.ShowCharaSpecialVfx(var_35_0, Dorm.charaVfxActiveType)
			end

			var_0_8(arg_35_1.targetID, var_35_0)
		end

		arg_35_2:Notify(false)

		if var_35_3 then
			var_35_3(arg_35_1)
		end

		var_0_0.Cleanup(arg_35_1)
	end)

	arg_35_1.curActionTask = arg_35_0

	DormUtils.HideCharaSpecialVfx(var_35_0)
	arg_35_0:Start(arg_35_1.waitOneTick)

	return arg_35_0
end

local function var_0_10(arg_39_0)
	return nullable(DormInteractSequence, arg_39_0, "name")
end

function var_0_0.GetNextAction(arg_40_0, arg_40_1)
	local var_40_0 = nullable(DormInteractSequence, arg_40_0, "next_action")

	if var_40_0 and next(var_40_0) then
		local var_40_1 = var_40_0[math.random(#var_40_0)]

		return true, nullable(var_40_1, 1), nullable(var_40_1, 2)
	end

	return false
end

function var_0_0.MakeCtx(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_2 or {}

	var_41_0.entityID = arg_41_0
	var_41_0.targetID = arg_41_1

	return var_41_0
end

function var_0_0.MakeDefaultCtx(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0, var_42_1, var_42_2 = var_0_0.GetNextAction(arg_42_2, arg_42_3)
	local var_42_3 = {
		nextAction = var_42_1,
		nextActionWaitTime = var_42_2,
		continuous = var_42_0
	}

	if arg_42_4 ~= nil then
		for iter_42_0, iter_42_1 in pairs(arg_42_4) do
			var_42_3[iter_42_0] = iter_42_1
		end
	end

	return (var_0_0.MakeCtx(arg_42_0, arg_42_1, var_42_3))
end

local function var_0_11(arg_43_0, arg_43_1)
	if type(arg_43_0) == "function" then
		return arg_43_0(arg_43_1)
	else
		return var_0_0.MakeInteractTask(arg_43_0, arg_43_1)
	end
end

function var_0_0.MakeCtxForInternalAction(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	arg_44_3 = arg_44_3 or {}

	local var_44_0 = nullable(var_0_5(arg_44_0), "cfgID")
	local var_44_1 = nullable(var_0_5(arg_44_1), "cfgID")

	arg_44_3.entityCfg, arg_44_3.targetCfg = var_44_0, var_44_1

	local var_44_2 = var_0_0.GetSequence(var_44_0, var_44_1, arg_44_2)
	local var_44_3 = var_0_0.MakeCtx(arg_44_0, arg_44_1, arg_44_3)

	var_44_3.curActionTask = var_0_11(var_44_2, var_44_3)

	return var_44_3, var_44_2
end

local var_0_12 = -1
local var_0_13
local var_0_14

local function var_0_15(arg_45_0)
	local var_45_0 = var_0_14[arg_45_0]

	if type(var_45_0) == "function" then
		return var_0_0.SimpleCustomInteractAction(var_45_0)
	end

	return var_45_0
end

function var_0_0.ValidateAction(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = var_0_10(arg_46_2)

	return var_0_0.GetSequence(arg_46_0, arg_46_1, var_46_0) or var_0_15(arg_46_2)
end

function var_0_0.Interact(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = var_0_5(arg_47_0).interactCtx
	local var_47_1 = nullable(var_47_0, "curActionTask")

	if not var_47_1 then
		local var_47_2 = var_0_0.ValidateAction(arg_47_0, arg_47_1, arg_47_3)

		var_47_0 = var_47_0 or var_0_0.MakeDefaultCtx(arg_47_0, arg_47_1, arg_47_3, var_47_2)
		var_47_1 = var_47_0.curActionTask or var_0_11(var_47_2, var_47_0)
	end

	if var_47_1 then
		var_0_9(var_47_1, var_47_0, arg_47_2)
	else
		arg_47_2:Notify(false)
	end
end

function var_0_0.SendInternalInteract(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = DormCharacterInteractBehaviour.MakeCtxForInternalAction(arg_48_0, arg_48_1, arg_48_2)

	Dorm.DormEntityManager.SendInteractToEntityCMD(arg_48_0, arg_48_1, arg_48_3)
	DormUtils.SetEntityInteractContext(arg_48_0, var_48_0)
end

function var_0_0.SendCustomInteract(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = var_0_13[arg_49_2]

	if var_49_0 == nil then
		var_49_0 = var_0_12
		var_0_13[arg_49_2] = var_49_0
		var_0_14[var_49_0] = arg_49_2
		var_0_12 = var_0_12 - 1
	end

	Dorm.DormEntityManager.SendInteractToEntityCMD(arg_49_0, arg_49_1, var_49_0, arg_49_3)
end

function var_0_0.SimpleCustomInteractAction(arg_50_0)
	return {
		duration = 0,
		sequence = {
			[0] = arg_50_0
		}
	}
end

local function var_0_16(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	if arg_51_2 then
		table.insert(arg_51_0, string.format("%s.%s.%d_%s", arg_51_3, arg_51_1, arg_51_2, arg_51_4))
	end

	table.insert(arg_51_0, string.format("%s.%s.%s", arg_51_3, arg_51_1, arg_51_4))
end

function var_0_0.GetSequencePath(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	arg_52_3 = arg_52_3 or "game.dorm.interacts"

	if arg_52_2 ~= nil then
		local var_52_0 = DormUtils.GetEntityData(arg_52_0)
		local var_52_1 = DormUtils.GetEntityData(arg_52_1)
		local var_52_2 = nullable(var_52_0, "cfgID")
		local var_52_3 = nullable(var_52_1, "cfgID")
		local var_52_4 = {}

		if var_52_2 then
			local var_52_5 = BackHomeHeroSkinCfg[var_52_2]
			local var_52_6 = nullable(var_52_5, "hero_id") or var_52_2
			local var_52_7 = var_52_0.style or nullable(var_52_5, "style")
			local var_52_8 = var_52_0.skinVariant

			if var_52_8 then
				local var_52_9 = string.format("%d_%02d", var_52_2, var_52_8)

				var_0_16(var_52_4, var_52_9, var_52_3, arg_52_3, arg_52_2)
			end

			var_0_16(var_52_4, var_52_2, var_52_3, arg_52_3, arg_52_2)
			table.insert(var_52_4, string.format("%s.%d.%s", arg_52_3, var_52_6, arg_52_2))

			if var_52_7 then
				table.insert(var_52_4, string.format("%s.%s.%s", arg_52_3, var_52_7, arg_52_2))
			end
		end

		table.insert(var_52_4, string.format("%s.%s", arg_52_3, arg_52_2))

		return var_52_4
	end
end

function var_0_0.GetSequenceGroup(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	arg_53_4 = arg_53_4 or Dorm.InteractionGrouping

	local var_53_0 = var_0_0.GetSequencePath(arg_53_0, arg_53_1, arg_53_2, arg_53_3)

	if var_53_0 then
		for iter_53_0, iter_53_1 in ipairs(var_53_0) do
			local var_53_1 = arg_53_4[iter_53_1]

			if var_53_1 then
				return var_53_1
			end
		end
	end
end

function var_0_0.GetSequence(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	local var_54_0 = var_0_0.GetSequencePath(arg_54_0, arg_54_1, arg_54_2, arg_54_3)

	arg_54_4 = arg_54_4 or Dorm.InteractionGrouping

	if var_54_0 then
		for iter_54_0, iter_54_1 in ipairs(var_54_0) do
			local var_54_1 = package.loaded[iter_54_1]

			if var_54_1 == nil then
				local var_54_2 = arg_54_4[iter_54_1]

				if var_54_2 then
					var_54_1 = var_54_2[math.random(#var_54_2)]
				end
			end

			if var_54_1 then
				return var_54_1
			end
		end
	end
end

function var_0_0.Init(arg_55_0)
	var_0_13, var_0_14 = {}, {}

	manager.notify:RegistListener(ON_DORM_CHARACTER_INTERACT, arg_55_0.Interact)
	manager.notify:RegistListener(ON_DORM_CHARACTER_GRAB_STARTED, arg_55_0.OnCharaGrab)
	manager.notify:RegistListener(ON_DORM_CHARACTER_INTERACT_ABORTED, arg_55_0.OnInteractAborted)
	manager.notify:RegistListener(DORM_ENTITY_REMOVED, arg_55_0.OnEntityRemoved)
end

function var_0_0.Reset(arg_56_0)
	var_0_13, var_0_14 = nil

	manager.notify:RemoveListener(ON_DORM_CHARACTER_INTERACT, arg_56_0.Interact)
	manager.notify:RemoveListener(ON_DORM_CHARACTER_GRAB_STARTED, arg_56_0.OnCharaGrab)
	manager.notify:RemoveListener(ON_DORM_CHARACTER_INTERACT_ABORTED, arg_56_0.OnInteractAborted)
	manager.notify:RemoveListener(DORM_ENTITY_REMOVED, arg_56_0.OnEntityRemoved)
end

function var_0_0.OnCharaGrab(arg_57_0)
	local var_57_0 = DormUtils.GetEntityData(arg_57_0)

	if var_57_0.isDuringInteract then
		DormUtils.ShowCharaSpecialVfx(arg_57_0, Dorm.charaVfxActiveType)

		var_57_0.isDuringInteract = false
	end
end

function var_0_0.OnInteractAborted(arg_58_0, arg_58_1)
	local var_58_0 = DormUtils.GetEntityData(arg_58_0)

	if var_58_0 == nil then
		return
	end

	local var_58_1 = nullable(var_58_0, "interactCtx", "curActionTask")

	if var_58_1 then
		var_58_1:Abort()
	end

	DormUtils.SetEntityInteractContext(arg_58_0, nil)
end

function var_0_0.OnEntityRemoved(arg_59_0)
	return
end

return var_0_0
