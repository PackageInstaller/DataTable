local AncientsLineupPositionComp = class("AncientsLineupPositionComp", require("app.fairyGUI.ancients.UI_AncientsLineupPositionComp"))

function var_0_0.ctor(arg_1_0)
	arg_1_0._formationPos = 0
end

function var_0_0:setEmpty(arg_2_1)
	self.m_is_emptyController:setSelectedIndex(arg_2_1 and 1 or 0)
end

function var_0_0.setFormationPos(arg_3_0, arg_3_1)
	arg_3_0._formationPos = arg_3_1
end

function var_0_0:getFormationPos()
	return self._formationPos
end

return var_0_0
