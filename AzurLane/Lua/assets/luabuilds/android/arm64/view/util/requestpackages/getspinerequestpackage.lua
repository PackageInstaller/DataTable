local var_0_0 = class("GetSpineRequestPackage", import(".RequestPackage"))

function var_0_0.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	local var_1_0 = arg_1_0.name

	arg_1_0.spineChar = SpineAnimChar.New()

	arg_1_0.spineChar:SetPaint(var_1_0)
	arg_1_0.spineChar:Load(true, function(arg_2_0)
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

function var_0_0.Ctor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.name = arg_3_1
	arg_3_0.path = "Spine"
	arg_3_0.onLoaded = arg_3_2

	return
end

return var_0_0
