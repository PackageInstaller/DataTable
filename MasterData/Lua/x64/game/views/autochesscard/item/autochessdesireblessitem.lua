local AutoChessDesireBlessItem = class("AutoChessDesireBlessItem", ReduxView)

function AutoChessDesireBlessItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.blessId_ = 0
	self.selectHandle_ = arg_1_2

	self:Init()
end

function AutoChessDesireBlessItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessDesireBlessItem:InitUI()
	self.stateController_ = self.controller_:GetController("state")
end

function AutoChessDesireBlessItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.selectHandle_ then
			self.selectHandle_(self.blessId_)
		end
	end)
end

function AutoChessDesireBlessItem:SetData(arg_6_1)
	self.blessId_ = arg_6_1

	self:RefreshUI()
end

function AutoChessDesireBlessItem:SetState(arg_7_1)
	if self.blessId_ == arg_7_1 then
		self.stateController_:SetSelectedIndex(1)
	else
		self.stateController_:SetSelectedIndex(0)
	end
end

function AutoChessDesireBlessItem:RefreshUI()
	self.txtBless_.text = GetTips(self.blessId_)
end

function AutoChessDesireBlessItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function AutoChessDesireBlessItem:Dispose()
	AutoChessDesireBlessItem.super.Dispose(self)
end

return AutoChessDesireBlessItem
