local QuestionnaireData = class("QuestionnaireData")

function QuestionnaireData:ctor()
	self:initData()
end

function QuestionnaireData:initData()
	self._quesId = 0
	self._quesStartTime = 0
	self._quesFinishTime = 0
	self._allQuestionnaire = {}
	self._questionnaireTemp = {}
	self._showQuestionnaire = {}
	self._questionRedData = {}
end

function QuestionnaireData:updateQuestionData(arg_3_1)
	self._allQuestionnaire = {}
	self._questionnaireTemp = {}

	if arg_3_1 and arg_3_1.infos and arg_3_1.infos[1] then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.infos) do
			self._allQuestionnaire[iter_3_1.type] = self._allQuestionnaire[iter_3_1.type] or {}

			table.insert(self._allQuestionnaire[iter_3_1.type], iter_3_1)
		end
	end

	for iter_3_2, iter_3_3 in pairs(self._allQuestionnaire) do
		if #iter_3_3 >= 1 then
			table.sort(iter_3_3, function(arg_4_0, arg_4_1)
				if arg_4_0.create_time ~= arg_4_1.create_time then
					return arg_4_0.create_time > arg_4_1.create_time
				end
			end)
			table.insert(self._questionnaireTemp, iter_3_3[1])
		end
	end

	self:getShowQuestionnaire()
end

function QuestionnaireData:getShowQuestionnaire()
	self._showQuestionnaire = {}

	local var_5_0 = {}
	local var_5_1 = g.core.common.Storage:load("QuestionnaireRed.json", true) or {}
	local var_5_2 = (g.core.common.Storage:load("Questionnaire.json", false) or {}).idMap

	for iter_5_0, iter_5_1 in ipairs(self._questionnaireTemp) do
		local var_5_3 = iter_5_1.type
		local var_5_4 = tostring(iter_5_1.id)
		local var_5_5 = true
		local var_5_6 = false

		if var_5_2 and var_5_2[var_5_4] and g.core.common.ServerTime:getTime() - var_5_2[var_5_4] > 86400 then
			-- block empty
		else
			var_5_2 = var_5_2 or {}
			var_5_2[var_5_4] = var_5_2[var_5_4] or g.core.common.ServerTime:getTime()
		end

		if var_5_3 == 1 then
			local var_5_7 = g.core.common.ServerTime:getTimeByOpenDay(iter_5_1.finish_time)
			local var_5_8 = g.core.common.ServerTime:getTime()

			if g.core.common.ServerTime:getTimeByOpenDay(iter_5_1.start_time) < var_5_8 and var_5_8 < var_5_7 and var_5_5 then
				table.insert(self._showQuestionnaire, iter_5_1)

				var_5_6 = true
			end
		else
			local var_5_9 = g.core.model.User:getLevel()
			local var_5_10 = g.core.model.User:getVipLevel()
			local var_5_11 = g.core.common.ServerTime:getTime()

			if var_5_9 >= iter_5_1.min_level and var_5_9 <= iter_5_1.max_level and var_5_10 >= iter_5_1.min_vip and var_5_10 <= iter_5_1.max_vip and var_5_11 >= iter_5_1.start_time and var_5_11 <= iter_5_1.finish_time and var_5_5 then
				table.insert(self._showQuestionnaire, iter_5_1)

				var_5_6 = true
			end
		end

		if var_5_6 then
			var_5_0[var_5_4] = {}
			var_5_0[var_5_4].red = var_5_1.redMap and var_5_1.redMap[var_5_4] and var_5_1.redMap[var_5_4].red or true
		end
	end

	if next(var_5_0) then
		g.core.common.Storage:save("QuestionnaireRed.json", {
			redMap = var_5_0
		}, true)
	end

	g.core.common.Storage:save("Questionnaire.json", {
		idMap = var_5_2
	}, false)

	return self._showQuestionnaire
end

function QuestionnaireData:isShowQuestion()
	return #self._showQuestionnaire > 0
end

function QuestionnaireData:setQuesRedData(arg_7_1)
	arg_7_1 = tostring(arg_7_1)

	local var_7_0 = g.core.common.Storage:load("QuestionnaireRed.json", true) or {}

	if not var_7_0.redMap or var_7_0.redMap and not var_7_0.redMap[arg_7_1] then
		var_7_0.redMap = var_7_0.redMap or {}
		var_7_0.redMap[arg_7_1] = var_7_0.redMap[arg_7_1] or {}
	end

	var_7_0.redMap[arg_7_1].red = false

	g.core.common.Storage:save("QuestionnaireRed.json", {
		redMap = var_7_0.redMap
	}, true)
end

function QuestionnaireData:hasNewQuestionnaire()
	local var_8_0 = false
	local var_8_1 = self:getShowQuestionnaire()

	if var_8_1 then
		local var_8_2 = g.core.common.Storage:load("QuestionnaireRed.json", true) or {}

		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			local var_8_3 = var_8_2.redMap[tostring(iter_8_1.id)]

			if not var_8_3 or var_8_3.red then
				var_8_0 = true

				break
			end
		end
	end

	return var_8_0
end

function QuestionnaireData:isQuestionNew(arg_9_1)
	arg_9_1 = tostring(arg_9_1)

	local var_9_0 = g.core.common.Storage:load("QuestionnaireRed.json", true) or {}

	if not var_9_0.redMap then
		return false
	end

	if var_9_0.redMap[arg_9_1] and var_9_0.redMap[arg_9_1].red then
		return true
	end

	return false
end

function QuestionnaireData:getQuesTitle()
	local var_10_0 = self:getShowQuestionnaire()

	if #var_10_0 == 1 then
		return "PAPER_SDK" .. var_10_0[1].type
	end

	return "PAPER_SDK"
end

return QuestionnaireData
