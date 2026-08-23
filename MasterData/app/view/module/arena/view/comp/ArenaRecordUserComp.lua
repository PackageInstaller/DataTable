local ArenaRecordUserComp = class("ArenaRecordUserComp", require("app.fairyGUI.arena.UI_ArenaRecordUserComp"))

function ArenaRecordUserComp:ctor()
	return
end

function ArenaRecordUserComp:updateUserInfo(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self.m_userHeadComp:updateAsUser(arg_2_1)
	self.m_nameText:setText((g.core.utils.String.transRobotName(arg_2_1)))
	self.m_powerText:setText(arg_2_1.fight_value)
	self.m_winController:setSelectedIndex(arg_2_2 and 1 or 0)
end

return ArenaRecordUserComp
