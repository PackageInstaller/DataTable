class = var_0_10000

local var_0_0 = "WSPortGoods"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	txCount = "userdata",
	txName = "userdata",
	goods = "table",
	transform = "userdata",
	rtResIcon = "userdata",
	rtItem = "userdata",
	rtMask = "userdata",
	rtResCount = "userdata"
}
var_0_1.Listeners = {
	onUpdate = "Update"
}

function var_0_1.Build(arg_1_0, arg_1_1)
	arg_1_0.transform = arg_1_1

	return
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	arg_2_0.goods = arg_2_1

	local var_2_0 = arg_2_0.goods
	local var_2_1 = var_2.AddListener

	WorldGoods = var_1_10005

	var_2_1(var_2_0, var_1_10005.EventUpdateCount, arg_2_0.onUpdate)
	arg_2_0:Init()

	return
end

function var_0_1.Dispose(arg_3_0)
	local var_3_0 = arg_3_0.goods
	local var_3_1 = var_1.RemoveListener

	WorldGoods = var_1_10004

	var_3_1(var_3_0, var_1_10004.EventUpdateCount, arg_3_0.onUpdate)
	arg_3_0:Clear()

	return
end

function var_0_1.Init(arg_4_0)
	local var_4_0 = arg_4_0.transform

	arg_4_0.rtMask = var_1.Find(var_4_0, "mask")
	arg_4_0.rtItem = var_1:Find("IconTpl")
	arg_4_0.txCount = var_1:Find("count_contain/count")
	arg_4_0.txName = var_1:Find("name_mask/name")
	arg_4_0.rtResIcon = var_1:Find("consume/contain/icon")
	arg_4_0.rtResCount = var_1:Find("consume/contain/Text")
	setText = var_2

	local var_4_1 = var_1:Find("mask/tag/sellout_tag")

	i18n = var_5

	var_2(var_4_1, var_5("word_sell_out"))

	setText = var_2

	local var_4_2 = var_1:Find("count_contain/label")

	i18n = var_5

	var_2(var_4_2, var_5("activity_shop_exchange_count"))

	local var_4_3 = arg_4_0.goods.item

	updateDrop = var_1_10003

	var_1_10003(arg_4_0.rtItem, var_4_3)

	setText = var_1_10003

	local var_4_4 = arg_4_0.txName

	shortenString = var_6

	var_1_10003(var_4_4, var_6(var_4_3:getConfig("name"), 6))

	local var_4_5 = arg_4_0.goods.moneyItem

	GetImageSpriteFromAtlasAsync = var_4_2

	var_4_2(var_4_5:getIcon(), "", arg_4_0.rtResIcon, false)

	setText = var_4_2

	var_4_2(arg_4_0.rtResCount, var_4_5.count)
	arg_4_0:Update()

	return
end

function var_0_1.Update(arg_5_0, arg_5_1)
	if arg_5_1 ~= nil then
		WorldGoods = var_1_10002

		if arg_5_1 == var_1_10002.EventUpdateCount then
			setText = var_1_10002

			var_1_10002(arg_5_0.txCount, arg_5_0.goods.count .. "/" .. arg_5_0.goods.config.frequency)

			setActive = var_1_10002

			var_1_10002(arg_5_0.rtMask, arg_5_0.goods.count == 0)
		end

		return
	end
end

return var_0_1
