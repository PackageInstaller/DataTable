class = var_0_10000

local var_0_0 = "CourtYardPedestalWallBase"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardPedestalStructure"))

function var_0_1.GetAssetPath(arg_1_0)
	return "furnitrues/base/wall_" .. arg_1_0.level
end

function var_0_1.OnLoaded(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.transform

	var_2.SetAsFirstSibling(var_2_0)

	return
end

function var_0_1.GetParent(arg_3_0)
	local var_3_0 = arg_3_0.parent._tf

	return var_1.Find(var_3_0, "base")
end

return var_0_1
