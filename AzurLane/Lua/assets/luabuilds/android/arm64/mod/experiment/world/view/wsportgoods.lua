local var_0_0 = class("WSPortGoods", import("...BaseEntity"))

var_0_0.Fields = {
	txCount = "userdata",
	txName = "userdata",
	goods = "table",
	transform = "userdata",
	rtResIcon = "userdata",
	rtItem = "userdata",
	rtMask = "userdata",
	rtResCount = "userdata"
}
var_0_0.Listeners = {
	onUpdate = "Update"
}

function var_0_0.Build(arg_1_0, arg_1_1)
	arg_1_0.transform = arg_1_1

	return
end

function var_0_0.Setup(arg_2_0, arg_2_1)
	arg_2_0.goods = arg_2_1

	arg_2_0.goods:AddListener(WorldGoods.EventUpdateCount, arg_2_0.onUpdate)
	arg_2_0:Init()

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.goods:RemoveListener(WorldGoods.EventUpdateCount, arg_3_0.onUpdate)
	arg_3_0:Clear()

	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.rtMask = arg_4_0.transform:Find("mask")
	arg_4_0.rtItem = arg_4_0.transform:Find("IconTpl")
	arg_4_0.txCount = arg_4_0.transform:Find("count_contain/count")
	arg_4_0.txName = arg_4_0.transform:Find("name_mask/name")
	arg_4_0.rtResIcon = arg_4_0.transform:Find("consume/contain/icon")
	arg_4_0.rtResCount = arg_4_0.transform:Find("consume/contain/Text")

	setText(arg_4_0.transform:Find("mask/tag/sellout_tag"), i18n("word_sell_out"))
	setText(arg_4_0.transform:Find("count_contain/label"), i18n("activity_shop_exchange_count"))
	updateDrop(arg_4_0.rtItem, arg_4_0.goods.item)
	setText(arg_4_0.txName, shortenString(arg_4_0.goods.item:getConfig("name"), 6))
	GetImageSpriteFromAtlasAsync(arg_4_0.goods.moneyItem:getIcon(), "", arg_4_0.rtResIcon, false)
	setText(arg_4_0.rtResCount, arg_4_0.goods.moneyItem.count)
	arg_4_0:Update()

	return
end

function var_0_0.Update(arg_5_0, arg_5_1)
	if arg_5_1 == nil or arg_5_1 == WorldGoods.EventUpdateCount then
		setText(arg_5_0.txCount, arg_5_0.goods.count .. "/" .. arg_5_0.goods.config.frequency)
		setActive(arg_5_0.rtMask, arg_5_0.goods.count == 0)
	end

	return
end

return var_0_0
