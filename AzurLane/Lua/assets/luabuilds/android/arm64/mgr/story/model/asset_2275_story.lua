class = var_0_10000

local var_0_0 = var_0_10000("Story")

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
	local var_1_0 = {}

	AsideStep = var_1_10002
	var_1_0[1] = var_1_10002
	DialogueStep = var_1_10002
	var_1_0[2] = var_1_10002
	BgStep = var_1_10002
	var_1_0[3] = var_1_10002
	CarouselStep = var_1_10002
	var_1_0[4] = var_1_10002
	VedioStep = var_1_10002
	var_1_0[5] = var_1_10002
	CastStep = var_1_10002
	var_1_0[6] = var_1_10002
	SpAnimStep = var_1_10002
	var_1_0[7] = var_1_10002
	BlinkStep = var_1_10002
	var_1_0[8] = var_1_10002
	TDDialogueStep = var_1_10002
	var_1_0[9] = var_1_10002
	SubPageStep = var_1_10002
	var_1_0[10] = var_1_10002

	return var_1_0[arg_1_0]
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

	local var_2_0

	if not arg_2_1.playType then
		var_2_0 = var_0_0.PLAY_TYPE_STORY
	end

	arg_2_0.playType = var_2_0
	arg_2_0.once = arg_2_1.once
	arg_2_0.fadeOut = arg_2_1.fadeOut
	defaultValue = var_7
	arg_2_0.hideSkip = var_7(arg_2_1.hideSkip, false)
	defaultValue = var_7
	arg_2_0.skipTip = var_7(arg_2_1.skipTip, true)
	defaultValue = var_7
	arg_2_0.noWaitFade = var_7(arg_2_1.noWaitFade, false)

	local var_2_1

	if not arg_2_1.dialogbox then
		var_2_1 = 1
	end

	arg_2_0.dialogueBox = var_2_1
	defaultValue = var_2_1
	arg_2_0.interaction = var_2_1(arg_2_1.interaction, false)
	arg_2_0.defaultTb = arg_2_1.defaultTb
	arg_2_0.placeholder = 0
	ipairs = var_7

	local var_2_2

	if not arg_2_1.placeholder then
		var_2_2 = {}
	end

	for iter_2_0, iter_2_1 in var_7(var_2_2) do
		local var_2_3

		if not var_0_0.PlaceholderMap[iter_2_1] then
			var_2_3 = 0
		end

		assert = var_1_10013

		var_1_10013(var_2_3 > 0, iter_2_1)

		bit = var_1_10013
		arg_2_0.placeholder = var_1_10013.bor(arg_2_0.placeholder, var_2_3)
	end

	defaultValue = var_7
	arg_2_0.hideRecord = var_7(arg_2_1.hideRecord, false)
	defaultValue = var_7
	arg_2_0.hideAutoBtn = var_7(arg_2_1.hideAuto, false)

	local var_2_4 = arg_2_0

	if arg_2_0.IsTDDMode(var_2_4) then
		defaultValue = var_7
		arg_2_0.storyAlpha = var_7(arg_2_1.alpha, 0)
	else
		defaultValue = var_7
		arg_2_0.storyAlpha = var_7(arg_2_1.alpha, 0.568)
	end

	UnGamePlayState = var_7

	if var_7 then
		local var_2_5

		if not arg_2_1.speed then
			var_2_5 = 0
		end

		arg_2_0.speedData = var_2_5
	else
		local var_2_7

		if not arg_2_1.speed then
			getProxy = var_2_7
			SettingsProxy = var_2_4

			local var_2_6 = var_2_7(var_2_4)

			if not var_2_7.GetStorySpeed(var_2_6) then
				var_2_7 = 0
			end
		end

		arg_2_0.speedData = var_2_7
	end

	arg_2_0.steps = {}

	local var_2_8 = 0
	local var_2_9 = arg_2_3 or {}
	local var_2_10 = {}

	arg_2_0.globalOptionBranchJump = {}
	ipairs = var_10

	local var_2_11

	if not arg_2_1.scripts then
		var_2_11 = {}
	end

	for iter_2_2, iter_2_3 in var_10(var_2_11) do
		local var_2_12

		if not iter_2_3.mode then
			var_2_12 = arg_2_0.mode
		end

		local var_2_13 = var_0_0.GetStoryStepCls(var_2_12).New(iter_2_3)

		if var_17.IsValid(var_2_13, arg_2_6) then
			if var_17:IsDialogueMode() and arg_2_0:IsDialogueStyle2() then
				var_17:SetDefaultSide()
			end

			var_17:SetId(iter_2_2)
			var_17:SetPlaceholderType(arg_2_0:GetPlaceholder())
			var_17:SetDefaultTb(arg_2_0.defaultTb)

			if var_17:ExistOption() then
				var_2_8 = var_2_8 + 1

				var_17:SetOptionIndex(var_2_8)

				if var_2_9[var_2_8] then
					var_17:SetOptionSelCodes(var_2_9[var_2_8])
				end

				if arg_2_4 then
					var_17.important = true
				end

				table = var_18

				var_18.insert(var_2_10, iter_2_2)

				if arg_2_5 then
					var_17:AutoShowOption()
				end
			end

			table = var_18

			var_18.insert(arg_2_0.steps, var_17)
		end

		if iter_2_3.globalOptionFlag and iter_2_3.jumpto then
			table = var_18

			var_18.insert(arg_2_0.globalOptionBranchJump, iter_2_3.jumpto)
		end
	end

	if #arg_2_0.steps > 0 then
		table = var_10

		var_10.insert(var_2_10, #arg_2_0.steps)
	end

	arg_2_0:HandleRecallOptions(var_2_10)

	arg_2_0.branchCode = nil
	arg_2_0.force = arg_2_2
	UnGamePlayState = var_10

	if var_10 then
		arg_2_0.isPlayed = false
	else
		pg = var_10

		local var_2_14 = var_10.NewStoryMgr.GetInstance()

		arg_2_0.isPlayed = var_10.IsPlayed(var_2_14, arg_2_0.name)
	end

	arg_2_0.nextScriptName = nil
	arg_2_0.skipAll = false
	arg_2_0.isAuto = false
	arg_2_0.speed = 0

	return
end

function var_0_0.IsTDDMode(arg_3_0)
	local var_3_0

	if arg_3_0.mode then
		var_3_0 = arg_3_0.mode == var_0_0.MODE_TDDIALOGUE
	end

	return var_3_0
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
	local function var_7_0(arg_8_0, arg_8_1)
		local var_8_0 = arg_7_0.steps[arg_8_0]
		local var_8_1 = {}

		for iter_8_0 = arg_8_0, arg_8_1 do
			local var_8_2 = arg_7_0.steps[iter_8_0]

			table = var_2_10009

			var_2_10009.insert(var_8_1, var_8_2)
		end

		local var_8_3 = var_8_0:GetOptionCnt()

		return {
			var_8_1,
			var_8_3,
			arg_8_1,
			arg_8_0
		}
	end

	local function var_7_1(arg_9_0)
		for iter_9_0 = arg_9_0, 1, -1 do
			if arg_7_0.steps[iter_9_0] and var_5.branchCode ~= nil then
				return iter_9_0
			end
		end

		assert = var_1

		var_1(false)

		return
	end

	local var_7_2 = {}

	ipairs = var_1_10005

	for iter_7_0, iter_7_1 in var_1_10005(arg_7_1) do
		local var_7_3 = arg_7_0.steps[iter_7_1]

		if var_10.IsRecallOption(var_7_3) then
			local var_7_4 = iter_7_1
			local var_7_5 = arg_7_1[iter_7_0 + 1]

			if var_7_4 and var_7_5 then
				local var_7_6 = var_7_1(var_7_5)

				table = var_13

				var_13.insert(var_7_2, var_7_0(var_7_4, var_7_6))
			end
		end
	end

	local var_7_7 = 0

	ipairs = var_6

	for iter_7_2, iter_7_3 in var_6(var_7_2) do
		local var_7_8 = iter_7_3[1]
		local var_7_9 = iter_7_3[2]
		local var_7_10 = iter_7_3[3]
		local var_7_11 = iter_7_3[4]

		for iter_7_4 = 1, var_7_9 - 1 do
			local var_7_12 = var_7_10 + var_7_7

			ipairs = var_1_10020

			for iter_7_5, iter_7_6 in var_1_10020(var_7_8) do
				Clone = var_1_10025

				local var_7_13 = var_1_10025(iter_7_6)

				var_1_10025.SetId(var_7_13, var_7_11)

				table = var_26

				var_26.insert(arg_7_0.steps, var_7_12 + iter_7_5, var_1_10025)
			end
		end

		var_7_7 = var_7_7 + (var_7_9 - 1) * #var_7_8
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
	switch = var_1_10001

	return var_1_10001(arg_17_0:GetDialogueStyleName(), {
		function()
			return "anim_storydialogue_optiontpl_"
		end,
		function()
			return "anim_newstory_dialogue2_"
		end
	})
end

function var_0_0.GetTriggerDelayTime(arg_20_0)
	table = var_1_10001

	if var_1_10001.indexof(var_0_0.STORY_AUTO_SPEED, arg_20_0.speed) then
		local var_20_0

		if not var_0_0.TRIGGER_DELAY_TIME[var_1] then
			var_20_0 = 0
		end

		return var_20_0
	end

	return 0
end

function var_0_0.SetAutoPlay(arg_21_0)
	arg_21_0.isAuto = true

	arg_21_0:SetPlaySpeed(arg_21_0.speedData)

	return
end

function var_0_0.UpdatePlaySpeed(arg_22_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_22_0 = var_1_10001(var_1_10003)
	local var_22_1

	if not var_1.GetStorySpeed(var_22_0) then
		var_22_1 = 0
	end

	arg_22_0:SetPlaySpeed(var_22_1)

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
	local var_32_0

	if not arg_32_0.force then
		var_32_0 = not arg_32_0.isPlayed
	end

	return var_32_0
end

function var_0_0.GetId(arg_33_0)
	return arg_33_0.name
end

function var_0_0.GetName(arg_34_0)
	return arg_34_0.name
end

function var_0_0.GetStepByIndex(arg_35_0, arg_35_1)
	if not arg_35_0.steps[arg_35_1] or arg_35_0.branchCode and not var_2:IsSameBranch(arg_35_0.branchCode) or var_2.globalBranchCode and not var_2:IsGlobalFlagHit() then
		return nil
	end

	return var_2
end

function var_0_0.GetNextStep(arg_36_0, arg_36_1)
	if arg_36_1 >= #arg_36_0.steps then
		return nil
	end

	local var_36_0 = arg_36_1 + 1

	if not arg_36_0:GetStepByIndex(var_36_0) and var_36_0 < #arg_36_0.steps then
		return arg_36_0:GetNextStep(var_36_0)
	else
		return var_3
	end

	return
end

function var_0_0.GetPrevStep(arg_37_0, arg_37_1)
	if arg_37_1 <= 1 then
		return nil
	end

	local var_37_0 = arg_37_1 - 1

	if not arg_37_0:GetStepByIndex(var_37_0) and var_37_0 > 1 then
		return arg_37_0:GetPrevStep(var_37_0)
	else
		return var_3
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
	local var_48_0 = {}

	ipairs = var_1_10002

	for iter_48_0, iter_48_1 in var_1_10002(arg_48_0.steps) do
		local var_48_1 = iter_48_1:GetUsingPaintingNames()

		ipairs = var_1_10008

		for iter_48_2, iter_48_3 in var_1_10008(var_48_1) do
			var_48_0[iter_48_3] = true
		end
	end

	local var_48_2 = {}

	pairs = var_3

	for iter_48_4, iter_48_5 in var_3(var_48_0) do
		table = var_1_10008

		var_1_10008.insert(var_48_2, iter_48_4)
	end

	return var_48_2
end

function var_0_0.GetAllStepDispatcherRecallName(arg_49_0)
	local var_49_0 = {}

	ipairs = var_1_10002

	for iter_49_0, iter_49_1 in var_1_10002(arg_49_0.steps) do
		if iter_49_1:GetDispatcherRecallName() then
			var_49_0[var_7] = true
		end
	end

	local var_49_1 = {}

	pairs = var_3

	for iter_49_2, iter_49_3 in var_3(var_49_0) do
		table = var_1_10008

		var_1_10008.insert(var_49_1, iter_49_2)
	end

	return var_49_1
end

function var_0_0.GlobalOptionBranch(arg_50_0)
	return arg_50_0.globalOptionBranchJump
end

return var_0_0
