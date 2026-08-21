local var_0_0 = class("MallStaff", import("model.vo.BaseVO"))

var_0_0.STATUS = {
	FLOOR = 2,
	NORMAL = 1,
	ORDER = 3
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.tid = arg_1_1.tid
	arg_1_0.configId = arg_1_0.tid
	arg_1_0.attrs = {}

	if arg_1_1.attr_list then
		table.sort(arg_1_1.attr_list, function(arg_2_0, arg_2_1)
			return arg_2_0.key < arg_2_1.key
		end)

		for iter_1_0, iter_1_1 in ipairs(arg_1_1.attr_list) do
			table.insert(arg_1_0.attrs, iter_1_1.value)
		end
	end

	arg_1_0:SetStatus(var_0_0.STATUS.NORMAL, {})

	return
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.activity_mall_staff_template
end

function var_0_0.NeedReqData(arg_4_0)
	return #arg_4_0.attrs == 0
end

function var_0_0.GetAttrList(arg_5_0)
	return arg_5_0.attrs
end

function var_0_0.SetStatus(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.status = arg_6_1
	arg_6_0.statusData = arg_6_2

	return
end

function var_0_0.GetStatusInfos(arg_7_0)
	return arg_7_0.status, arg_7_0.statusData
end

function var_0_0.SetExtraData(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_1, 2 do
		table.insert({}, {
			key = arg_8_1[iter_8_0],
			value = arg_8_1[iter_8_0 + 1]
		})
	end

	table.sort({}, function(arg_9_0, arg_9_1)
		return arg_9_0.key < arg_9_1.key
	end)

	arg_8_0.attrs = {}

	for iter_8_1, iter_8_2 in ipairs({}) do
		table.insert(arg_8_0.attrs, iter_8_2.value)
	end

	return
end

function var_0_0.GetTotalVal(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.attrs) do
		var_10_0 = var_10_0 + iter_10_1
	end

	return var_10_0
end

return var_0_0
