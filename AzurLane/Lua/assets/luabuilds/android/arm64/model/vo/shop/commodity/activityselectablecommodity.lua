local var_0_0 = class("ActivitySelectableCommodity", import(".ActivityCommodity"))

function var_0_0.Selectable(arg_1_0)
	local var_1_0 = arg_1_0:getConfig("commodity_id_list")

	return var_1_0 and var_1_0 ~= "" and #var_1_0 > 0
end

function var_0_0.GetFirstDropId(arg_2_0)
	return arg_2_0:getConfig("commodity_id_list")
end

return var_0_0
