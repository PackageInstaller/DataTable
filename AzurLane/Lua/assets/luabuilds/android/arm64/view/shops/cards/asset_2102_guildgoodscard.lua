class = var_0_10000

local var_0_0 = "GuildGoodsCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseGoodsCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	setActive = var_2

	var_2(arg_1_0.limitCountLabelTF, true)

	return
end

function var_0_1.update(arg_2_0, arg_2_1)
	if arg_2_0.goodsVO ~= arg_2_1 then
		arg_2_0.goodsVO = arg_2_1

		arg_2_0:Init()
	else
		arg_2_0.goodsVO = arg_2_1
	end

	setText = var_2

	local var_2_0 = arg_2_0.limitCountLabelTF

	i18n = var_1_10005

	local var_2_1 = var_1_10005("activity_shop_exchange_count")
	local var_2_2 = arg_2_0.goodsVO.count
	local var_2_3 = "/"
	local var_2_4 = arg_2_0.goodsVO

	var_2(var_2_0, var_2_1 .. var_2_2 .. var_2_3 .. var_8.GetLimit(var_2_4))

	setActive = var_2

	var_2(arg_2_0.limitCountLabelTF, true)

	local var_2_5 = arg_2_0.goodsVO
	local var_2_6 = var_2.CanPurchase(var_2_5)

	setActive = var_1_10003

	var_1_10003(arg_2_0.mask, not var_2_6)

	setActive = var_1_10003

	var_1_10003(arg_2_0.selloutTag, not var_2_6)

	return
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0.goodsVO
	local var_3_1 = var_1.getConfig(var_3_0, "goods_name")
	local var_3_2 = arg_3_0.goodsVO
	local var_3_3 = var_2.GetDropInfo(var_3_2)

	updateDrop = var_3_0

	var_3_0(arg_3_0.itemTF, var_3_3)

	setScrollText = var_3_0

	var_3_0(arg_3_0.nameTxt, var_3_1)

	setText = var_3_0

	local var_3_4 = arg_3_0.countTF
	local var_3_5 = arg_3_0.goodsVO

	var_3_0(var_3_4, var_6.getConfig(var_3_5, "price"))

	GetImageSpriteFromAtlasAsync = var_3_0

	var_3_0("ui/share/msgbox_atlas", "res_guildicon", arg_3_0.resIconTF)

	GetImageSpriteFromAtlasAsync = var_3_0

	local var_3_6 = arg_3_0.goodsVO

	var_3_0(var_5.getConfig(var_3_6, "goods_icon"), "", arg_3_0.itemIconTF)

	setText = var_3_0

	local var_3_7 = arg_3_0.itemCountTF
	local var_3_8 = arg_3_0.goodsVO

	var_3_0(var_3_7, var_6.getConfig(var_3_8, "num"))

	local var_3_9 = arg_3_0.goodsVO
	local var_3_10

	if not var_3.getConfig(var_3_9, "goods_rarity") then
		ItemRarity = var_3_10
		var_3_10 = var_3_10.Gray
	end

	setImageSprite = var_3_2

	local var_3_11 = arg_3_0.itemIconBgTF

	GetSpriteFromAtlas = var_7

	local var_3_12 = "weaponframes"
	local var_3_13 = "bg"

	ItemRarity = var_1_10011

	var_3_2(var_3_11, var_7(var_3_12, var_3_13 .. var_1_10011.Rarity2Print(var_3_10)))

	setImageColor = var_3_2

	local var_3_14 = arg_3_0.itemIconFrameTF

	Color = var_7

	local var_3_15 = var_7.NewHex

	ItemRarity = var_3_12

	var_3_2(var_3_14, var_3_15(var_3_12.Rarity2FrameHexColor(var_3_10)))

	setActive = var_3_2

	local var_3_16 = arg_3_0.groupLocked
	local var_3_17 = arg_3_0.goodsVO
	local var_3_19

	if not var_7.Selectable(var_3_17) then
		local var_3_18 = arg_3_0.itemTF

		var_3_19 = var_7.Find(var_3_18, "group_locked").gameObject.activeSelf
	else
		var_3_19 = false
	end

	if false then
		var_3_19 = true
	end

	var_3_2(var_3_16, var_3_19)

	return
end

function var_0_1.OnDispose(arg_4_0)
	arg_4_0.goodsVO = nil

	return
end

return var_0_1
