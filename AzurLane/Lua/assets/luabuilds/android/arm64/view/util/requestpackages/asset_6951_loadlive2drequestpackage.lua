class = var_0_10000

local var_0_0 = "LoadLive2dRequestPackage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".RequestPackage"))

function var_0_1.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	ResourceMgr = var_1

	local var_1_0 = var_1.Inst
	local var_1_1 = var_1.getAssetAsync
	local var_1_2 = arg_1_0.path
	local var_1_3 = arg_1_0.name

	UnityEngine = var_1_10006

	var_1_1(var_1_0, var_1_2, var_1_3, var_1_10006.Events.UnityAction_UnityEngine_Object(function(arg_2_0)
		if arg_1_0.stopped then
			return
		end

		if arg_1_0.onLoaded then
			Object = var_1

			local var_2_0 = var_1.Instantiate(arg_2_0)

			arg_1_0.onLoaded(var_2_0)
		end

		return
	end), true, true)

	return arg_1_0
end

function var_0_1.Ctor(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.path = arg_3_1
	arg_3_0.name = arg_3_2
	arg_3_0.onLoaded = arg_3_3

	return
end

return var_0_1
