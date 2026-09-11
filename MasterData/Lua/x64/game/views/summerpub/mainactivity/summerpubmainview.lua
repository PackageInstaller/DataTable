ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SummerPubMainView = class("SummerPubMainView", ActivityMainBasePanel)

function SummerPubMainView:GetUIName()
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_MainUI"
end

function SummerPubMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerPubMainView:InitUI()
	self:BindCfgUI()

	self.skinDlcController_ = self.exController_:GetController("skinDLC")
	self.skinGiftController_ = self.exController_:GetController("skinGift")
	self.skinGotController_ = self.exController_:GetController("skinGot")
end

function SummerPubMainView:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		local var_5_0 = {
			content = GetTips("NYA_SUMMER_ENTRANCE_TIP")
		}

		var_5_0.key = "NYA_SUMMER_ENTRANCE_TIP"

		JumpTools.OpenPageByJump("gameHelp", var_5_0)
	end)
	self:AddBtnListener(self.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/summerPubLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		SummerPubTool:MainToEnterView()
	end)
	self:AddBtnListener(self.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("summerPubSkinPopView")
	end)
end

function SummerPubMainView:OnEnter()
	SummerPubMainView.super.OnEnter(self)

	self.titleTxt_.text = GetI18NText(GetTips("NYA_SUMMER_ENTRANCE_TITLE"))
	self.bg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SP92601")

	self:UpdatePreview()
	self:RefreshLimitTime()
	self:RefreshSkinDlc()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.SUMMER_PUB_GO_BTN)
	manager.redPoint:bindUIandKey(self.limitRewardBtn_.transform, RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)
	manager.redPoint:bindUIandKey(self.skinBtn_.transform, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
end

function SummerPubMainView:RefreshLimitTime()
	local var_10_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK) then
		self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_10_0.stopTime)
	elseif manager.time:GetServerTime() < var_10_0.startTime then
		self.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_10_0.startTime))
	elseif manager.time:GetServerTime() > var_10_0.stopTime then
		self.limitTimeTxt_.text = GetTips("TIME_OVER")
	end

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK) then
				if self.limittimer_ == nil then
					self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_10_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_10_0.startTime then
				self.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_10_0.startTime))
			elseif manager.time:GetServerTime() > var_10_0.stopTime then
				self.limitTimeTxt_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function SummerPubMainView:RefreshSkinDlc()
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC) then
		self.skinDlcController_:SetSelectedState("on")

		local var_12_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC] or {}

		if TaskTools:IsHasReceiveTask(var_12_0) then
			self.skinGiftController_:SetSelectedState("on")
		else
			self.skinGiftController_:SetSelectedState("off")

			if TaskTools:GetFinishTaskNum(var_12_0) == #var_12_0 then
				self.skinGotController_:SetSelectedState("on")
			else
				self.skinGotController_:SetSelectedState("off")
			end
		end

		self:RefreshSkinTimeText()
	else
		self.skinDlcController_:SetSelectedState("off")
	end
end

function SummerPubMainView:RefreshSkinTimeText()
	local var_13_0 = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC
	local var_13_1 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC) then
		self.skinTimeTxt_.text = manager.time:GetLostTimeStr2(var_13_1.stopTime)
	elseif manager.time:GetServerTime() < var_13_1.startTime then
		self.skinTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_13_1.startTime))
	elseif manager.time:GetServerTime() > var_13_1.stopTime then
		self.skinTimeTxt_.text = GetTips("TIME_OVER")
	end

	if self.skinTimer_ == nil then
		self.skinTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(var_13_0) then
				if self.skinTimer_ == nil then
					self.skinTimeTxt_.text = manager.time:GetLostTimeStr2(var_13_1.stopTime)
				end
			elseif manager.time:GetServerTime() < var_13_1.startTime then
				self.skinTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_13_1.startTime))
			elseif manager.time:GetServerTime() > var_13_1.stopTime then
				self.skinTimeTxt_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.skinTimer_:Start()
end

function SummerPubMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SummerPubMainView:OnTop()
	self:UpdateBar()
	self:RefreshSkinDlc()
end

function SummerPubMainView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function SummerPubMainView:SkinStopTimer()
	if self.skinTimer_ then
		self.skinTimer_:Stop()

		self.skinTimer_ = nil
	end
end

function SummerPubMainView:OnExit()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.SUMMER_PUB_GO_BTN)
	manager.redPoint:unbindUIandKey(self.limitRewardBtn_.transform, RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)
	manager.redPoint:unbindUIandKey(self.skinBtn_.transform, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
	self:LimitStopTimer()
	self:SkinStopTimer()
	SummerPubMainView.super.OnExit(self)
end

function SummerPubMainView:Dispose()
	self:RemoveAllListeners()
	SummerPubMainView.super.Dispose(self)
end

return SummerPubMainView
