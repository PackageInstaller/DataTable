local AutoChessPVPMatchView = class("AutoChessPVPMatchView", ReduxView)

function AutoChessPVPMatchView:UIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_matchPanel"
end

function AutoChessPVPMatchView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessPVPMatchView:Init()
	self:InitUI()
end

function AutoChessPVPMatchView:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.statusController_ = self.controllerEx_:GetController("status")
	self.matchSuccessHandler_ = handler(self, self.OnMatchSuccess)
end

function AutoChessPVPMatchView:AddListener()
	self:AddBtnListener(self.btnStop_, nil, function()
		AutoChessMatchAction.StopMatch()
	end)
end

function AutoChessPVPMatchView:OnEnter()
	self.expectTimeText_.text = manager.time:DescCDTime4(self.params_.expectTime)

	self:StartMatchTimer()
	manager.notify:RegistListener(AUTO_CHESS_MATCH_SUCCESS, self.matchSuccessHandler_)
end

function AutoChessPVPMatchView:OnTop()
	return
end

function AutoChessPVPMatchView:OnExit()
	AutoChessData:SetIsInMatch(false)
	manager.notify:RemoveListener(AUTO_CHESS_MATCH_SUCCESS, self.matchSuccessHandler_)
	self:CloseTimer()
end

function AutoChessPVPMatchView:Dispose()
	self:CloseTimer()
	AutoChessPVPMatchView.super.Dispose(self)
end

function AutoChessPVPMatchView:StartMatchTimer()
	local var_11_0, var_11_1 = AutoChessData:GetIsInMatch()

	if not var_11_0 or not var_11_1 then
		return
	end

	local var_11_2 = manager.time:GetServerTime() - var_11_1

	self.matchTimeText_.text = manager.time:DescCDTime4(var_11_2)

	self.statusController_:SetSelectedIndex(0)

	self.matchTimer_ = Timer.New(function()
		local var_12_0, var_12_1 = AutoChessData:GetIsInMatch()

		if not var_12_0 or not var_12_1 or manager.time:GetServerTime() - var_12_1 < 0 then
			self:CloseTimer()
		else
			manager.net:ForceReconnect()

			var_11_2 = manager.time:GetServerTime() - var_12_1
			self.matchTimeText_.text = manager.time:DescCDTime4(var_11_2)
		end
	end, 1, -1)

	self.matchTimer_:Start()
end

function AutoChessPVPMatchView:OnMatchSuccess()
	local var_13_0 = 3

	if not isNil(self.enterTimeText_) then
		self.enterTimeText_.text = 3
	end

	self.statusController_:SetSelectedIndex(1)

	self.matchSuccessTimer_ = Timer.New(function()
		if not isNil(self.enterTimeText_) then
			var_13_0 = var_13_0 - 1
			self.enterTimeText_.text = var_13_0
		end
	end, 1, 3)

	self.matchSuccessTimer_:Start()
end

function AutoChessPVPMatchView:CloseTimer()
	if self.matchTimer_ then
		self.matchTimer_:Stop()

		self.matchTimer_ = nil
	end

	if self.matchSuccessTimer_ then
		self.matchSuccessTimer_:Stop()

		self.matchSuccessTimer_ = nil
	end
end

return AutoChessPVPMatchView
