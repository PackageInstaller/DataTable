local RechargeSpringFestivalTitleItem = class("RechargeSpringFestivalTitleItem", ReduxView)

function RechargeSpringFestivalTitleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function RechargeSpringFestivalTitleItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeSpringFestivalTitleItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.tabCon_:GetController("select")
	self.lockController_ = self.tabCon_:GetController("lock")
end

function RechargeSpringFestivalTitleItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.data = arg_4_1
	self.index = arg_4_2
	self.callback = arg_4_3
	self.shopId = arg_4_4

	self:UpdateView()
end

function RechargeSpringFestivalTitleItem:UpdateView()
	return
end

function RechargeSpringFestivalTitleItem:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.callback and not self.selectStatus_ then
			self.callback(self.index)
		end
	end)
end

function RechargeSpringFestivalTitleItem:UpdateView()
	self.nameTxt1_.text = self.data.remark
	self.nameTxt2_.text = self.data.remark

	self.lockController_:SetSelectedState(tostring((ShopTools.IsPC() or nil) and (ShopConst.PC_LOCK_SHOP[self.shopId] or not ShopTools.CheckShopIsUnLock(self.shopId))))
end

function RechargeSpringFestivalTitleItem:ShowSelect(arg_9_1)
	self.selectStatus_ = arg_9_1

	self.selectController_:SetSelectedState(arg_9_1 and "select" or "normal")
end

return RechargeSpringFestivalTitleItem
