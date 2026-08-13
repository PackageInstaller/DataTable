class = var_0_10000

local var_0_0 = "ChargeGoodsCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...shops.cards.GoodsCard"))

function var_0_1.update(arg_1_0, arg_1_1)
	arg_1_0.goodsVO = arg_1_1

	local var_1_0 = arg_1_0.goodsVO
	local var_1_1 = var_2.canPurchase(var_1_0)

	setActive = var_1_10003

	var_1_10003(arg_1_0.mask, not var_1_1)

	setActive = var_1_10003

	var_1_10003(arg_1_0.stars, false)

	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.getDropInfo(var_1_2)

	updateDrop = var_1_0

	var_1_0(arg_1_0.itemTF, var_1_3)

	local var_1_4

	if not var_1_3:getConfig("name") then
		var_1_4 = ""
	end

	setScrollText = var_1_2

	var_1_2(arg_1_0.nameTxt, var_1_4)

	local var_1_5 = arg_1_1
	local var_1_6 = arg_1_1.GetPrice(var_1_5)
	local var_1_7 = arg_1_1:getConfig("discount")

	setActive = var_1_5

	var_1_5(arg_1_0.discountTF, arg_1_1:isDisCount())

	setText = var_1_5

	var_1_5(arg_1_0.discountTextTF, var_1_7 .. "%OFF")

	setText = var_1_5

	local var_1_8 = arg_1_0.countTF

	math = var_10

	var_1_5(var_1_8, var_10.ceil(var_1_6))

	GetImageSpriteFromAtlasAsync = var_1_5
	Drop = var_1_8

	local var_1_9 = var_1_8.New
	local var_1_10 = {}

	DROP_TYPE_RESOURCE = var_12
	var_1_10.type = var_12
	var_1_10.id = arg_1_1:getConfig("resource_type")

	local var_1_11 = var_1_9(var_1_10)
	local var_1_12 = var_9.getIcon(var_1_11)
	local var_1_13 = ""

	tf = var_1_11

	var_1_5(var_1_12, var_1_13, var_1_11(arg_1_0.resIconTF), false)

	return
end

return var_0_1
