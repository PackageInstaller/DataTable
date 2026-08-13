class = var_0_10000

local var_0_0 = "BackYardThemeMsgBoxPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardFurnitureMsgBoxPage"))

function var_0_1.getUIName(arg_1_0)
	return "ThemeMsgboxPage"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.purchaseTr = var_1.Find(var_2_0, "frame/tip")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/tip/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.purchase = var_2_3(var_2_2, var_4(var_1_10006))

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.gemPurchaseBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.goldPurchaseBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		if #var_0.GetAddList(var_5_0) <= 0 then
			return
		end

		_ = var_1

		local var_5_1 = var_1.map(var_0, function(arg_6_0)
			return arg_6_0.id
		end)
		local var_5_2 = arg_3_0
		local var_5_3 = var_1.emit

		NewBackYardShopMediator = var_4

		local var_5_4 = var_4.ON_SHOPPING
		local var_5_5 = var_5_1

		PlayerConst = var_2_10006

		var_5_3(var_5_2, var_5_4, var_5_5, var_2_10006.ResDormMoney)

		local var_5_6 = arg_3_0

		var_1.Hide(var_5_6)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.SetUp(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.dorm = arg_7_2
	arg_7_0.themeVO = arg_7_1
	arg_7_0.player = arg_7_3
	arg_7_0.count = 1
	arg_7_0.maxCount = 1

	arg_7_0:UpdateMainInfo()
	arg_7_0:UpdateBtns()
	arg_7_0:UpdatePrice()
	arg_7_0:Show()

	local var_7_0 = arg_7_0.purchase

	i18n = var_1_10005
	var_7_0.text = var_1_10005("purchase_backyard_theme_desc_for_onekey")
	setActive = var_7_0

	var_7_0(arg_7_0.purchaseTr, true)

	setText = var_7_0

	local var_7_1 = arg_7_0.gemPurchaseBtn
	local var_7_2 = var_6.Find(var_7_1, "content/Text")

	i18n = var_7

	var_7_0(var_7_2, var_7("word_buy"))

	setText = var_7_0

	local var_7_3 = arg_7_0.goldPurchaseBtn
	local var_7_4 = var_6.Find(var_7_3, "content/Text")

	i18n = var_7

	var_7_0(var_7_4, var_7("word_buy"))

	return
end

function var_0_1.UpdateMainInfo(arg_8_0)
	local var_8_0 = arg_8_0.nameTxt
	local var_8_1 = arg_8_0.themeVO

	var_8_0.text = var_2.getConfig(var_8_1, "name")
	arg_8_0.themeTxt.text = ""

	local var_8_2 = arg_8_0.descTxt
	local var_8_3 = arg_8_0.themeVO

	var_8_2.text = var_2.getConfig(var_8_3, "desc")
	arg_8_0.maxCnt.text = ""

	local var_8_4 = arg_8_0.icon

	GetSpriteFromAtlas = var_2
	var_8_4.sprite = var_2("BackYardTheme/" .. arg_8_0.themeVO.id, "")
	tf = var_8_4

	local var_8_5 = var_8_4(arg_8_0.icon.gameObject)

	Vector2 = var_2
	var_8_5.sizeDelta = var_2(336, 336)
	arg_8_0.maxBtnTxt.text = "+" .. arg_8_0.maxCount

	return
end

function var_0_1.UpdateBtns(arg_9_0)
	local var_9_0 = true
	local var_9_1 = false

	setActive = var_1_10003

	var_1_10003(arg_9_0.goldPurchaseBtn, var_9_0)

	setActive = var_1_10003

	var_1_10003(arg_9_0.gemPurchaseBtn, var_9_1)

	setActive = var_1_10003

	var_1_10003(arg_9_0.gemIcon, var_9_1)

	setActive = var_1_10003

	var_1_10003(arg_9_0.gemCount, var_9_1)

	setActive = var_1_10003

	var_1_10003(arg_9_0.goldIcon, var_9_0)

	setActive = var_1_10003

	var_1_10003(arg_9_0.goldCount, var_9_0)

	setActive = var_1_10003

	var_1_10003(arg_9_0.line, var_9_0 and var_9_1)

	return
end

function var_0_1.GetAddList(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = arg_10_0.themeVO
	local var_10_2 = var_2.GetFurnitures(var_10_1)
	local var_10_3 = arg_10_0.dorm
	local var_10_4 = var_3.GetPurchasedFurnitures(var_10_3)

	ipairs = var_10_1

	for iter_10_0, iter_10_1 in var_10_1(var_10_2) do
		if not var_10_4[iter_10_1] then
			table = var_9

			local var_10_5 = var_9.insert
			local var_10_6 = var_10_0

			Furniture = var_1_10012

			var_10_5(var_10_6, var_1_10012.New({
				id = iter_10_1
			}))
		end
	end

	return var_10_0
end

function var_0_1.UpdatePrice(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.GetAddList(var_11_0)
	local var_11_2 = 0

	_ = var_11_0

	local var_11_3 = var_11_0.reduce(var_11_1, 0, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1
		local var_12_1 = arg_12_1.getPrice

		PlayerConst = var_2_10005

		return arg_12_0 + var_12_1(var_12_0, var_2_10005.ResDormMoney)
	end)

	arg_11_0.gemCount.text = var_11_2 * arg_11_0.count
	arg_11_0.goldCount.text = var_11_3 * arg_11_0.count

	arg_11_0:UpdateEnergy(var_11_1)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	return
end

return var_0_1
