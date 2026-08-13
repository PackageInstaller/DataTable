class = var_0_10000

local var_0_0 = "BackYardShopFilterPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...Decoration.panles.BackYardDecorationFilterPanel"))

function var_0_1.SortForDecorate(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2[1]
	local var_1_1 = arg_1_2[2]
	local var_1_2 = arg_1_2[3]

	local function var_1_3(arg_2_0)
		if arg_2_0:getConfig("new") == -1 then
			return 0
		elseif arg_2_0:canPurchaseByGem() and not arg_2_0:canPurchaseByDormMoeny() then
			return 1
		elseif arg_2_0:canPurchaseByGem() and arg_2_0:canPurchaseByDormMoeny() then
			return 3
		elseif arg_2_0:canPurchaseByDormMoeny() then
			return 4
		else
			return 5
		end

		return
	end

	local function var_1_4(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.furniture_shop_template[arg_3_0.configId].time

		if arg_3_0:getConfig("new") > 0 then
			return 4
		elseif var_3_0 ~= "always" then
			return 3
		elseif var_3_0 == "always" then
			return 2
		else
			return 1
		end

		return
	end

	function var_0_1.SortByDefault1(arg_4_0, arg_4_1)
		if var_1_3(arg_4_0) == var_1_3(arg_4_1) then
			if var_1_4(arg_4_0) == var_1_4(arg_4_1) then
				return arg_4_0.id < arg_4_1.id
			else
				return var_4 < var_5
			end
		else
			return var_2 < var_3
		end

		return
	end

	function var_0_1.SortByDefault2(arg_5_0, arg_5_1)
		if var_1_3(arg_5_0) == var_1_3(arg_5_1) then
			if var_1_4(arg_5_0) == var_1_4(arg_5_1) then
				return arg_5_0.id > arg_5_1.id
			else
				return var_5 < var_4
			end
		else
			return var_2 < var_3
		end

		return
	end

	if (arg_1_0:canPurchase() and 1 or 0) == (arg_1_1:canPurchase() and 1 or 0) then
		if var_1_0 == var_0_1.SORT_MODE.BY_DEFAULT then
			return var_0_1["SortByDefault" .. var_1_2](arg_1_0, arg_1_1)
		elseif var_1_0 == var_0_1.SORT_MODE.BY_FUNC then
			return var_0_1.SORT_BY_FUNC(arg_1_0, arg_1_1, var_1_1, var_1_2, function()
				return var_0_1["SortByDefault" .. var_1_2](arg_1_0, arg_1_1)
			end)
		elseif var_1_0 == var_0_1.SORT_MODE.BY_CONFIG then
			return var_0_1.SORT_BY_CONFIG(arg_1_0, arg_1_1, var_1_1, var_1_2, function()
				return var_0_1["SortByDefault" .. var_1_2](arg_1_0, arg_1_1)
			end)
		end
	else
		return var_9 < var_8
	end

	return
end

function var_0_1.sort(arg_8_0, arg_8_1)
	table = var_1_10002

	var_1_10002.sort(arg_8_1, function(arg_9_0, arg_9_1)
		return var_0_1.SortForDecorate(arg_9_0, arg_9_1, {
			arg_8_0.sortData[1],
			arg_8_0.sortData[2],
			arg_8_0.orderMode
		})
	end)

	arg_8_0.furnitures = arg_8_1

	return
end

return var_0_1
