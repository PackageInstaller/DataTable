local StormMiddleFailDescComp = class("StormMiddleFailDescComp", require("app.fairyGUI.battleResult.UI_StormMiddleFailDescComp"))

function StormMiddleFailDescComp:update(arg_1_1)
	local var_1_0 = arg_1_1.hp or {}
	local var_1_1 = g.core.model.User.stormData:getMiddleCityData(arg_1_1.stormId).events

	var_1_1 = var_1_1 or {}

	local var_1_2 = 0
	local var_1_3 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		if iter_1_1.cell_id == arg_1_1.cellId then
			var_1_2 = iter_1_1.max_hp or 0

			for iter_1_2, iter_1_3 in ipairs(iter_1_1.hp or {}) do
				var_1_3 = var_1_3 + iter_1_3
			end

			break
		end
	end

	if var_1_3 == 0 then
		var_1_3 = var_1_2
	end

	local var_1_4 = 0

	for iter_1_4, iter_1_5 in ipairs(var_1_0) do
		var_1_4 = var_1_4 + iter_1_5
	end

	self.m_damageTxt:setText(math.max(var_1_3, var_1_4) - var_1_4)
	self.m_progressComp:setMax(var_1_2)
	self.m_progressComp:setValue(var_1_4)
	self.m_progressTxt:setText(math.floor(var_1_4 / var_1_2 * 10000) / 100 .. "%")
end

return StormMiddleFailDescComp
