local AnswerProxy = class("AnswerProxy", import(".NetProxy"))

function AnswerProxy:register()
	self.scores = {}

	self:on(26011, function(arg_2_0)
		self.scores = {}

		_.each(arg_2_0.subject, function(arg_3_0)
			self.scores[arg_3_0.id] = arg_3_0.score

			return
		end)

		return
	end)

	return
end

function AnswerProxy:getScore(arg_4_1)
	return self.scores[arg_4_1]
end

function AnswerProxy:setScore(arg_5_1, arg_5_2)
	self.scores[arg_5_1] = arg_5_2 and math.clamp(arg_5_2, 0, 100) or nil

	return
end

function AnswerProxy:getAverage()
	local var_6_0 = 0
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in pairs(self.scores) do
		var_6_0 = var_6_0 + 1
		var_6_1 = var_6_1 + iter_6_1
	end

	return var_6_0 > 0 and var_6_1 / var_6_0
end

function AnswerProxy:isSubjectOpen(arg_7_1, arg_7_2)
	return arg_7_1:getDayIndex() >= arg_7_2 + 1
end

return AnswerProxy
