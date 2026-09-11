local RechargeOathRingShopCouponItem = class("RechargeOathRingShopCouponItem", BaseView)
local var_0_1 = ItemConst.OATH_RING_COUPON

function RechargeOathRingShopCouponItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.selectController = self.controllers_:GetController("select")
	self.showExpireTimeController = self.controllers_:GetController("showExpireTime")

	self:AddBtnListener(self.btn_, nil, function()
		if self.onClick then
			self:onClick()
		end
	end)
	self:AddBtnListener(self.itemBtn_, nil, function()
		self:OnClickItemIcon()
	end)
end

function RechargeOathRingShopCouponItem:OnClickItemIcon()
	ShowPopItemOnly(POP_SOURCE_DES_ITEM, self.info)
end

function RechargeOathRingShopCouponItem:SetData(arg_5_1, arg_5_2)
	self.info = arg_5_1
	self.index = arg_5_2
	self.nameText_.text = ItemTools.getItemName(arg_5_1.id)
	self.couponSprite_.spriteAsync = ItemTools.getItemSprite(arg_5_1.id, true)
	self.discountText_.text = GetTips((string.format("WEDDING_RING_SALE_DESC_%d", var_0_1)))

	self:UpdateLastTime()
end

function RechargeOathRingShopCouponItem:UpdateLastTime()
	local var_6_0 = ItemTools.GetItemExpiredTimeByInfo(self.info)

	if var_6_0 ~= nil and var_6_0 ~= 0 then
		self.showExpireTimeController:SetSelectedState("true")

		self.timeText_.text = manager.time:GetLostTimeStr(var_6_0, true, true)
	else
		self.showExpireTimeController:SetSelectedState("false")
	end
end

function RechargeOathRingShopCouponItem:SetOnClick(arg_7_1)
	self.onClick = arg_7_1
end

function RechargeOathRingShopCouponItem:SetSelected(arg_8_1)
	if self.selectController then
		self.selectController:SetSelectedState(arg_8_1 and "true" or "false")
	end
end

function RechargeOathRingShopCouponItem:Dispose()
	self:RemoveAllListeners()
	RechargeOathRingShopCouponItem.super.Dispose(self)
end

return RechargeOathRingShopCouponItem
