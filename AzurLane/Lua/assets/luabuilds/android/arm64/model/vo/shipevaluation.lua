local var_0_0 = class("ShipEvaluation", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.ship_group_id
	arg_1_0.hearts = arg_1_1.heart_count
	arg_1_0.evaCount = arg_1_1.discuss_count
	arg_1_0.ievaCount = arg_1_1.daily_discuss_count
	arg_1_0.evas = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.discuss_list) do
		table.insert(arg_1_0.evas, {
			izan = false,
			hot = false,
			id = iter_1_1.id,
			good_count = iter_1_1.good_count,
			bad_count = iter_1_1.bad_count,
			nick_name = iter_1_1.nick_name,
			context = iter_1_1.context
		})
	end

	arg_1_0:sortEvas()

	return
end

function var_0_0.sortEvas(arg_2_0)
	arg_2_0.evas = _.sort(arg_2_0.evas, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0.good_count - arg_3_0.bad_count
		local var_3_1 = arg_3_1.good_count - arg_3_1.bad_count

		if arg_3_0.good_count - arg_3_0.bad_count == arg_3_1.good_count - arg_3_1.bad_count then
			return arg_3_0.id > arg_3_1.id
		else
			return var_3_1 < var_3_0
		end

		return
	end)

	local var_2_0 = math.min(2, #arg_2_0.evas)
	local var_2_1 = _(arg_2_0.evas):chain():slice(var_2_0 + 1, #arg_2_0.evas - var_2_0):sort(function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0.good_count - arg_4_0.bad_count
		local var_4_1 = arg_4_1.good_count - arg_4_1.bad_count

		if arg_4_0.good_count - arg_4_0.bad_count <= -5 or var_4_1 <= -5 then
			return var_4_1 < var_4_0
		else
			return arg_4_0.id > arg_4_1.id
		end

		return
	end):value()

	for iter_2_0 = 1, #arg_2_0.evas do
		arg_2_0.evas[iter_2_0].hot = iter_2_0 <= var_2_0

		if var_2_0 < iter_2_0 then
			arg_2_0.evas[iter_2_0] = var_2_1[iter_2_0 - var_2_0]
		end
	end

	return
end

return var_0_0
