class = var_0_10000

local var_0_0 = "IslandDressItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.ownCount = arg_1_1.ownCount
	arg_1_0.holdedShipId = arg_1_1.holdedShipId
	arg_1_0.needRedDot = arg_1_1.needRedDot
	arg_1_0.quality = arg_1_1.quality

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_dress_template
end

function var_0_1.GetSortValue(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0

	IslandShipDressUpPageNew = var_1_10004

	if arg_3_1 == var_1_10004.SORT_RARITY then
		var_3_0 = arg_3_0:GetRarity()
	else
		IslandShipDressUpPageNew = var_4

		if arg_3_1 == var_4.SORT_CANSEND then
			var_3_0 = arg_3_0.ownCount and 1 or 0
		else
			var_3_0 = arg_3_0.id
		end
	end

	return arg_3_2 == 1 and var_3_0 or -1 * var_3_0
end

function var_0_1.GetRarity(arg_4_0)
	return arg_4_0:getConfig("quality")
end

return var_0_1
