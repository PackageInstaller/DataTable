class = var_0_10000

local var_0_0 = "BackYardThemeTemplatePurchaseMsgbox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...Shop.msgbox.BackYardThemeMsgBoxPage"))

function var_0_1.SetUp(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.dorm = arg_1_2
	arg_1_0.template = arg_1_1
	arg_1_0.player = arg_1_3
	arg_1_0.count = 1
	arg_1_0.maxCount = 1

	arg_1_0:UpdateMainInfo()
	arg_1_0:UpdateBtns()
	arg_1_0:UpdatePrice()

	local var_1_0 = arg_1_0

	arg_1_0.Show(var_1_0)

	local var_1_1 = arg_1_0.purchase

	i18n = var_1_0
	var_1_1.text = var_1_0("purchase_backyard_theme_desc_for_onekey")
	setText = var_1_1

	local var_1_2 = arg_1_0.goldPurchaseBtn
	local var_1_3 = var_5.Find(var_1_2, "content/Text")

	i18n = var_1_2

	var_1_1(var_1_3, var_1_2("fur_onekey_buy"))

	return
end

function var_0_1.UpdateMainInfo(arg_2_0)
	local var_2_0 = arg_2_0.nameTxt
	local var_2_1 = arg_2_0.template

	var_2_0.text = var_2.GetName(var_2_1)

	local var_2_2 = arg_2_0.descTxt
	local var_2_3 = arg_2_0.template

	var_2_2.text = var_2.GetDesc(var_2_3)
	setActive = var_2_2

	var_2_2(arg_2_0.icon.gameObject, false)

	setActive = var_2_2

	var_2_2(arg_2_0.rawIcon.gameObject, false)

	local var_2_4 = arg_2_0.template
	local var_2_5 = var_1.GetIconMd5(var_2_4)

	BackYardThemeTempalteUtil = var_2_4

	local var_2_6 = var_2_4.GetTexture
	local var_2_7 = arg_2_0.template

	var_2_6(var_3.GetTextureIconName(var_2_7), var_2_5, function(arg_3_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_2_0.rawIcon) and arg_3_0 then
			setActive = var_1

			var_1(arg_2_0.rawIcon.gameObject, true)

			arg_2_0.rawIcon.texture = arg_3_0
		end

		return
	end)

	return
end

function var_0_1.GetAddList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = arg_4_0.template
	local var_4_2 = var_2.GetFurnitureCnt(var_4_1)
	local var_4_3 = arg_4_0.dorm
	local var_4_4 = var_3.GetPurchasedFurnitures(var_4_3)

	pairs = var_4_3

	for iter_4_0, iter_4_1 in var_4_3(var_4_2) do
		pg = var_1_10009

		if var_1_10009.furniture_data_template[iter_4_0] then
			var_1_10009 = var_4_4[iter_4_0]

			local var_4_5 = 0

			if not var_1_10009 then
				Furniture = var_1_10011
				var_1_10009 = var_1_10011.New({
					id = iter_4_0
				})
			else
				var_4_5 = var_1_10009.count
			end

			if var_1_10009:canPurchase() and var_1_10009:inTime() and var_1_10009:canPurchaseByDormMoeny() then
				for iter_4_2 = 1, iter_4_1 - var_4_5 do
					table = var_1_10015

					var_1_10015.insert(var_4_0, var_1_10009)
				end
			end
		end
	end

	return var_4_0
end

function var_0_1.OnDestroy(arg_5_0)
	var_0_1.super.OnDestroy(arg_5_0)

	IsNil = var_1

	if not var_1(arg_5_0.rawIcon.texture) then
		Object = var_1

		var_1.Destroy(arg_5_0.rawIcon.texture)

		arg_5_0.rawIcon.texture = nil
	end

	return
end

return var_0_1
