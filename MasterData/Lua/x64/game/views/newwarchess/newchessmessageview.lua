local NewChessMessageView = class("NewChessMessageView", ReduxView)

function NewChessMessageView:UIName()
	return "UI/NewWarChess/NewWarChessTextPopUI"
end

function NewChessMessageView:UIParent()
	return manager.ui.uiPop.transform
end

function NewChessMessageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewChessMessageView:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function NewChessMessageView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
		self.cancelCallBack()
	end)
	self:AddBtnListener(self.checkBtn_, nil, function()
		self:Back()
		self.checkCallBack()
	end)
end

function NewChessMessageView:OnEnter()
	self.logId_ = self.params_.logId
	self.checkCallBack = self.params_.checkCallBack
	self.cancelCallBack = self.params_.cancelCallBack
	self.style_ = self.params_.style

	self:RefreshUI()
end

function NewChessMessageView:OnExit()
	return
end

function NewChessMessageView:RefreshUI()
	self.controller_:SetSelectedState(self.style_)

	if self.style_ == "cantReach" then
		self.checkBtn_.interactable = false
		self.checkText_.text = GetTips("CAN_NOT_TEACH")
	elseif self.style_ == "no" then
		self.checkBtn_.interactable = true
		self.checkText_.text = GetTips("CONFIRM")
	else
		self.checkBtn_.interactable = true
		self.checkText_.text = GetTips("GO_UP_TO")
	end

	if not WarchessContentCfg[self.logId_] then
		error("不存在的Id :", self.logId_)
	end

	self.textinfoText_.text = WarchessContentCfg[self.logId_].content

	if WarchessContentCfg[self.logId_].icon ~= "" then
		self.itemiconImg_.sprite = getSpriteViaConfig("WarchessItem", WarchessContentCfg[self.logId_].icon)
	end

	self.textnameText_.text = WarchessContentCfg[self.logId_].name
end

function NewChessMessageView:Dispose()
	NewChessMessageView.super.Dispose(self)
end

return NewChessMessageView
