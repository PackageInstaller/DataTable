class = var_0_10000

local var_0_0 = "SupplyShopBuilding"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NavalAcademyBuilding"))

function var_0_1.GetGameObjectName(arg_1_0)
	return "supplyShop"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("school_title_shangdian")
end

function var_0_1.OnClick(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	NavalAcademyMediator = var_1_10003

	var_3_1(var_3_0, var_1_10003.ON_OPEN_SUPPLYSHOP)

	return
end

function var_0_1.IsTip(arg_4_0)
	getProxy = var_1_10001
	ShopsProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1

	var_4_1 = var_1.getShopStreet(var_4_0) and var_2:isUpdateGoods()

	return var_4_1
end

return var_0_1
