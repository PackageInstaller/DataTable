class = var_0_10000

local var_0_0 = var_0_10000("NewServerGoodsCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._tr = arg_1_1.transform

	local var_1_0 = arg_1_0._tr

	arg_1_0.itemTF = var_2.Find(var_1_0, "item")

	local var_1_1 = arg_1_0.itemTF

	arg_1_0.itemIconBgTF = var_2.Find(var_1_1, "icon_bg")

	local var_1_2 = arg_1_0.itemTF

	arg_1_0.itemIconFrameTF = var_2.Find(var_1_2, "icon_bg/frame")

	local var_1_3 = arg_1_0.itemTF

	arg_1_0.itemIconTF = var_2.Find(var_1_3, "icon_bg/icon")

	local var_1_4 = arg_1_0.itemTF
	local var_1_5 = var_2.Find(var_1_4, "icon_bg/count")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.itemCountTF = var_1_6(var_1_5, var_4(var_1_10005))

	local var_1_7 = arg_1_0._tr

	arg_1_0.discountTF = var_2.Find(var_1_7, "item/discount")

	local var_1_8 = arg_1_0._tr
	local var_1_9 = var_2.Find(var_1_8, "item/name_mask/name")
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTF = var_1_10(var_1_9, var_4(var_1_10005))

	local var_1_11 = arg_1_0._tr

	arg_1_0.consumeIconTF = var_2.Find(var_1_11, "item/consume/contain/icon")

	local var_1_12 = arg_1_0._tr
	local var_1_13 = var_2.Find(var_1_12, "item/consume/contain/Text")
	local var_1_14 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.consumeTxtTF = var_1_14(var_1_13, var_4(var_1_10005))

	local var_1_15 = arg_1_0._tr

	arg_1_0.sellOutMaskTF = var_2.Find(var_1_15, "selloutmask")

	local var_1_16 = arg_1_0._tr

	arg_1_0.levelMaskTF = var_2.Find(var_1_16, "levelmask")

	local var_1_17 = arg_1_0._tr
	local var_1_18 = var_2.Find(var_1_17, "item/count_contain/count")
	local var_1_19 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.cntTxt = var_1_19(var_1_18, var_4(var_1_10005))
	setActive = var_2

	var_2(arg_1_0.discountTF, false)

	setText = var_2

	local var_1_20 = arg_1_0.sellOutMaskTF
	local var_1_21 = var_3.Find(var_1_20, "ch")

	i18n = var_1_20

	var_2(var_1_21, var_1_20("word_sell_out"))

	setText = var_2

	local var_1_22 = arg_1_0.levelMaskTF
	local var_1_23 = var_3.Find(var_1_22, "ch")

	i18n = var_1_22

	var_2(var_1_23, var_1_22("word_sell_lock"))

	setText = var_2

	local var_1_24 = arg_1_0._tr
	local var_1_25 = var_3.Find(var_1_24, "item/count_contain/label")

	i18n = var_1_24

	var_2(var_1_25, var_1_24("activity_shop_exchange_count"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.shop = arg_2_2

	if arg_2_1 ~= arg_2_0.commodity then
		arg_2_0.commodity = arg_2_1

		arg_2_0:Init()
		arg_2_0:Flush()
	else
		arg_2_0.commodity = arg_2_1

		arg_2_0:Flush()
	end

	return
end

function var_0_0.Flush(arg_3_0)
	local var_3_0 = arg_3_0.cntTxt
	local var_3_1 = arg_3_0.commodity
	local var_3_2 = var_2.GetCanPurchaseCnt(var_3_1)
	local var_3_3 = "/"
	local var_3_4 = arg_3_0.commodity

	var_3_0.text = var_3_2 .. var_3_3 .. var_4.GetCanPurchaseMaxCnt(var_3_4)
	setActive = var_3_0

	local var_3_5 = arg_3_0.sellOutMaskTF
	local var_3_6 = arg_3_0.commodity

	var_3_0(var_3_5, not var_3.CanPurchase(var_3_6))

	setActive = var_3_0

	local var_3_7 = arg_3_0.levelMaskTF
	local var_3_8 = arg_3_0.commodity
	local var_3_9 = var_3.IsOpening
	local var_3_10 = arg_3_0.shop

	var_3_0(var_3_7, not var_3_9(var_3_8, var_5.GetStartTime(var_3_10)))

	return
end

function var_0_0.Init(arg_4_0)
	local var_4_0 = arg_4_0.commodity
	local var_4_1 = var_1.GetDesc(var_4_0).name

	string = var_1_10003

	if var_1_10003.match(var_4_1, "(%d+)") then
		setText = var_3

		local var_4_2 = arg_4_0.nameTF

		shortenString = var_5

		var_3(var_4_2, var_5(var_4_1, 5))
	else
		setText = var_3

		local var_4_3 = arg_4_0.nameTF

		shortenString = var_5

		var_3(var_4_3, var_5(var_4_1, 6))
	end

	local var_4_4 = arg_4_0.commodity
	local var_4_5 = var_3.GetConsume(var_4_4)
	local var_4_6 = arg_4_0.consumeTxtTF

	var_4_6.text = var_4_5.count
	GetImageSpriteFromAtlasAsync = var_4_6

	var_4_6(var_4_5:getConfig("icon"), "", arg_4_0.consumeIconTF)

	local var_4_7 = arg_4_0.itemCountTF
	local var_4_8 = arg_4_0.commodity

	var_4_7.text = var_5.GetDropCnt(var_4_8)
	GetImageSpriteFromAtlasAsync = var_4_7

	var_4_7(var_1.icon, "", arg_4_0.itemIconTF)

	local var_4_9

	if not var_1.rarity then
		ItemRarity = var_4_9
		var_4_9 = var_4_9.Gray
	end

	setImageSprite = var_5

	local var_4_10 = arg_4_0.itemIconBgTF

	GetSpriteFromAtlas = var_7

	local var_4_11 = "weaponframes"
	local var_4_12 = "bg"

	ItemRarity = var_1_10010

	var_5(var_4_10, var_7(var_4_11, var_4_12 .. var_1_10010.Rarity2Print(var_4_9)))

	setImageColor = var_5

	local var_4_13 = arg_4_0.itemIconFrameTF

	Color = var_7

	local var_4_14 = var_7.NewHex

	ItemRarity = var_4_11

	var_5(var_4_13, var_4_14(var_4_11.Rarity2FrameHexColor(var_4_9)))

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
