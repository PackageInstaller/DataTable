class = var_0_10000

local var_0_0 = "ChargeGoodsCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...shops.cards.GoodsCard"))

function var_0_1.update(arg_1_0, arg_1_1)
	arg_1_0.goodsVO = arg_1_1

	local var_1_0 = arg_1_0.goodsVO
	local var_1_1 = var_2.canPurchase(var_1_0)

	setActive = var_1_0

	var_1_0(arg_1_0.mask, not var_1_1)

	setActive = var_1_0

	var_1_0(arg_1_0.stars, false)

	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.getDropInfo(var_1_2)

	updateDrop = var_1_2

	var_1_2(arg_1_0.itemTF, var_1_3)

	local var_1_4 = var_1_3
	local var_1_5

	if not var_1_3.getConfig(var_1_4, "name") then
		var_1_5 = ""
	end

	setScrollText = var_1_4

	var_1_4(arg_1_0.nameTxt, var_1_5)

	local var_1_6 = arg_1_1:GetPrice()
	local var_1_7 = arg_1_1
	local var_1_8 = arg_1_1.getConfig(var_1_7, "discount")

	setActive = var_1_7

	var_1_7(arg_1_0.discountTF, arg_1_1:isDisCount())

	setText = var_1_7

	var_1_7(arg_1_0.discountTextTF, var_1_8 .. "%OFF")

	setText = var_1_7

	local var_1_9 = arg_1_0.countTF

	math = var_9

	var_1_7(var_1_9, var_9.ceil(var_1_6))

	GetImageSpriteFromAtlasAsync = var_1_7
	Drop = var_1_9

	local var_1_10 = var_1_9.New
	local var_1_11 = {}

	DROP_TYPE_RESOURCE = var_10
	var_1_11.type = var_10
	var_1_11.id = arg_1_1:getConfig("resource_type")

	local var_1_12 = var_1_10(var_1_11)
	local var_1_13 = var_8.getIcon(var_1_12)
	local var_1_14 = ""

	tf = var_10

	var_1_7(var_1_13, var_1_14, var_10(arg_1_0.resIconTF), false)

	return
end

return var_0_1
