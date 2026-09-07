local BlackFridayGoodsCard = class("BlackFridayGoodsCard", import(".NewServerGoodsCard"))

function BlackFridayGoodsCard:Flush()
	self.cntTxt.text = self.commodity:GetCanPurchaseCnt() .. "/" .. self.commodity:GetCanPurchaseMaxCnt()

	setActive(self.sellOutMaskTF, not self.commodity:CanPurchase())
	setActive(self.discountTF, self.commodity:GetDiscount() ~= 0 and self.commodity:CanPurchase())

	return
end

function BlackFridayGoodsCard:Init()
	BlackFridayGoodsCard.super.Init(self)
	setActive(self.discountTF, false)

	if self.commodity:GetDiscount() ~= 0 and self.commodity:CanPurchase() then
		setActive(self.discountTF, true)

		self.consumeTxtTF.text = self.commodity:GetSalesPrice()

		setText(self.discountTF:Find("Text"), self.commodity:GetOffPercent() .. "%")
	end

	return
end

return BlackFridayGoodsCard
