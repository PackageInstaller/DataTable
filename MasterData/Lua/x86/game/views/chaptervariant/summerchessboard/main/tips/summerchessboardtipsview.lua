local SummerChessBoardTipsView = class("SummerChessBoardTipsView", ReduxView)

function SummerChessBoardTipsView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function SummerChessBoardTipsView:OnExit()
	self:StopTimer()
end

function SummerChessBoardTipsView:Dispose()
	SummerChessBoardTipsView.super.Dispose(self)
end

function SummerChessBoardTipsView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		SetActive(self.gameObject_, false)
		manager.notify:Invoke(SUMMER_CHESS_BOARD_TIPS_ANIMATOR_OVER)
	end)
end

function SummerChessBoardTipsView:SetText(arg_6_1)
	manager.windowBar:HideBar()

	self.tipsText_.text = arg_6_1

	SetActive(self.gameObject_, true)
	self:StopTimer()

	self.closeBtn_.interactable = false
	self.timer_ = FrameTimer.New(function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self:StopTimer()

			self.closeBtn_.interactable = true
		end
	end, 1, -1)

	self.timer_:Start()
end

function SummerChessBoardTipsView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SummerChessBoardTipsView
