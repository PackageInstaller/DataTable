local var_0_0 = class("Story")

var_0_0.MODE_ASIDE = 1
var_0_0.MODE_DIALOGUE = 2
var_0_0.MODE_BG = 3
var_0_0.MODE_CAROUSE = 4
var_0_0.MODE_VEDIO = 5
var_0_0.MODE_CAST = 6
var_0_0.MODE_SPANIM = 7
var_0_0.MODE_BLINK = 8
var_0_0.MODE_TDDIALOGUE = 9
var_0_0.MODE_SUBPAGE = 10
var_0_0.STORY_AUTO_SPEED = {
	-9,
	0,
	5,
	9
}
var_0_0.TRIGGER_DELAY_TIME = {
	4,
	3,
	1.5,
	0
}

function var_0_0.GetStoryStepCls(arg_1_0)
	return ({
		AsideStep,
		DialogueStep,
		BgStep,
		CarouselStep,
		VedioStep,
		CastStep,
		SpAnimStep,
		BlinkStep,
		TDDialogueStep,
		SubPageStep
	})[arg_1_0]
end

var_0_0.PLAYER = 2
var_0_0.TB = 4
var_0_0.DORM = 8
var_0_0.CAR2026 = 16
var_0_0.PlaceholderMap = {
	playername = var_0_0.PLAYER,
	tb = var_0_0.TB,
	dorm3d = var_0_0.DORM,
	car2026 = var_0_0.CAR2026
}
var_0_0.PLAY_TYPE_STORY = 1
var_0_0.PLAY_TYPE_BUBBLE = 2

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	arg_2_0.name = arg_2_1.id
	arg_2_0.mode = arg_2_1.mode
	arg_2_0.playType = arg_2_1.playType or var_0_0.PLAY_TYPE_STORY
	arg_2_0.once = arg_2_1.once
	arg_2_0.fadeOut = arg_2_1.fadeOut
	arg_2_0.hideSkip = defaultValue(arg_2_1.hideSkip, false)
	arg_2_0.skipTip = defaultValue(arg_2_1.skipTip, true)
	arg_2_0.noWaitFade = defaultValue(arg_2_1.noWaitFade, false)
	arg_2_0.dialogueBox = arg_2_1.dialogbox or 1
	arg_2_0.interaction = defaultValue(arg_2_1.interaction, false)
	arg_2_0.defaultTb = arg_2_1.defaultTb
	arg_2_0.placeholder = 0

	local var_2_0 = arg_2_1.placeholder or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = var_0_0.PlaceholderMap[iter_2_1] or 0

		assert(var_2_1 > 0, iter_2_1)

		arg_2_0.placeholder = bit.bor(arg_2_0.placeholder, var_2_1)
	end

	arg_2_0.hideRecord = defaultValue(arg_2_1.hideRecord, false)
	arg_2_0.hideAutoBtn = defaultValue(arg_2_1.hideAuto, false)
	arg_2_0.storyAlpha = arg_2_0:IsTDDMode() and defaultValue(arg_2_1.alpha, 0) or defaultValue(arg_2_1.alpha, 0.568)

	if UnGamePlayState then
		arg_2_0.speedData = arg_2_1.speed or 0
	else
		local var_2_2 = arg_2_1.speed

		if not arg_2_1.speed then
			var_2_2 = getProxy(SettingsProxy):GetStorySpeed()
			var_2_2 = var_2_2 or 0
		end

		arg_2_0.speedData = var_2_2
	end

	arg_2_0.steps = {}

	local var_2_3 = 0
	local var_2_4 = arg_2_3 or {}
	local var_2_5 = {}

	arg_2_0.globalOptionBranchJump = {}

	local var_2_6 = arg_2_1.scripts or {}

	for iter_2_2, iter_2_3 in ipairs(var_2_6) do
		local var_2_8 = var_0_0.GetStoryStepCls(var_2_7).New(iter_2_3)

		if var_2_8:IsValid(arg_2_6) then
			if var_2_8:IsDialogueMode() and arg_2_0:IsDialogueStyle2() then
				var_2_8:SetDefaultSide()
			end

			var_2_8:SetId(iter_2_2)
			var_2_8:SetPlaceholderType(arg_2_0:GetPlaceholder())
			var_2_8:SetDefaultTb(arg_2_0.defaultTb)

			if var_2_8:ExistOption() then
				var_2_3 = var_2_3 + 1

				var_2_8:SetOptionIndex(var_2_3)

				if var_2_4[var_2_3] then
					var_2_8:SetOptionSelCodes(var_2_4[var_2_3])
				end

				if arg_2_4 then
					var_2_8.important = true
				end

				table.insert(var_2_5, iter_2_2)

				if arg_2_5 then
					var_2_8:AutoShowOption()
				end
			end

			table.insert(arg_2_0.steps, var_2_8)
		end

		if iter_2_3.globalOptionFlag and iter_2_3.jumpto then
			table.insert(arg_2_0.globalOptionBranchJump, iter_2_3.jumpto)
		end
	end

	if #arg_2_0.steps > 0 then
		table.insert(var_2_5, #arg_2_0.steps)
	end

	arg_2_0:HandleRecallOptions(var_2_5)

	arg_2_0.branchCode = nil
	arg_2_0.force = arg_2_2

	if UnGamePlayState then
		arg_2_0.isPlayed = false
	else
		arg_2_0.isPlayed = pg.NewStoryMgr.GetInstance():IsPlayed(arg_2_0.name)
	end

	arg_2_0.nextScriptName = nil
	arg_2_0.skipAll = false
	arg_2_0.isAuto = false
	arg_2_0.speed = 0

	return
end

function var_0_0.IsTDDMode(arg_3_0)
	return arg_3_0.mode and arg_3_0.mode == var_0_0.MODE_TDDIALOGUE
end

function var_0_0.GetPlayType(arg_4_0)
	return arg_4_0.playType
end

function var_0_0.IsBubbleType(arg_5_0)
	return arg_5_0.playType == var_0_0.PLAY_TYPE_BUBBLE
end

function var_0_0.CanInteraction(arg_6_0)
	return arg_6_0.interaction
end

function var_0_0.HandleRecallOptions(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if arg_7_0.steps[iter_7_1]:IsRecallOption() then
			if iter_7_1 and arg_7_1[iter_7_0 + 1] then
				table.insert({}, (function(arg_8_0, arg_8_1)
					for iter_8_0 = arg_8_0, arg_8_1 do
						table.insert({}, arg_7_0.steps[iter_8_0])
					end

					return {
						{},
						arg_7_0.steps[arg_8_0]:GetOptionCnt(),
						arg_8_1,
						arg_8_0
					}
				end)(iter_7_1, ((function(arg_9_0)
					for iter_9_0 = arg_9_0, 1, -1 do
						if arg_7_0.steps[iter_9_0] and arg_7_0.steps[iter_9_0].branchCode ~= nil then
							return iter_9_0
						end
					end

					assert(false)

					return
				end)(arg_7_1[iter_7_0 + 1]))))
			end
		end
	end

	for iter_7_2, iter_7_3 in ipairs({}) do
		for iter_7_4 = 1, iter_7_3[2] - 1 do
			for iter_7_5, iter_7_6 in ipairs(iter_7_3[1]) do
				local var_7_1 = Clone(iter_7_6)

				var_7_1:SetId(iter_7_3[4])
				table.insert(arg_7_0.steps, iter_7_3[3] + 0 + iter_7_5, var_7_1)
			end
		end
	end

	return
end

function var_0_0.GetPlaceholder(arg_10_0)
	return arg_10_0.placeholder
end

function var_0_0.ShouldReplaceContent(arg_11_0)
	return arg_11_0.placeholder > 0
end

function var_0_0.GetStoryAlpha(arg_12_0)
	return arg_12_0.storyAlpha
end

function var_0_0.ShouldHideAutoBtn(arg_13_0)
	return arg_13_0.hideAutoBtn
end

function var_0_0.ShouldHideRecord(arg_14_0)
	return arg_14_0.hideRecord
end

function var_0_0.GetDialogueStyleName(arg_15_0)
	return arg_15_0.dialogueBox
end

function var_0_0.IsDialogueStyle2(arg_16_0)
	return arg_16_0:GetDialogueStyleName() == 2
end

function var_0_0.GetAnimPrefix(arg_17_0)
	return switch(arg_17_0:GetDialogueStyleName(), {
		function()
			return "anim_storydialogue_optiontpl_"
		end,
		function()
			return "anim_newstory_dialogue2_"
		end
	})
end

function var_0_0.GetTriggerDelayTime(arg_20_0)
	local var_20_0 = table.indexof(var_0_0.STORY_AUTO_SPEED, arg_20_0.speed)

	if var_20_0 then
		return var_0_0.TRIGGER_DELAY_TIME[var_20_0] or 0
	end

	return 0
end

function var_0_0.SetAutoPlay(arg_21_0)
	arg_21_0.isAuto = true

	arg_21_0:SetPlaySpeed(arg_21_0.speedData)

	return
end

function var_0_0.UpdatePlaySpeed(arg_22_0)
	local var_22_0 = getProxy(SettingsProxy):GetStorySpeed()

	var_22_0 = var_22_0 or 0

	arg_22_0:SetPlaySpeed(var_22_0)

	return
end

function var_0_0.GetPlaySpeed(arg_23_0)
	return arg_23_0.speed
end

function var_0_0.StopAutoPlay(arg_24_0)
	arg_24_0.isAuto = false

	arg_24_0:ResetSpeed()

	return
end

function var_0_0.SetPlaySpeed(arg_25_0, arg_25_1)
	arg_25_0.speed = arg_25_1

	return
end

function var_0_0.ResetSpeed(arg_26_0)
	arg_26_0.speed = 0

	return
end

function var_0_0.GetPlaySpeed(arg_27_0)
	return arg_27_0.speed
end

function var_0_0.GetAutoPlayFlag(arg_28_0)
	return arg_28_0.isAuto
end

function var_0_0.ShowSkipTip(arg_29_0)
	return arg_29_0.skipTip
end

function var_0_0.ShouldWaitFadeout(arg_30_0)
	return not arg_30_0.noWaitFade
end

function var_0_0.ShouldHideSkip(arg_31_0)
	return arg_31_0.hideSkip
end

function var_0_0.CanPlay(arg_32_0)
	return arg_32_0.force or not arg_32_0.isPlayed
end

function var_0_0.GetId(arg_33_0)
	return arg_33_0.name
end

function var_0_0.GetName(arg_34_0)
	return arg_34_0.name
end

function var_0_0.GetStepByIndex(arg_35_0, arg_35_1)
	if not arg_35_0.steps[arg_35_1] or arg_35_0.branchCode and not arg_35_0.steps[arg_35_1]:IsSameBranch(arg_35_0.branchCode) or arg_35_0.steps[arg_35_1].globalBranchCode and not arg_35_0.steps[arg_35_1]:IsGlobalFlagHit() then
		return nil
	end

	return arg_35_0.steps[arg_35_1]
end

function var_0_0.GetNextStep(arg_36_0, arg_36_1)
	if arg_36_1 >= #arg_36_0.steps then
		return nil
	end

	local var_36_0 = arg_36_1 + 1
	local var_36_1 = arg_36_0:GetStepByIndex(arg_36_1 + 1)

	if not var_36_1 and var_36_0 < #arg_36_0.steps then
		return arg_36_0:GetNextStep(var_36_0)
	else
		return var_36_1
	end

	return
end

function var_0_0.GetPrevStep(arg_37_0, arg_37_1)
	if arg_37_1 <= 1 then
		return nil
	end

	local var_37_0 = arg_37_1 - 1
	local var_37_1 = arg_37_0:GetStepByIndex(arg_37_1 - 1)

	if not var_37_1 and var_37_0 > 1 then
		return arg_37_0:GetPrevStep(var_37_0)
	else
		return var_37_1
	end

	return
end

function var_0_0.ShouldFadeout(arg_38_0)
	return arg_38_0.fadeOut ~= nil
end

function var_0_0.GetFadeoutTime(arg_39_0)
	return arg_39_0.fadeOut
end

function var_0_0.IsPlayed(arg_40_0)
	return arg_40_0.isPlayed
end

function var_0_0.SetBranchCode(arg_41_0, arg_41_1)
	arg_41_0.branchCode = arg_41_1

	return
end

function var_0_0.GetBranchCode(arg_42_0)
	return arg_42_0.branchCode
end

function var_0_0.GetNextScriptName(arg_43_0)
	return arg_43_0.nextScriptName
end

function var_0_0.SetNextScriptName(arg_44_0, arg_44_1)
	arg_44_0.nextScriptName = arg_44_1

	return
end

function var_0_0.SkipAll(arg_45_0)
	arg_45_0.skipAll = true

	return
end

function var_0_0.StopSkip(arg_46_0)
	arg_46_0.skipAll = false

	return
end

function var_0_0.ShouldSkipAll(arg_47_0)
	return arg_47_0.skipAll
end

function var_0_0.GetUsingPaintingNames(arg_48_0)
	for iter_48_0, iter_48_1 in ipairs(arg_48_0.steps) do
		for iter_48_2, iter_48_3 in ipairs((iter_48_1:GetUsingPaintingNames())) do
			({})[iter_48_3] = true
		end
	end

	for iter_48_4, iter_48_5 in pairs({}) do
		table.insert({}, iter_48_4)
	end

	return {}
end

function var_0_0.GetAllStepDispatcherRecallName(arg_49_0)
	for iter_49_0, iter_49_1 in ipairs(arg_49_0.steps) do
		local var_49_0 = iter_49_1:GetDispatcherRecallName()

		if var_49_0 then
			({})[var_49_0] = true
		end
	end

	for iter_49_2, iter_49_3 in pairs({}) do
		table.insert({}, iter_49_2)
	end

	return {}
end

function var_0_0.GlobalOptionBranch(arg_50_0)
	return arg_50_0.globalOptionBranchJump
end

return var_0_0
