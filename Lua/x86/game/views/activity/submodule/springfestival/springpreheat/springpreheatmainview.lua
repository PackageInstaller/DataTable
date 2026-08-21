local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("SpringPreheatMainView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeMainUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activityId_ = arg_2_2

	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_0:GetActivityID())
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.letterController = ControllerUtil.GetController(arg_3_0.letterBtn_.transform, "state")
	arg_3_0.rewardController = ControllerUtil.GetController(arg_3_0.rewardBtn_.transform, "reward")
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.prayBtn_, nil, function()
		local var_6_0 = SpringPreheatData:GetLetterStorage()
		local var_6_1 = arg_5_0:GetMaxLetterCount()

		if not SpringPreheatData:IsTodayWritten() and var_6_0 < var_6_1 then
			ShowTips("SPRING_PREHEAT_LETTER_NOT_WRITE")

			return
		end

		JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatPray", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.letterBtn_, nil, function()
		arg_5_0:OnClickLetterBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("springPreheatReward", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.descBtn_, nil, function()
		local var_9_0 = "SPRING_PREHEAT_LETTER_DESC"
		local var_9_1 = GetTips(var_9_0)

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_9_1,
			key = var_9_0
		})
	end)
end

function var_0_1.OnEnter(arg_10_0)
	var_0_1.super.OnEnter(arg_10_0)

	local var_10_0 = arg_10_0:GetActivityID()
	local var_10_1 = ActivityTools.GetRedPointKey(var_10_0) .. var_10_0

	manager.redPoint:bindUIandKey(arg_10_0.letterBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, var_10_1))
	manager.redPoint:bindUIandKey(arg_10_0.prayBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, var_10_1))
	manager.redPoint:bindUIandKey(arg_10_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, var_10_1))
	arg_10_0:AddTimer()
	arg_10_0:RefreshUI()
end

function var_0_1.OnTop(arg_11_0)
	arg_11_0:RefreshUI()
end

function var_0_1.OnExit(arg_12_0)
	var_0_1.super.OnExit(arg_12_0)

	local var_12_0 = arg_12_0:GetActivityID()
	local var_12_1 = ActivityTools.GetRedPointKey(var_12_0) .. var_12_0

	manager.redPoint:unbindUIandKey(arg_12_0.letterBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, var_12_1))
	manager.redPoint:unbindUIandKey(arg_12_0.prayBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, var_12_1))
	manager.redPoint:unbindUIandKey(arg_12_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, var_12_1))
	arg_12_0:StopTimer()
end

function var_0_1.RefreshUI(arg_13_0)
	arg_13_0:RefreshTimeUI()

	local var_13_0 = SpringPreheatData:GetLetterStorage()
	local var_13_1 = SpringPreheatData:GetActivityDay()
	local var_13_2 = SpringPreheatData:HasRewardCanAcquire()
	local var_13_3 = #SpringPreheatData:GetProgressRewardList()
	local var_13_4 = arg_13_0:GetMaxLetterCount()

	arg_13_0.letterInfoText_.text = string.format("%d/%d", var_13_0, var_13_4)
	arg_13_0.rewardInfoText_.text = string.format("%d/%d", arg_13_0:GetAcquiredCount(), var_13_3)

	arg_13_0.rewardController:SetSelectedState(var_13_2 and "true" or "false")

	local var_13_5 = false

	if var_13_0 == var_13_4 then
		arg_13_0.letterController:SetSelectedState("max")
	elseif SpringPreheatData:IsTodayWritten() then
		arg_13_0.letterController:SetSelectedState("written")
	else
		arg_13_0.letterController:SetSelectedState("write")

		local var_13_6 = true
	end

	SpringPreheatAction:UpdateRedPoint(arg_13_0:GetActivityID())
end

function var_0_1.RefreshTimeUI(arg_14_0)
	local var_14_0 = ActivityData:GetActivityData(arg_14_0:GetActivityID())
	local var_14_1 = var_14_0.startTime
	local var_14_2 = var_14_0.stopTime

	arg_14_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_14_2, true)
end

function var_0_1.AddTimer(arg_15_0)
	arg_15_0:StopTimer()

	arg_15_0.timer_ = Timer.New(function()
		arg_15_0:RefreshUI()
	end, 1, -1)

	arg_15_0.timer_:Start()
end

function var_0_1.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_1.OnClickLetterBtn(arg_18_0)
	if SpringPreheatData:IsTodayWritten() then
		ShowTips("SPRING_PREHEAT_LETTER_WRITTEN")

		return
	end

	local var_18_0 = arg_18_0:GetMaxLetterCount()
	local var_18_1 = SpringPreheatData:GetLetterStorage()

	if var_18_1 == 0 then
		local var_18_2 = GameSetting.spring_preheat_2_8_story.value[1]

		if var_18_2 and not manager.story:IsStoryPlayed(var_18_2) then
			arg_18_0:Go("/springPreheatBlank")
			manager.story:StartStoryById(var_18_2, function(arg_19_0)
				JumpTools.OpenPageByJump("/springPreheatEditLetter", {})
			end)

			return
		end
	end

	if var_18_1 == var_18_0 then
		ShowTips("SPRING_PREHEAT_LETTER_MAX")

		return
	end

	JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatEditLetter", {})
end

function var_0_1.GetActivityID(arg_20_0)
	return arg_20_0.activityId_
end

function var_0_1.GetAcquiredCount(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs(SpringPreheatData:GetProgressRewardList()) do
		if SpringPreheatData:IsAcquired(iter_21_1.id) then
			var_21_0 = var_21_0 + 1
		end
	end

	return var_21_0
end

function var_0_1.IsPraySelected(arg_22_0)
	return SpringPreheatData:GetCurSelectionDay() >= SpringPreheatData:GetActivityDay()
end

function var_0_1.GetDays(arg_23_0)
	return SpringPreheatData:GetMaxProgress()
end

function var_0_1.GetMaxLetterCount(arg_24_0)
	local var_24_0 = SpringPreheatData:GetActivityTotalDay()

	return math.min(arg_24_0:GetDays(), var_24_0)
end

return var_0_1
