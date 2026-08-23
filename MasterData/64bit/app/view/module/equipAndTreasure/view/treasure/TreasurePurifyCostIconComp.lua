local TreasurePurifyCostIconComp = class("TreasurePurifyCostIconComp", require("app.fairyGUI.equipAndTreasure.UI_TreasurePurifyCostIconComp"))

function TreasurePurifyCostIconComp:updateIconComp(arg_1_1)
	self.m_iconComp:updateIcon(arg_1_1)

	local var_1_0 = 0

	if arg_1_1.type == 999 then
		if arg_1_1.value == 0 then
			var_1_0 = g.core.model.User:getFreeGold()
		elseif arg_1_1.value == 1 then
			var_1_0 = g.core.model.User:getGold()
		end
	else
		var_1_0 = g.core.model.User.bagData:getOwnNum(arg_1_1.type, arg_1_1.value)
	end

	local var_1_1 = g.core.lang:get(200523, {
		curNum = var_1_0,
		totalNum = arg_1_1.size
	})

	self.m_numText:setText((var_1_0 < arg_1_1.size or nil) and g.core.lang:get(200524, {
		curNum = var_1_0,
		totalNum = arg_1_1.size
	}))
end

return TreasurePurifyCostIconComp
