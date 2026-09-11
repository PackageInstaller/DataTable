local SkinDiscountGiftMainItem = class("SkinDiscountGiftMainItem", ReduxView)

function SkinDiscountGiftMainItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controllerEx_:GetController("state")
end

function SkinDiscountGiftMainItem:Dispose()
	SkinDiscountGiftMainItem.super.Dispose(self)
end

function SkinDiscountGiftMainItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		if SkinDiscountGiftTools.GetRemainCount(self.id_) <= 0 then
			ShowTips("SELL_OUT")

			return
		elseif SkinDiscountGiftTools.HasAllGoodsSkin(self.id_) then
			ShowTips("SKIN_DISCOUNT_GIFT_CANNOT_BUY_TIPS")

			return
		else
			if not ActivityData:GetActivityIsOpen(ActivitySkinDiscountCfg[self.id_].activity_id) then
				ShopTips("TIME_OVER")

				return
			end

			SkinDiscountGiftData:ClearGoodsIDList()
			self:Go("/skinDiscountGiftShop", {
				giftID = self.id_
			})
		end
	end)
end

function SkinDiscountGiftMainItem:SetData(arg_5_1)
	self.id_ = arg_5_1

	local var_5_0 = SkinDiscountGiftTools.GetRemainCount(arg_5_1)

	self.titleText_.text = ActivitySkinDiscountCfg[arg_5_1].goods_name
	self.discountText_.text = string.format("%.1f%s", ActivitySkinDiscountCfg[arg_5_1].discount / 10, GetI18NText(GetTips("LABEL_DISCOUNT")))
	self.numText_.text = var_5_0

	if var_5_0 <= 0 then
		self.stateController_:SetSelectedState("state1")
	elseif SkinDiscountGiftTools.HasAllGoodsSkin(arg_5_1) then
		self.stateController_:SetSelectedState("state2")
	else
		self.stateController_:SetSelectedState("state0")
	end
end

return SkinDiscountGiftMainItem
