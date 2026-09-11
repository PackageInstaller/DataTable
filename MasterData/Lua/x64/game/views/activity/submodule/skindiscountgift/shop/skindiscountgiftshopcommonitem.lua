CommonItemView = import("game.views.common.CommonItemView")

local SkinDiscountGiftShopCommonItem = class("SkinDiscountGiftShopCommonItem", CommonItemView)

function SkinDiscountGiftShopCommonItem:InitUI(...)
	SkinDiscountGiftShopCommonItem.super.InitUI(self, ...)

	self.skinGiftStateController_ = self.controllerExCollection_:GetController("fetchstate")
end

function SkinDiscountGiftShopCommonItem:RefreshUI()
	self:RefreshSkinGiftState()
	SkinDiscountGiftShopCommonItem.super.RefreshUI(self)
end

function SkinDiscountGiftShopCommonItem:RefreshSkinGiftState()
	if self.info_ == nil then
		self.skinGiftStateController_:SetSelectedState("state0")

		return
	end

	if self.info_.skinGiftSelect then
		self.skinGiftStateController_:SetSelectedState("state2")
	else
		self.skinGiftStateController_:SetSelectedState("state0")
	end
end

return SkinDiscountGiftShopCommonItem
