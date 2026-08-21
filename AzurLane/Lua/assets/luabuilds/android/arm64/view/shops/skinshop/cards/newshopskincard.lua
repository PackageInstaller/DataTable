local var_0_0 = class("NewShopSkinCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0._content = arg_1_0._tf:Find("frame/content")
	arg_1_0._icon = arg_1_0._tf:Find("frame/content/main/bg/mask/icon"):GetComponent(typeof(Image))
	arg_1_0._priceTF = arg_1_0._tf:Find("frame/content/main/bg/price")

	setActive(arg_1_0._priceTF, false)

	arg_1_0._priceIcon = arg_1_0._priceTF:Find("gem"):GetComponent(typeof(Image))
	arg_1_0._priceTxt = arg_1_0._priceTF:Find("gem/Text"):GetComponent(typeof(Text))
	arg_1_0._opriceTxt = arg_1_0._priceTF:Find("originalprice"):GetComponent(typeof(Text))
	arg_1_0.tagImg = arg_1_0._tf:Find("frame/content/top/tag_activity"):GetComponent(typeof(Image))
	arg_1_0.discountTag = arg_1_0._tf:Find("frame/content/top/tag_discount")
	arg_1_0.discountTagOffTxt = arg_1_0.discountTag:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.isSelected = false
	arg_1_0.probability = arg_1_0._tf:Find("frame/content/top/tag_probability")

	setActive(arg_1_0.probability, false)

	return
end

local var_0_1 = {
	[302053] = 39
}
local var_0_2 = {
	{
		"rexiao",
		"hot_sells"
	},
	{
		"xinpin",
		"xinpin"
	},
	{
		"tuijian",
		"tujian"
	},
	{
		"huodong",
		"huodong"
	},
	{
		"",
		""
	},
	{
		"fanchang_2",
		""
	},
	[-2] = {
		"",
		""
	},
	[-3] = {
		"yigoumai",
		"clothing"
	},
	[-4] = {
		"",
		"clothing"
	}
}

function var_0_0.GetTagId(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.buyCount == 0

	if arg_2_1 and var_2_0 then
		return var_0
	end

	if arg_2_0:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
		return var_0
	end

	if not var_2_0 then
		return var_0
	end

	local var_2_1 = arg_2_0:getConfig("tag")

	if (arg_2_0:isDisCount() or var_2_1 == var_0) and not arg_2_0:IsItemDiscountType() then
		return var_0
	elseif var_0_2[var_2_1] then
		return var_2_1
	else
		return var_0
	end

	return
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.commodity = arg_3_1
	arg_3_0.isReturn = arg_3_3

	local var_3_0 = arg_3_1:getSkinId()

	arg_3_0.shipSkinConfig = pg.ship_skin_template[var_3_0]
	arg_3_0._icon.sprite = nil

	LoadSpriteAsync("shipYardIcon/" .. pg.ship_skin_template[var_3_0].prefab, function(arg_4_0)
		if not IsNil(arg_3_0._icon) then
			arg_3_0._icon.sprite = arg_4_0
		end

		return
	end)

	local var_3_1 = false
	local var_3_2 = false
	local var_3_3 = arg_3_0.commodity.type == Goods.TYPE_SKIN

	if arg_3_0.commodity.type == Goods.TYPE_SKIN then
		LoadSpriteAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = arg_3_1:getConfig("resource_type")
		}):getIcon(), function(arg_5_0)
			if IsNil(arg_3_0._priceIcon) then
				return
			end

			arg_3_0._priceIcon.sprite = arg_5_0

			return
		end)

		local var_3_4, var_3_5 = arg_3_1:GetPrice()

		arg_3_0._priceTxt.text = var_3_4
		arg_3_0._opriceTxt.text = arg_3_1:getConfig("resource_num")

		setActive(go(arg_3_0._opriceTxt), arg_3_1:isDisCount() and var_3_5 > 0)

		local var_3_6 = var_0_0.GetTagId(arg_3_1, arg_3_3)

		if var_3_6 == var_0 then
			var_3_1 = true
			arg_3_0.discountTagOffTxt.text = string.format("%0.2f", var_3_5) .. "%"
		elseif var_3_6 == var_0 then
			var_3_2 = true
		else
			local var_3_7 = var_0_2[var_3_6][1]

			arg_3_0.tagImg.enabled = var_0_2[var_3_6][1] and var_3_7 ~= ""

			if arg_3_0.tagImg.enabled then
				arg_3_0.tagImg.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", "tag_" .. var_3_7)
			end
		end
	end

	setActive(arg_3_0.tagImg.gameObject, var_3_3 and not var_3_1 and not var_3_2)
	setActive(arg_3_0.discountTag, var_3_3 and var_3_1)
	setAnchoredPosition(arg_3_0._icon.gameObject, {
		y = var_0_1[var_3_0] or 0
	})
	arg_3_0:UpdateSelected(arg_3_2)

	if arg_3_4 then
		setActive(arg_3_0.probability, true)
		setText(arg_3_0.probability:Find("Text"), " " .. string.format("%0.1f", (arg_3_4 or 0) / 100) .. "%")
	end

	return
end

function var_0_0.UpdateSelected(arg_6_0, arg_6_1)
	if arg_6_0.isSelected ~= arg_6_1 then
		arg_6_0.isSelected = arg_6_1
		arg_6_0._content.localPosition = Vector3(0, arg_6_1 and -7.8 or -61, 0)

		local var_6_0 = arg_6_0.commodity.type == Goods.TYPE_SKIN

		setActive(arg_6_0._priceTF, arg_6_1 and var_6_0)
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:UpdateSelected(false)

	arg_7_0._go = nil
	arg_7_0._tf = nil

	return
end

return var_0_0
