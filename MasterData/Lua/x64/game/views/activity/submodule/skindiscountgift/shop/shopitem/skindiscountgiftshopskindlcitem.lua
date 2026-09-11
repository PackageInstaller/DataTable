LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local SkinDiscountGiftShopSkinDLCItem = class("SkinDiscountGiftShopSkinDLCItem", LoopScrollViewBaseItem)

function SkinDiscountGiftShopSkinDLCItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddUIListener()

	self.skinItemView_ = SkinDiscountGiftShopSkinItem.New(self.skinGo_)
	self.dlcItemView_ = SkinDiscountGiftShopDLCItem.New(self.dlcGo_)
end

function SkinDiscountGiftShopSkinDLCItem:AddUIListener()
	return
end

function SkinDiscountGiftShopSkinDLCItem:SetData(arg_3_1, arg_3_2)
	self.skinItemView_:SetData(arg_3_1)
	self.dlcItemView_:SetData(arg_3_1)

	self.index_ = arg_3_2

	self:Show(true)
end

function SkinDiscountGiftShopSkinDLCItem:GetItemHeight()
	return self.rectGo_.sizeDelta.x
end

function SkinDiscountGiftShopSkinDLCItem:Dispose()
	self.skinItemView_:Dispose()

	self.skinItemView_ = nil

	self.dlcItemView_:Dispose()

	seld.dlcItemView_ = nil

	SkinDiscountGiftShopSkinDLCItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return SkinDiscountGiftShopSkinDLCItem
