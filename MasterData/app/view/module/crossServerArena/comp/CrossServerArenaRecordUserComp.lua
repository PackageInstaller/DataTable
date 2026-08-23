local CrossServerArenaRecordUserComp = class("CrossServerArenaRecordUserComp", require("app.fairyGUI.arena.UI_CrossServerArenaRecordUserComp"))

function CrossServerArenaRecordUserComp:ctor()
	return
end

function CrossServerArenaRecordUserComp:updateUserInfo(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self.m_userHeadComp:updateAsUser(arg_2_1)
	self.m_nameText:setText((g.core.utils.String.transRobotName(arg_2_1)))
	self.m_powerText:setText(arg_2_1.fight_value)
	self.m_winController:setSelectedIndex(arg_2_2 and 1 or 0)

	local var_2_0 = arg_2_1.serverName or ""

	self.m_serverName:initRaceTextParams({
		moveType = 1,
		playMode = 2,
		duration = 3,
		title = var_2_0
	})
	self.m_serverName:setTitleAlign("right")
	self.m_serverName:play()
end

return CrossServerArenaRecordUserComp
