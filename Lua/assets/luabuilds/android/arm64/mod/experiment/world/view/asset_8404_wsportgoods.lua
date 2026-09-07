local WSPortGoods = class("WSPortGoods", import("...BaseEntity"))

WSPortGoods.Fields = {
	txCount = "userdata",
	txName = "userdata",
	goods = "table",
	transform = "userdata",
	rtResIcon = "userdata",
	rtItem = "userdata",
	rtMask = "userdata",
	rtResCount = "userdata"
}
WSPortGoods.Listeners = {
	onUpdate = "Update"
}

function WSPortGoods:Build(arg_1_1)
	self.transform = arg_1_1

	return
end

function WSPortGoods:Setup(arg_2_1)
	self.goods = arg_2_1

	self.goods:AddListener(WorldGoods.EventUpdateCount, self.onUpdate)
	self:Init()

	return
end

function WSPortGoods:Dispose()
	self.goods:RemoveListener(WorldGoods.EventUpdateCount, self.onUpdate)
	self:Clear()

	return
end

function WSPortGoods:Init()
	self.rtMask = self.transform:Find("mask")
	self.rtItem = self.transform:Find("IconTpl")
	self.txCount = self.transform:Find("count_contain/count")
	self.txName = self.transform:Find("name_mask/name")
	self.rtResIcon = self.transform:Find("consume/contain/icon")
	self.rtResCount = self.transform:Find("consume/contain/Text")

	setText(self.transform:Find("mask/tag/sellout_tag"), i18n("word_sell_out"))
	setText(self.transform:Find("count_contain/label"), i18n("activity_shop_exchange_count"))
	updateDrop(self.rtItem, self.goods.item)
	setText(self.txName, shortenString(self.goods.item:getConfig("name"), 6))
	GetImageSpriteFromAtlasAsync(self.goods.moneyItem:getIcon(), "", self.rtResIcon, false)
	setText(self.rtResCount, self.goods.moneyItem.count)
	self:Update()

	return
end

function WSPortGoods:Update(arg_5_1)
	if arg_5_1 == nil or arg_5_1 == WorldGoods.EventUpdateCount then
		setText(self.txCount, self.goods.count .. "/" .. self.goods.config.frequency)
		setActive(self.rtMask, self.goods.count == 0)
	end

	return
end

return WSPortGoods
