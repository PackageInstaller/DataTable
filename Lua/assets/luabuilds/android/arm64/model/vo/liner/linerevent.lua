local var_0_0 = class("LinerEvent", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_liner_event
end

function var_0_0.GetOptionName(arg_3_0)
	return HXSet.hxLan(arg_3_0:getConfig("option"))
end

function var_0_0.GetOptionDisplay(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0:getConfig("option_desc_display")) do
		table.insert({}, (HXSet.hxLan(iter_4_1[1])))
	end

	return {}
end

function var_0_0.GetTitle(arg_5_0)
	return HXSet.hxLan(arg_5_0:getConfig("title"))
end

function var_0_0.GetLogDesc(arg_6_0)
	return HXSet.hxLan(arg_6_0:getConfig("option_desc"))
end

function var_0_0.GetReasoningDesc(arg_7_0)
	return HXSet.hxLan(arg_7_0:getConfig("option_desc_2"))
end

return var_0_0
