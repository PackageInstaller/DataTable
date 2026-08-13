class = var_0_10000

local var_0_0 = "AnswerProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.scores = {}

	arg_1_0:on(26011, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_2_0.scores = {}
		_ = var_2_0

		var_2_0.each(arg_2_0.subject, function(arg_3_0)
			arg_1_0.scores[arg_3_0.id] = arg_3_0.score

			return
		end)

		return
	end)

	return
end

function var_0_1.getScore(arg_4_0, arg_4_1)
	return arg_4_0.scores[arg_4_1]
end

function var_0_1.setScore(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.scores

	if arg_5_2 then
		math = var_1_10004

		local var_5_1

		if not var_1_10004.clamp(arg_5_2, 0, 100) then
			var_5_1 = nil
		end

		var_5_0[arg_5_1] = var_5_1

		return
	end
end

function var_0_1.getAverage(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = 0

	pairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0.scores) do
		var_6_0 = var_6_0 + 1
		var_6_1 = var_6_1 + iter_6_1
	end

	return var_6_0 > 0 and var_6_1 / var_6_0
end

function var_0_1.isSubjectOpen(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_1:getDayIndex() >= arg_7_2 + 1
end

return var_0_1
