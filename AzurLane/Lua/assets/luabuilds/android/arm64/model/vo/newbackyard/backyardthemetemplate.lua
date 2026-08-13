class = var_0_10000

local var_0_0 = "BackYardThemeTemplate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardBaseThemeTemplate"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.isFetched = arg_1_1.is_fetch

	return
end

function var_0_1.GetType(arg_2_0)
	BackYardConst = var_1_10001

	return var_1_10001.THEME_TEMPLATE_USAGE_TYPE_OTHER
end

function var_0_1.ShouldFetch(arg_3_0)
	return not arg_3_0.isFetched
end

function var_0_1.GetAllFurniture(arg_4_0)
	if not arg_4_0.furnitruesByIds then
		local var_4_0 = arg_4_0:GetRawPutList()

		arg_4_0.furnitruesByIds = arg_4_0:InitFurnitures({
			floor = 1,
			skipCheck = true,
			mapSize = arg_4_0:GetMapSize(),
			furniture_put_list = var_4_0
		})
	end

	return arg_4_0.furnitruesByIds
end

function var_0_1.GetMapSize(arg_5_0)
	Dorm = var_1_10001

	return (var_1_10001.StaticGetMapSize(4))
end

function var_0_1.GetFurnitureCnt(arg_6_0)
	if not arg_6_0.furnitureCnts then
		arg_6_0.furnitureCnts = {}
		ipairs = var_1

		for iter_6_0, iter_6_1 in var_1(arg_6_0:GetWarpFurnitures()) do
			if not arg_6_0.furnitureCnts[iter_6_1.configId] then
				arg_6_0.furnitureCnts[iter_6_1.configId] = 0
			end

			arg_6_0.furnitureCnts[iter_6_1.configId] = arg_6_0.furnitureCnts[iter_6_1.configId] + 1
		end
	end

	return arg_6_0.furnitureCnts
end

return var_0_1
