class = var_0_10000

local var_0_0 = "BackYardThemeMsgBoxForAllPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardThemeMsgBoxPage"))

function var_0_1.SetUp(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.SetUp(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = arg_1_0.purchase

	i18n = var_1_10005
	var_1_0.text = var_1_10005("purchase_backyard_theme_desc_for_all")
	setActive = var_1_0

	var_1_0(arg_1_0.purchaseTr, true)

	setText = var_1_0

	local var_1_1 = arg_1_0.gemPurchaseBtn
	local var_1_2 = var_6.Find(var_1_1, "content/Text")

	i18n = var_7

	var_1_0(var_1_2, var_7("word_buy"))

	setText = var_1_0

	local var_1_3 = arg_1_0.goldPurchaseBtn
	local var_1_4 = var_6.Find(var_1_3, "content/Text")

	i18n = var_7

	var_1_0(var_1_4, var_7("word_buy"))

	return
end

function var_0_1.GetAddList(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = arg_2_0.themeVO
	local var_2_2 = var_2.GetFurnitures(var_2_1)
	local var_2_3 = arg_2_0.dorm
	local var_2_4 = var_3.GetPurchasedFurnitures(var_2_3)

	ipairs = var_2_1

	for iter_2_0, iter_2_1 in var_2_1(var_2_2) do
		pg = var_1_10009

		if var_1_10009.furniture_data_template[iter_2_1].count > 1 then
			local var_2_5 = arg_2_0.dorm
			local var_2_6 = var_10.GetOwnFurnitureCount(var_2_5, iter_2_1)

			for iter_2_2 = 1, var_1_10009 - var_2_6 do
				table = var_1_10015
				var_1_10015 = var_1_10015.insert

				local var_2_7 = var_2_0

				Furniture = var_1_10018

				var_1_10015(var_2_7, var_1_10018.New({
					id = iter_2_1
				}))
			end
		elseif not var_2_4[iter_2_1] then
			table = var_10

			local var_2_8 = var_10.insert
			local var_2_9 = var_2_0

			Furniture = var_1_10013

			var_2_8(var_2_9, var_1_10013.New({
				id = iter_2_1
			}))
		end
	end

	return var_2_0
end

return var_0_1
