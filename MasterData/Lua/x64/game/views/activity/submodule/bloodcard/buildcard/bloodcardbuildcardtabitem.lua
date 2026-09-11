local BloodCardBuildCardTabItem = class("BloodCardBuildCardTabItem", ReduxView)

function BloodCardBuildCardTabItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BloodCardBuildCardTabItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.stateController_ = self.controller_:GetController("tab")
	self.useController_ = self.controller_:GetController("used")
end

function BloodCardBuildCardTabItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack_ then
			self.clickCallBack_(self.index_)
		end
	end)
	self:AddBtnListener(self.editBtn_, nil, function()
		if self.renameClickCallBack_ then
			self.renameClickCallBack_(self.index_)
		end
	end)
end

function BloodCardBuildCardTabItem:RefreshUI()
	local var_6_0 = BloodCardData:GetCardGroup(self.index_)

	if #var_6_0 > 0 and self.selected_ then
		self.stateController_:SetSelectedState("select")
	elseif #var_6_0 > 0 and not self.selected_ then
		self.stateController_:SetSelectedState("normal")
	elseif #var_6_0 == 0 and self.selected_ then
		self.stateController_:SetSelectedState("edit")
	elseif #var_6_0 == 0 and not self.selected_ then
		self.stateController_:SetSelectedState("add")
	end

	self.useController_:SetSelectedState(tostring(self.index_ == BloodCardData:GetUsingCardIndex()))

	self.text_.text = BloodCardData:GetCardGroupName(self.index_)
end

function BloodCardBuildCardTabItem:SetData(arg_7_1)
	self.index_ = arg_7_1

	self:RefreshUI()
end

function BloodCardBuildCardTabItem:SetClickCallBack(arg_8_1)
	self.clickCallBack_ = arg_8_1
end

function BloodCardBuildCardTabItem:SetRenameCallBack(arg_9_1)
	self.renameClickCallBack_ = arg_9_1
end

function BloodCardBuildCardTabItem:SelectTab(arg_10_1)
	self.selected_ = arg_10_1 == self.index_

	self:RefreshUI()
end

function BloodCardBuildCardTabItem:Dispose()
	BloodCardBuildCardTabItem.super.Dispose(self)
end

return BloodCardBuildCardTabItem
