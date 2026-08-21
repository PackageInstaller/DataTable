local var_0_0 = class("IslandDressItem", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.ownCount = arg_1_1.ownCount
	arg_1_0.holdedShipId = arg_1_1.holdedShipId
	arg_1_0.needRedDot = arg_1_1.needRedDot
	arg_1_0.quality = arg_1_1.quality

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_dress_template
end

function var_0_0.GetSortValue(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0

	var_3_0 = arg_3_1 == IslandShipDressUpPageNew.SORT_RARITY and arg_3_0:GetRarity() or arg_3_1 == IslandShipDressUpPageNew.SORT_CANSEND and (arg_3_0.ownCount and 1 or 0) or arg_3_0.id

	return arg_3_2 == 1 and var_3_0 or -1 * var_3_0
end

function var_0_0.GetRarity(arg_4_0)
	return arg_4_0:getConfig("quality")
end

return var_0_0
