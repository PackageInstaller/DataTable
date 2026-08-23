local MineRecordUserComp = class("MineRecordUserComp", require("app.fairyGUI.mine.UI_MineRecordUserComp"))

function MineRecordUserComp:updateRecord(arg_1_1)
	self.m_userHeadComp:updateAsUser(arg_1_1.user)
	self.m_nameText:setText(arg_1_1.name)
	self.m_descTxt:setText(g.core.lang:get(307524, {
		num = arg_1_1.lostPower,
		name = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_FORCES
		}).name
	}))
	self.m_progressComp:setMax(arg_1_1.maxPower)
	self.m_progressComp:setValue(arg_1_1.curPower)
	self.m_progressTxt:setText(arg_1_1.curPower .. "/" .. arg_1_1.maxPower)
	self.m_winController:setSelectedIndex(arg_1_1.win and 1 or 0)
end

return MineRecordUserComp
