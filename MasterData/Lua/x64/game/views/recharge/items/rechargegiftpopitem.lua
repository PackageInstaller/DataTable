local RechargeGiftPopItem = class("RechargeGiftPopItem", ReduxView)

function RechargeGiftPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RechargeGiftPopItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeGiftPopItem:InitUI()
	self:BindCfgUI()

	self.commonItem = CommonItemView.New(self.iconGo_, true)
	self.CommonData = clone(ItemTemplateData)
	self.controller = self.controller_:GetController("have")
end

function RechargeGiftPopItem:AddUIListener()
	return
end

function RechargeGiftPopItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.id = arg_5_1
	self.number = arg_5_2
	self.count = arg_5_3

	self:UpdateView()
end

function RechargeGiftPopItem:SetActive(arg_6_1)
	if self.gameObject_ and not isNil(self.gameObject_) then
		SetActive(self.gameObject_, arg_6_1)
	end
end

function RechargeGiftPopItem:UpdateView()
	CommonTools.SetCommonData(self.commonItem, {
		id = self.id,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	}, self.CommonData1)

	self.limitLabel_.text = "X" .. self.number
	self.nameLabel_.text = ItemTools.getItemName(self.id)

	if ItemCfg[self.id].num_exchange_item then
		self.controller:SetSelectedState(tostring(ItemTools.getItemNum(self.id) >= ItemCfg[self.id].limit))
	else
		self.controller:SetSelectedState("false")
	end
end

function RechargeGiftPopItem:OnEnter()
	return
end

function RechargeGiftPopItem:OnExit()
	return
end

function RechargeGiftPopItem:Dispose()
	if self.commonItem then
		self.commonItem:Dispose()

		self.commonItem = nil
	end

	RechargeGiftPopItem.super.Dispose(self)
end

return RechargeGiftPopItem
