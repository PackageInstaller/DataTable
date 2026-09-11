local OsirisChessView = class("OsirisChessView", ReduxView)

function OsirisChessView:UIName()
	return "UI/VersionUI/OsirisUI/OsirisConnectUI"
end

function OsirisChessView:UIParent()
	return manager.ui.uiMain.transform
end

function OsirisChessView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.chessView_ = {}

	for iter_3_0, iter_3_1 in ipairs(WarchessLevelCfg.get_id_list_by_type[ActivityConst.OSIRIS_CHESS]) do
		self.chessView_[iter_3_1] = OsirisChessBtnView.New(self[string.format("goStage%s_", iter_3_0)], iter_3_1)
	end
end

function OsirisChessView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_4_0, iter_4_1 in pairs(self.chessView_) do
		iter_4_1:OnEnter()
	end

	self.stopTime_ = ActivityData:GetActivityData(ActivityConst.OSIRIS_CHESS).stopTime

	self:AddTimer()
end

function OsirisChessView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in pairs(self.chessView_) do
		iter_5_1:OnExit()
	end
end

function OsirisChessView:Dispose()
	OsirisChessView.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.chessView_) do
		iter_6_1:Dispose()
	end

	self.chessView_ = nil
end

function OsirisChessView:AddListeners()
	return
end

function OsirisChessView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function OsirisChessView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return OsirisChessView
