local RegressionBPRewardItem = class("RegressionBPRewardItem", ReduxView)

function RegressionBPRewardItem:GetItemPath()
	if self.isSmall_ then
		return "Widget/System/Com_dynamic/CommonItem_s"
	else
		return "Widget/System/Com_dynamic/CommonItem"
	end
end

function RegressionBPRewardItem:OnCtor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self.parentGo_ = Object.Instantiate(arg_2_2, arg_2_1.transform)

	self:BindCfgUI(self.parentGo_)

	self.isSmall_ = arg_2_3
	self.gameObject_ = self.parentGo_
	self.transform_ = self.parentGo_.transform

	SetActive(self.gameObject_, true)

	self.commonItemGo_ = manager.objectPool:Get(self:GetItemPath())
	self.commonItem_ = CommonItemView.New(self.commonItemGo_)

	self:SetParent()

	self.clickCallback_ = arg_2_5

	if self.receivedMarkGo_ then
		self.receivedMarkGo_.transform:SetAsLastSibling()
	end

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function RegressionBPRewardItem:SetParent()
	self.commonItemGo_.transform:SetParent(self.parentGo_.transform, true)
	self.commonItem_:ResetTransform()
end

function RegressionBPRewardItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	if not self.itemData_ then
		self.itemData_ = clone(ItemTemplateData)
		self.itemData_.clickFun = self.clickCallback_
	end

	self.itemData_.id = arg_4_1[1]
	self.itemData_.number = arg_4_1[2]

	self.commonItem_:SetData(self.itemData_)
	self:Show(true)

	if arg_4_3 == nil or arg_4_3 >= 1 then
		self.commonItem_:RefreshLock(false)
	else
		self.commonItem_:RefreshLock(true)
	end
end

function RegressionBPRewardItem:Show(arg_5_1)
	SetActive(self.parentGo_, arg_5_1)
end

function RegressionBPRewardItem:RefreshStatus(arg_6_1)
	self.statusController_:SetSelectedIndex(arg_6_1)
end

function RegressionBPRewardItem:Dispose()
	RegressionBPRewardItem.super.Dispose(self)
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	manager.objectPool:Return(self:GetItemPath(), self.commonItemGo_)
end

return RegressionBPRewardItem
