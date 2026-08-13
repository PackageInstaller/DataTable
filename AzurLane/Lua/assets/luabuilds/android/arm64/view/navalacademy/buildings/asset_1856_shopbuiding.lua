class = var_0_10000

local var_0_0 = "ShopBuiding"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NavalAcademyUpgradableBuilding"))

function var_0_1.GetGameObjectName(arg_1_0)
	return "shop"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("school_title_xiaomaibu")
end

function var_0_1.OnClick(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	NavalAcademyMediator = var_1_10004

	var_3_1(var_3_0, var_1_10004.ON_OPEN_GOLDRESFIELD)

	return
end

function var_0_1.GetResField(arg_4_0)
	return arg_4_0.parent.goldResField
end

return var_0_1
