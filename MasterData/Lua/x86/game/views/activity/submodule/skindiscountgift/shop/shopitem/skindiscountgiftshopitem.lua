LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local SkinDiscountGiftShopItem = class("SkinDiscountGiftShopItem", LoopScrollViewBaseItem)

function SkinDiscountGiftShopItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddUIListener()

	self.skinItemView_ = SkinDiscountGiftShopSkinItem.New(self.gameObject_)
end

function SkinDiscountGiftShopItem:AddUIListener()
	return
end

function SkinDiscountGiftShopItem:SetData(arg_3_1, arg_3_2)
	self.skinItemView_:SetData(arg_3_1)

	self.index_ = arg_3_2

	self:Show(true)
end

function SkinDiscountGiftShopItem:GetItemHeight()
	return self.rectGo_.sizeDelta.x
end

function SkinDiscountGiftShopItem:Dispose()
	self.skinItemView_:Dispose()

	self.skinItemView_ = nil

	SkinDiscountGiftShopItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return SkinDiscountGiftShopItem
