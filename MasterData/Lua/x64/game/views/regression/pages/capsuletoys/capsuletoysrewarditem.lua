local CapsuleToysRewardItem = class("CapsuleToysRewardItem", ReduxView)

function CapsuleToysRewardItem:GetItemPath()
	if self.isSmall_ then
		return "Widget/System/Com_dynamic/CommonItem_s"
	else
		return "Widget/System/Com_dynamic/CommonItem"
	end
end

function CapsuleToysRewardItem:OnCtor(arg_2_1, arg_2_2, arg_2_3)
	self.parentGo_ = Object.Instantiate(arg_2_2, arg_2_1.transform, false)

	self:BindCfgUI(self.parentGo_)

	self.isSmall_ = arg_2_3
	self.gameObject_ = self.parentGo_
	self.transform_ = self.parentGo_.transform

	SetActive(self.gameObject_, true)

	self.commonItemGo_ = manager.objectPool:Get(self:GetItemPath())
	self.commonItem_ = CommonItemView.New(self.commonItemGo_)

	self:SetParent()

	self.parentGo_.transform.localScale = Vector3.one

	if self.soldOutGo_ then
		self.soldOutGo_.transform:SetAsLastSibling()
	end
end

function CapsuleToysRewardItem:SetParent()
	self.commonItemGo_.transform:SetParent(self.contentTrans_, true)
	self.commonItem_:ResetTransform()
end

function CapsuleToysRewardItem:SetData(arg_4_1)
	self.rewardID_ = arg_4_1

	local var_4_0 = RegressionData:GetCapsuleToysStatus()[arg_4_1]
	local var_4_1 = 0

	if var_4_0 then
		var_4_1 = var_4_0.remain_num
	end

	self.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_4_1, RegressionCapsuleToysCfg[arg_4_1].total)

	if self.soldOutGo_ then
		SetActive(self.soldOutGo_, var_4_1 == 0)
	end

	local var_4_2 = RegressionCapsuleToysCfg[self.rewardID_].reward

	if not self.itemData_ then
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end

	self.itemData_.id = var_4_2[1]
	self.itemData_.number = var_4_2[2]

	self.commonItem_:SetData(self.itemData_)
end

function CapsuleToysRewardItem:Show(arg_6_1)
	SetActive(self.parentGo_, arg_6_1)
	CapsuleToysRewardItem.super.Show(self, arg_6_1)
end

function CapsuleToysRewardItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	manager.objectPool:Return(self:GetItemPath(), self.commonItemGo_)

	self.commonItemGo_ = nil

	CapsuleToysRewardItem.super.Dispose(self)
end

return CapsuleToysRewardItem
