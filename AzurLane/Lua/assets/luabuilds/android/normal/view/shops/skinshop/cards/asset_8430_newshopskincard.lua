class = var_0_10000

local var_0_0 = var_0_10000("NewShopSkinCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0._content = var_2.Find(var_1_0, "frame/content")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_2.Find(var_1_1, "frame/content/main/bg/mask/icon")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0._icon = var_1_3(var_1_2, var_4(var_1_10005))

	local var_1_4 = arg_1_0._tf

	arg_1_0._priceTF = var_2.Find(var_1_4, "frame/content/main/bg/price")
	setActive = var_2

	var_2(arg_1_0._priceTF, false)

	local var_1_5 = arg_1_0._priceTF
	local var_1_6 = var_2.Find(var_1_5, "gem")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0._priceIcon = var_1_7(var_1_6, var_4(var_1_10005))

	local var_1_8 = arg_1_0._priceTF
	local var_1_9 = var_2.Find(var_1_8, "gem/Text")
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0._priceTxt = var_1_10(var_1_9, var_4(var_1_10005))

	local var_1_11 = arg_1_0._priceTF
	local var_1_12 = var_2.Find(var_1_11, "originalprice")
	local var_1_13 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0._opriceTxt = var_1_13(var_1_12, var_4(var_1_10005))

	local var_1_14 = arg_1_0._tf
	local var_1_15 = var_2.Find(var_1_14, "frame/content/top/tag_activity")
	local var_1_16 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.tagImg = var_1_16(var_1_15, var_4(var_1_10005))

	local var_1_17 = arg_1_0._tf

	arg_1_0.discountTag = var_2.Find(var_1_17, "frame/content/top/tag_discount")

	local var_1_18 = arg_1_0.discountTag
	local var_1_19 = var_2.Find(var_1_18, "Text")
	local var_1_20 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.discountTagOffTxt = var_1_20(var_1_19, var_4(var_1_10005))
	arg_1_0.isSelected = false

	local var_1_21 = arg_1_0._tf

	arg_1_0.probability = var_2.Find(var_1_21, "frame/content/top/tag_probability")
	setActive = var_2

	var_2(arg_1_0.probability, false)

	return
end

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = -2
local var_0_8 = -3
local var_0_9 = -4
local var_0_10 = {
	[302053] = 39
}
local var_0_11 = {
	[var_0_1] = {
		"rexiao",
		"hot_sells"
	},
	[var_0_2] = {
		"xinpin",
		"xinpin"
	},
	[var_0_3] = {
		"tuijian",
		"tujian"
	},
	[var_0_4] = {
		"huodong",
		"huodong"
	},
	[var_0_5] = {
		"",
		""
	},
	[var_0_6] = {
		"fanchang_2",
		""
	},
	[var_0_7] = {
		"",
		""
	},
	[var_0_8] = {
		"yigoumai",
		"clothing"
	},
	[var_0_9] = {
		"",
		"clothing"
	}
}

function var_0_0.GetTagId(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.buyCount == 0

	if arg_2_1 and var_2_0 then
		return var_0_6
	end

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.getConfig(var_2_1, "genre")

	ShopArgs = var_2_1

	if var_2_2 == var_2_1.SkinShopTimeLimit then
		return var_0_7
	end

	if not var_2_0 then
		return var_0_8
	end

	local var_2_3 = arg_2_0:getConfig("tag")

	if (arg_2_0:isDisCount() or var_2_3 == var_0_5) and not arg_2_0:IsItemDiscountType() then
		return var_0_5
	elseif var_0_11[var_2_3] then
		return var_2_3
	else
		return var_0_9
	end

	return
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.commodity = arg_3_1
	arg_3_0.isReturn = arg_3_3

	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getSkinId(var_3_0)

	pg = var_3_0
	arg_3_0.shipSkinConfig = var_3_0.ship_skin_template[var_3_1]

	local var_3_2 = var_6[var_3_1].prefab
	local var_3_3 = arg_3_0._icon

	var_3_3.sprite = nil
	LoadSpriteAsync = var_3_3

	var_3_3("shipYardIcon/" .. var_3_2, function(arg_4_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_3_0._icon) then
			arg_3_0._icon.sprite = arg_4_0
		end

		return
	end)

	local var_3_4 = false
	local var_3_5 = false
	local var_3_6 = arg_3_0.commodity.type

	Goods = var_1_10011

	local var_3_8

	if var_3_6 == var_1_10011.TYPE_SKIN then
		local var_3_7 = arg_3_1

		var_3_8 = arg_3_1.getConfig(var_3_7, "resource_type")
		LoadSpriteAsync = var_3_7
		Drop = var_13

		local var_3_9 = var_13.New
		local var_3_10 = {}

		DROP_TYPE_RESOURCE = var_1_10015
		var_3_10.type = var_1_10015
		var_3_10.id = var_3_8

		local var_3_11 = var_3_9(var_3_10)

		var_3_7(var_13.getIcon(var_3_11), function(arg_5_0)
			IsNil = var_2_10001

			if var_2_10001(arg_3_0._priceIcon) then
				return
			end

			arg_3_0._priceIcon.sprite = arg_5_0

			return
		end)

		local var_3_12 = arg_3_1:getConfig("resource_num")
		local var_3_13 = arg_3_1:isDisCount()
		local var_3_14, var_3_15 = arg_3_1:GetPrice()

		arg_3_0._priceTxt.text = var_3_14

		local var_3_16 = arg_3_0._opriceTxt

		var_3_16.text = var_3_12
		setActive = var_3_16
		go = var_1_10017

		var_3_16(var_1_10017(arg_3_0._opriceTxt), var_3_13 and var_3_15 > 0)

		if var_0_0.GetTagId(arg_3_1, arg_3_3) == var_0_5 then
			var_3_4 = true

			local var_3_17 = arg_3_0.discountTagOffTxt

			string = var_18
			var_3_17.text = var_18.format("%0.2f", var_3_15) .. "%"
		elseif var_16 == var_0_7 then
			var_3_5 = true
		else
			local var_3_18 = var_0_11[var_16][1]
			local var_3_19 = var_0_11[var_16][2]

			arg_3_0.tagImg.enabled = var_3_18 and var_3_18 ~= ""

			if arg_3_0.tagImg.enabled then
				local var_3_20 = arg_3_0.tagImg

				GetSpriteFromAtlas = var_20
				var_3_20.sprite = var_20("ui/SkinShopUI_atlas", "tag_" .. var_3_18)
			end
		end
	end

	setActive = var_3_8

	var_3_8(arg_3_0.tagImg.gameObject, var_10 and not var_3_4 and not var_3_5)

	setActive = var_3_8

	var_3_8(arg_3_0.discountTag, var_10 and var_3_4)

	local var_3_21 = var_0_10[var_3_1] or 0

	setAnchoredPosition = var_13

	var_13(arg_3_0._icon.gameObject, {
		y = var_3_21
	})
	arg_3_0:UpdateSelected(arg_3_2)

	if arg_3_4 then
		setActive = var_13

		var_13(arg_3_0.probability, true)

		local var_3_22 = arg_3_4 or 0

		setText = var_14

		local var_3_23 = arg_3_0.probability
		local var_3_24 = var_15.Find(var_3_23, "Text")
		local var_3_25 = " "

		string = var_17

		var_14(var_3_24, var_3_25 .. var_17.format("%0.1f", var_3_22 / 100) .. "%")
	end

	return
end

function var_0_0.UpdateSelected(arg_6_0, arg_6_1)
	if arg_6_0.isSelected ~= arg_6_1 then
		arg_6_0.isSelected = arg_6_1

		local var_6_0 = arg_6_1 and -7.8 or -61
		local var_6_1 = arg_6_0._content

		Vector3 = var_1_10004
		var_6_1.localPosition = var_1_10004(0, var_6_0, 0)

		local var_6_2 = arg_6_0.commodity.type

		Goods = var_4

		local var_6_3 = var_6_2 == var_4.TYPE_SKIN

		setActive = var_4

		var_4(arg_6_0._priceTF, arg_6_1 and var_6_3)
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
