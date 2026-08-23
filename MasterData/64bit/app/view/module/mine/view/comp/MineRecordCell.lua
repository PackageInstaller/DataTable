local MineRecordCell = class("MineRecordCell", require("app.fairyGUI.mine.UI_MineRecordCell"))

function MineRecordCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function MineRecordCell:updateRecordCell(arg_2_1)
	local var_2_0 = g.core.config.mine_parameter_info.indexOf(1).max_hp
	local var_2_1 = {
		lostPower = arg_2_1.data.atker_lost_power,
		user = arg_2_1.data.attacker,
		maxPower = var_2_0,
		curPower = arg_2_1.data.atker_power,
		win = arg_2_1.data.is_win,
		name = arg_2_1.data.attacker.name
	}
	local var_2_2 = {
		lostPower = arg_2_1.data.defer_lost_power,
		user = arg_2_1.data.defender,
		maxPower = var_2_0,
		curPower = arg_2_1.data.defer_power,
		win = not arg_2_1.data.is_win,
		name = arg_2_1.data.defender.name
	}

	self.m_challengeController:setSelectedIndex(arg_2_1.data.attacker.id == g.core.model.User:getId() and (arg_2_1.data.is_win and 1 or 0) or not arg_2_1.data.is_win and 3 or 2)
	self.m_leftUserComp:updateRecord(var_2_1)
	self.m_rightUserComp:updateRecord(var_2_2)
end

return MineRecordCell
