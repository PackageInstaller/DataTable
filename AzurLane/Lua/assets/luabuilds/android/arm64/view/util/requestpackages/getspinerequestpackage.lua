class = var_0_10000

local var_0_0 = "GetSpineRequestPackage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".RequestPackage"))

function var_0_1.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	local var_1_0 = arg_1_0.name

	SpineAnimChar = var_1_10002
	arg_1_0.spineChar = var_1_10002.New()

	local var_1_1 = arg_1_0.spineChar

	var_2.SetPaint(var_1_1, var_1_0)

	local var_1_2 = arg_1_0.spineChar

	var_2.Load(var_1_2, true, function(arg_2_0)
		if arg_1_0.stopped then
			arg_2_0:Dispose()

			return
		end

		if arg_1_0.onLoaded then
			arg_1_0.onLoaded(arg_2_0)
		end

		return
	end)

	return arg_1_0
end

function var_0_1.Ctor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.name = arg_3_1
	arg_3_0.path = "Spine"
	arg_3_0.onLoaded = arg_3_2

	return
end

return var_0_1
