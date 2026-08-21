local var_0_0 = class("Transition", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	local var_1_0 = arg_1_0.UIName

	if not arg_1_0.UIName then
		var_1_0 = arg_1_0.contextData.loadUI
		arg_1_0.UIName = arg_1_0.contextData.loadUI
	end

	return var_1_0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.didEnter(arg_3_0)
	return
end

function var_0_0.onBackPressed(arg_4_0)
	return
end

return var_0_0
