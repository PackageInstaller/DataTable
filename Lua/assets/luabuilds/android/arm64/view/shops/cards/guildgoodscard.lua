local var_0_0 = class("GuildGoodsCard", import(".BaseGoodsCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
	setActive(arg_1_0.limitCountLabelTF, true)

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_0.goodsVO ~= arg_2_1 then
		arg_2_0.goodsVO = arg_2_1

		arg_2_0:Init()
	else
		arg_2_0.goodsVO = arg_2_1
	end

	setText(arg_2_0.limitCountLabelTF, i18n("activity_shop_exchange_count") .. arg_2_0.goodsVO.count .. "/" .. arg_2_0.goodsVO:GetLimit())
	setActive(arg_2_0.limitCountLabelTF, true)

	local var_2_0 = arg_2_0.goodsVO:CanPurchase()

	setActive(arg_2_0.mask, not var_2_0)
	setActive(arg_2_0.selloutTag, not var_2_0)

	return
end

function var_0_0.Init(arg_3_0)
	updateDrop(arg_3_0.itemTF, (arg_3_0.goodsVO:GetDropInfo()))
	setScrollText(arg_3_0.nameTxt, (arg_3_0.goodsVO:getConfig("goods_name")))
	setText(arg_3_0.countTF, arg_3_0.goodsVO:getConfig("price"))
	GetImageSpriteFromAtlasAsync("ui/share/msgbox_atlas", "res_guildicon", arg_3_0.resIconTF)
	GetImageSpriteFromAtlasAsync(arg_3_0.goodsVO:getConfig("goods_icon"), "", arg_3_0.itemIconTF)
	setText(arg_3_0.itemCountTF, arg_3_0.goodsVO:getConfig("num"))

	local var_3_0 = arg_3_0.goodsVO:getConfig("goods_rarity") or ItemRarity.Gray

	setImageSprite(arg_3_0.itemIconBgTF, GetSpriteFromAtlas("weaponframes", "bg" .. ItemRarity.Rarity2Print(var_3_0)))
	setImageColor(arg_3_0.itemIconFrameTF, Color.NewHex(ItemRarity.Rarity2FrameHexColor(var_3_0)))
	setActive(arg_3_0.groupLocked, not arg_3_0.goodsVO:Selectable() and arg_3_0.itemTF:Find("group_locked").gameObject.activeSelf)

	return
end

function var_0_0.OnDispose(arg_4_0)
	arg_4_0.goodsVO = nil

	return
end

return var_0_0
