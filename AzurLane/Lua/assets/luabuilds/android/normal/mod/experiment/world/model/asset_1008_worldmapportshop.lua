class = var_0_10000

local var_0_0 = "WorldMapPortShop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	items = "table",
	expiredTime = "number"
}

function var_0_1.Setup(arg_1_0)
	return
end

function var_0_1.IsValid(arg_2_0)
	local var_2_0 = arg_2_0.expiredTime

	pg = var_1_10002

	local var_2_1 = var_1_10002.TimeMgr.GetInstance()

	return var_2_0 >= var_2.GetServerTime(var_2_1)
end

return var_0_1
