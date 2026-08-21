local var_0_0 = class("AnswerProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0.scores = {}

	arg_1_0:on(26011, function(arg_2_0)
		arg_1_0.scores = {}

		_.each(arg_2_0.subject, function(arg_3_0)
			arg_1_0.scores[arg_3_0.id] = arg_3_0.score

			return
		end)

		return
	end)

	return
end

function var_0_0.getScore(arg_4_0, arg_4_1)
	return arg_4_0.scores[arg_4_1]
end

function var_0_0.setScore(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.scores[arg_5_1] = arg_5_2 and math.clamp(arg_5_2, 0, 100) or nil

	return
end

function var_0_0.getAverage(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in pairs(arg_6_0.scores) do
		var_6_0 = var_6_0 + 1
		var_6_1 = var_6_1 + iter_6_1
	end

	return var_6_0 > 0 and var_6_1 / var_6_0
end

function var_0_0.isSubjectOpen(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_1:getDayIndex() >= arg_7_2 + 1
end

return var_0_0
