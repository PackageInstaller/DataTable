class = var_0_10000

local var_0_0 = "IslandASynLoadAndCacheSubView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandASynLoadSubView"))

function var_0_1.LoadUI(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:GetPoolMgr()

	var_2.GetUI(var_1_0, arg_1_0:GetUIName(), function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.GetUIParent(var_2_0)

		setParent = var_2_0

		var_2_0(arg_2_0, var_2_1)
		arg_1_1(arg_2_0)

		return
	end)

	return
end

function var_0_1.UnloadUI(arg_3_0)
	if not arg_3_0._go then
		return
	end

	local var_3_0 = arg_3_0:GetPoolMgr()

	var_1.ReturnUI(var_3_0, arg_3_0:GetUIName(), arg_3_0._go)

	return
end

return var_0_1
