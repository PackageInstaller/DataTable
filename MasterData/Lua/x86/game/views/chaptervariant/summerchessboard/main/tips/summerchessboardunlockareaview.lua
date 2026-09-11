local SummerChessBoardTipsWindowView = class("SummerChessBoardTipsWindowView", ReduxView)

function SummerChessBoardTipsWindowView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_LvUnlockPopUI3"
end

function SummerChessBoardTipsWindowView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerChessBoardTipsWindowView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.unlockController_ = self.controllerEx_:GetController("unlock")
end

function SummerChessBoardTipsWindowView:OnEnter()
	self.chessConditionID_ = self.params_.chessConditionID

	self:RefreshUI()
end

function SummerChessBoardTipsWindowView:OnExit()
	self:StopTimer()
end

function SummerChessBoardTipsWindowView:Dispose()
	SummerChessBoardTipsWindowView.super.Dispose(self)
end

function SummerChessBoardTipsWindowView:AddListeners()
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		ActivityUnlockStateAction.UpdateState(self.chessConditionID_, ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT, 1)
		manager.redPoint:setTip(SummerChessBoardData:CallFun("GetEntryRedPointKey", ActivitySummerChessConditionCfg[self.chessConditionID_].activity_id), 0, RedPointStyle.SHOW_NEW_TAG)
		self:Back()
		JumpTools.JumpToPage2(ActivitySummerChessConditionCfg[self.chessConditionID_].jump_system)
	end)
end

function SummerChessBoardTipsWindowView:RefreshUI()
	local var_11_0 = ActivitySummerChessConditionCfg[self.chessConditionID_]
	local var_11_1 = ActivityData:GetActivityData(ActivitySummerChessConditionCfg[self.chessConditionID_].activity_id)

	if manager.time:GetServerTime() < var_11_1.startTime then
		self.textText_.text = string.format("「%s」%s", ActivityCfg[var_11_0.activity_id].remark, (string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStrWith2Unit(var_11_1.startTime))))

		self.unlockController_:SetSelectedState("false")
	else
		self.textText_.text = var_11_0.unlock_text

		self.unlockController_:SetSelectedState("true")
	end

	SetSpriteWithoutAtlasAsync(self.image_, var_11_0.image_path)

	self.fullscreenBtn_.interactable = false
	self.timer_ = FrameTimer.New(function()
		if self.animator1_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 and self.animator2_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self:StopTimer()

			self.fullscreenBtn_.interactable = true
		end
	end, 1, -1)

	self.timer_:Start()
end

function SummerChessBoardTipsWindowView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SummerChessBoardTipsWindowView
