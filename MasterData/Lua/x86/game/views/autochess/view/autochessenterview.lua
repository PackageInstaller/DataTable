local AutoChessEnterView = class("AutoChessEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function AutoChessEnterView:GetUIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_MainUI"
end

function AutoChessEnterView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessEnterView:InitUI()
	self:BindCfgUI()

	self.skinDlcController_ = self.controller_:GetController("skinDLC")
	self.skinGotController_ = self.controller_:GetController("skinGot")
	self.skinGiftController_ = self.controller_:GetController("skinGift")
end

function AutoChessEnterView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/autoChessMain")
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_TASK
		})
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			key = "AUTO_CHESS_ENTRANCE_TIP",
			content = GetTips("AUTO_CHESS_ENTRANCE_TIP")
		})
	end)
	self:AddBtnListener(self.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessSkinDlcView")
	end)
end

function AutoChessEnterView:OnEnter()
	self.super.OnEnter(self)
	self:RefreshRewardTime()
	self:RefreshSkinTime()
	self:BindRedPoint()

	if not self.move then
		self.move = Asset.Instantiate("Widget/System/Activity_OsirisHorus/Movie/Activity_OsirisHorus_Main_Movie")

		if self.move then
			self.move.transform.parent = self.movieTrans_
			self.move.transform.localScale = Vector3.one
			self.move.transform.localPosition = Vector3.zero
		end
	end
end

function AutoChessEnterView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.AUTO_CHESS_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.AUTO_CHESS_GO_BTN)
end

function AutoChessEnterView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.AUTO_CHESS_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.AUTO_CHESS_GO_BTN)
end

function AutoChessEnterView:OnTop()
	self:RefreshSkinGet()
end

function AutoChessEnterView:RefreshRewardTime()
	local var_13_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_TASK)

	self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_13_0.stopTime)

	SetActive(self.rewardBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_TASK))

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_TASK) then
				self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_13_0.stopTime)
			else
				SetActive(self.rewardBtn_.gameObject, false)
				self:LimitStopTimer()
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function AutoChessEnterView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function AutoChessEnterView:DisposeSkinTimer()
	if self.skinTimer_ then
		self.skinTimer_:Stop()

		self.skinTimer_ = nil
	end
end

function AutoChessEnterView:RefreshSkinTime()
	self:RefreshSkinGet()
	self:UpdateSkinTime()
	self:DisposeSkinTimer()

	self.skinTimer_ = Timer.New(function()
		self:UpdateSkinTime()
	end, 1, -1)

	self.skinTimer_:Start()
end

function AutoChessEnterView:UpdateSkinTime()
	local var_19_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_SKIN)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_SKIN) then
		self.skinTimeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_SKIN).stopTime)
	elseif manager.time:GetServerTime() < var_19_0.startTime then
		self.skinTimeText_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_19_0.startTime))
	elseif manager.time:GetServerTime() > var_19_0.stopTime then
		self.skinTimeText_.text = GetTips("TIME_OVER")
	end
end

function AutoChessEnterView:RefreshSkinGet()
	local var_20_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_AUTO_CHESS_SKIN] or {}

	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_SKIN) then
		self.skinDlcController_:SetSelectedState("off")

		return
	else
		self.skinDlcController_:SetSelectedState("on")
	end

	if TaskTools:GetFinishTaskNum(var_20_0) == #var_20_0 then
		self.skinGotController_:SetSelectedState("on")
	else
		self.skinGotController_:SetSelectedState("off")
	end

	if TaskTools:IsHasReceiveTask(var_20_0) then
		self.skinGiftController_:SetSelectedState("on")
	else
		self.skinGiftController_:SetSelectedState("off")
	end
end

function AutoChessEnterView:OnExit()
	self:DisposeSkinTimer()
	self:LimitStopTimer()

	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end

	if self.move then
		Object.Destroy(self.move)

		self.move = nil
	end

	self:UnBindRedPoint()
	AutoChessEnterView.super.OnExit(self)
end

function AutoChessEnterView:Dispose()
	self.super.Dispose(self)
end

return AutoChessEnterView
