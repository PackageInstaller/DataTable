local AutoChessQuitPopView = class("AutoChessQuitPopView", ReduxView)

function AutoChessQuitPopView:Init()
	self:InitUI()

	self.nodeList = {}

	self:AddListeners()
end

function AutoChessQuitPopView:InitUI()
	self:BindCfgUI()

	self.quitController = self.controllerEx_:GetController("pause")
	self.cancelController = self.controllerEx_:GetController("cancel")
	self.tipsController = self.controllerEx_:GetController("tips")
end

function AutoChessQuitPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessQuitPopView:UIName()
	return "Widget/System/Activity_OsirisHorus/Com/Activity_OsirisHorus_PopUI"
end

function AutoChessQuitPopView:AddListeners()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()

		if self.cancelCb then
			self.cancelCb()
		end
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self:Back()

		if self.okCb then
			self.okCb()
		end

		if self.type_ == AutoChessConst.POP_TYPE.REMAIN_MONEY then
			saveData("auto_chess_pop", "skip_" .. self.gameType_, self.isSkip)
		end
	end)
	self:AddBtnListener(self.giveUpBtn_, nil, function()
		if self.type_ ~= AutoChessConst.POP_TYPE.PVP_SYNC_RECONNECT then
			self:Back()
		end

		saveData("auto_chess_pop", "skip_" .. self.gameType_, false)
		AutoChessTools.CancelGame(self.gameType_)
	end)
	self:AddBtnListener(self.tipsBtn_, nil, function()
		self.isSkip = not self.isSkip

		self.tipsController:SetSelectedState(tostring(self.isSkip))
	end)
end

function AutoChessQuitPopView:OnEnter()
	self.gameType_ = self.params_.gameType
	self.type_ = self.params_.type
	self.okCb = self.params_.okCb
	self.cancelCb = self.params_.cancelCb

	SetActive(self.tipsGo_, false)

	if self.type_ == AutoChessConst.POP_TYPE.PVE then
		self.tipContent_.text = GetTips("AUTO_CHESS_QUIT_CONFIRM")
		self.cancelText_.text = GetTips("CANCEL")
		self.confirmText_.text = GetTips("AUTO_CHESS_2_LEAVE")

		self.quitController:SetSelectedState("show")
		self.cancelController:SetSelectedState("show")

		return
	end

	if self.type_ == AutoChessConst.POP_TYPE.REMAIN_MONEY then
		SetActive(self.tipsGo_, true)

		self.isSkip = false

		self.tipsController:SetSelectedState(tostring(self.isSkip))

		self.tipContent_.text = GetTips("AUTO_CHESS_START_CONFIRM")
		self.cancelText_.text = GetTips("CANCEL")
		self.confirmText_.text = GetTips("CONFIRM")

		self.quitController:SetSelectedState("hide")
		self.cancelController:SetSelectedState("show")

		return
	end

	if self.type_ == AutoChessConst.POP_TYPE.PVP_ASYNC then
		self.tipContent_.text = GetTips("AUTO_CHESS_QUIT_CONFIRM")
		self.cancelText_.text = GetTips("CANCEL")
		self.confirmText_.text = GetTips("CONFIRM")

		self.quitController:SetSelectedState("hide")
		self.cancelController:SetSelectedState("show")

		return
	end

	if self.type_ == AutoChessConst.POP_TYPE.PVE_FALLBACK then
		self.tipContent_.text = GetTips("AUTO_CHESS_DISCONNECT_CONFIRM")
		self.cancelText_.text = GetTips("CANCEL")
		self.confirmText_.text = GetTips("CONFIRM")

		self.quitController:SetSelectedState("hide")
		self.cancelController:SetSelectedState("hide")

		return
	end

	if self.type_ == AutoChessConst.POP_TYPE.PVP_SYNC then
		self.tipContent_.text = AutoChessTools.GetCurRound(self.gameType_) <= GameSetting.auto_chess_2_abandon_punish_round.value[1] and GetTips("AUTO_CHESS_2_ABANDON_EARLY_TIP") or GetTips("AUTO_CHESS_2_ABANDON_TIP")
		self.cancelText_.text = GetTips("CANCEL")
		self.confirmText_.text = GetTips("CONFIRM")

		self.quitController:SetSelectedState("hide")
		self.cancelController:SetSelectedState("show")

		return
	end

	if self.type_ == AutoChessConst.POP_TYPE.PVP_SYNC_RECONNECT then
		self.tipContent_.text = GetTips("AUTO_CHESS_2_RECONNECT_TIP")
		self.confirmText_.text = GetTips("CONFIRM")

		self.quitController:SetSelectedState("show")
		self.cancelController:SetSelectedState("hide")
	end

	if self.type_ == AutoChessConst.POP_TYPE.PREVIOUS_ADVICE then
		self.tipContent_.text = GetTips("AUTO_CHESS_2_PREVIOUS_ADVICE")
		self.confirmText_.text = GetTips("CONFIRM")
		self.cancelText_.text = GetTips("CANCEL")

		self.quitController:SetSelectedState("hide")
		self.cancelController:SetSelectedState("show")
	end

	if self.type_ == AutoChessConst.POP_TYPE.SKIP_TEACHING then
		self.tipContent_.text = GetTips("AUTO_CHESS_2_SKIP_WINDOW")
		self.confirmText_.text = GetTips("AUTO_CHESS_2_BUTTON_SKIP")
		self.cancelText_.text = GetTips("AUTO_CHESS_2_BUTTON_RESUME")

		self.quitController:SetSelectedState("hide")
		self.cancelController:SetSelectedState("show")
	end

	if self.type_ == AutoChessConst.POP_TYPE.TEACHING then
		self.tipContent_.text = GetTips("AUTO_CHESS_2_TUTORIAL_SKIP")
		self.confirmText_.text = GetTips("AUTO_CHESS_2_BUTTON_SKIP")
		self.cancelText_.text = GetTips("CANCEL")

		self.quitController:SetSelectedState("hide")
		self.cancelController:SetSelectedState("show")
	end
end

return AutoChessQuitPopView
