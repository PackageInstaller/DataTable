local NewServerCapsuleToysItem = class("NewServerCapsuleToysItem", ReduxView)

function NewServerCapsuleToysItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(arg_1_1, true)
	self:BindCfgUI()

	self.commonItem_ = CommonItemView.New(self.commonItemGo_)
end

function NewServerCapsuleToysItem:SetData(arg_2_1)
	self.rewardID_ = arg_2_1

	local var_2_0 = NewServerData:GetCapsuleToysStatus()[arg_2_1]
	local var_2_1 = 0

	if var_2_0 then
		var_2_1 = var_2_0.remain_num
	end

	self.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_2_1, NewServerCapsuleToysCfg[arg_2_1].total)

	if not self.itemData_ then
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end

	self.itemData_.id = NewServerCapsuleToysCfg[self.rewardID_].reward[1]
	self.itemData_.number = NewServerCapsuleToysCfg[self.rewardID_].reward[2]
	self.itemData_.completedFlag = var_2_1 == 0

	self.commonItem_:SetData(self.itemData_)
end

function NewServerCapsuleToysItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	NewServerCapsuleToysItem.super.Dispose(self)
end

return NewServerCapsuleToysItem
