local SpringPreheatMainView = class("SpringPreheatMainView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function SpringPreheatMainView:GetUIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeMainUI"
end

function SpringPreheatMainView:Ctor(arg_2_1, arg_2_2)
	self.activityId_ = arg_2_2

	SpringPreheatMainView.super.Ctor(self, arg_2_1, self:GetActivityID())
end

function SpringPreheatMainView:Init()
	self:InitUI()
	self:AddUIListener()

	self.letterController = ControllerUtil.GetController(self.letterBtn_.transform, "state")
	self.rewardController = ControllerUtil.GetController(self.rewardBtn_.transform, "reward")
end

function SpringPreheatMainView:InitUI()
	self:BindCfgUI()
end

function SpringPreheatMainView:AddUIListener()
	self:AddBtnListener(self.prayBtn_, nil, function()
		if not SpringPreheatData:IsTodayWritten() and SpringPreheatData:GetLetterStorage() < self:GetMaxLetterCount() then
			ShowTips("SPRING_PREHEAT_LETTER_NOT_WRITE")

			return
		end

		JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatPray", {})
	end)
	self:AddBtnListener(self.letterBtn_, nil, function()
		self:OnClickLetterBtn()
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("springPreheatReward", {})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		local var_9_0 = {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("SPRING_PREHEAT_LETTER_DESC")
		}

		var_9_0.key = "SPRING_PREHEAT_LETTER_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_9_0)
	end)
end

function SpringPreheatMainView:OnEnter()
	SpringPreheatMainView.super.OnEnter(self)

	local var_10_0 = self:GetActivityID()
	local var_10_1 = ActivityTools.GetRedPointKey(var_10_0) .. var_10_0

	manager.redPoint:bindUIandKey(self.letterBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, var_10_1))
	manager.redPoint:bindUIandKey(self.prayBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, var_10_1))
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, var_10_1))
	self:AddTimer()
	self:RefreshUI()
end

function SpringPreheatMainView:OnTop()
	self:RefreshUI()
end

function SpringPreheatMainView:OnExit()
	SpringPreheatMainView.super.OnExit(self)

	local var_12_0 = self:GetActivityID()
	local var_12_1 = ActivityTools.GetRedPointKey(var_12_0) .. var_12_0

	manager.redPoint:unbindUIandKey(self.letterBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, var_12_1))
	manager.redPoint:unbindUIandKey(self.prayBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, var_12_1))
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, var_12_1))
	self:StopTimer()
end

function SpringPreheatMainView:RefreshUI()
	self:RefreshTimeUI()

	local var_13_0 = SpringPreheatData:GetLetterStorage()
	local var_13_1 = SpringPreheatData:GetActivityDay()
	local var_13_2 = SpringPreheatData:HasRewardCanAcquire()
	local var_13_3 = self:GetMaxLetterCount()

	self.letterInfoText_.text = string.format("%d/%d", var_13_0, var_13_3)
	self.rewardInfoText_.text = string.format("%d/%d", self:GetAcquiredCount(), #SpringPreheatData:GetProgressRewardList())

	self.rewardController:SetSelectedState(var_13_2 and "true" or "false")

	if var_13_0 == var_13_3 then
		self.letterController:SetSelectedState("max")
	elseif SpringPreheatData:IsTodayWritten() then
		self.letterController:SetSelectedState("written")
	else
		self.letterController:SetSelectedState("write")
	end

	SpringPreheatAction:UpdateRedPoint(self:GetActivityID())
end

function SpringPreheatMainView:RefreshTimeUI()
	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(self:GetActivityID()).stopTime, true)
end

function SpringPreheatMainView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:RefreshUI()
	end, 1, -1)

	self.timer_:Start()
end

function SpringPreheatMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SpringPreheatMainView:OnClickLetterBtn()
	if SpringPreheatData:IsTodayWritten() then
		ShowTips("SPRING_PREHEAT_LETTER_WRITTEN")

		return
	end

	local var_18_0 = self:GetMaxLetterCount()
	local var_18_1 = SpringPreheatData:GetLetterStorage()

	if var_18_1 == 0 then
		if GameSetting.spring_preheat_2_8_story.value[1] and not manager.story:IsStoryPlayed(GameSetting.spring_preheat_2_8_story.value[1]) then
			self:Go("/springPreheatBlank")
			manager.story:StartStoryById(GameSetting.spring_preheat_2_8_story.value[1], function(arg_19_0)
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

function SpringPreheatMainView:GetActivityID()
	return self.activityId_
end

function SpringPreheatMainView:GetAcquiredCount()
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs(SpringPreheatData:GetProgressRewardList()) do
		if SpringPreheatData:IsAcquired(iter_21_1.id) then
			var_21_0 = var_21_0 + 1
		end
	end

	return var_21_0
end

function SpringPreheatMainView:IsPraySelected()
	return SpringPreheatData:GetCurSelectionDay() >= SpringPreheatData:GetActivityDay()
end

function SpringPreheatMainView:GetDays()
	return SpringPreheatData:GetMaxProgress()
end

function SpringPreheatMainView:GetMaxLetterCount()
	return math.min(self:GetDays(), (SpringPreheatData:GetActivityTotalDay()))
end

return SpringPreheatMainView
