local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User
local var_0_2 = g.core.model.User.peakArenaData
local PARecordUserComp = class("PARecordUserComp", require("app.fairyGUI.peakArena.UI_PARecordUserComp"))

function PARecordUserComp:updateUserInfo(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = g.core.utils.String.transRobotName(arg_1_1)

	self.m_winController:setSelectedIndex(arg_1_2 and 1 or 0)

	if arg_1_1.is_robot then
		local var_1_1 = g.core.config.peakarena_robot_info.get(arg_1_1.id)

		self.m_levelIcon:setURL(var_0_0:getPeakArenaDanGradingPic(g.core.config.peakarena_level_info.get(var_1_1.level_id).pic))
		self.m_levelScore:setText(var_1_1.score)

		var_1_0 = var_1_1.name
		arg_1_1.level = var_1_1.seen_level
		arg_1_1.frame_id = 0

		self.m_userHeadComp:updateAsUser(arg_1_1)
		self.m_userHeadComp:getChild("iconLoader"):setURL(var_0_0:getRoleHeadIcon(var_1_1.seen_knight))
	else
		self.m_levelIcon:setURL(var_0_0:getPeakArenaDanGradingPic(var_0_2:getPALevelInfo(arg_1_3 or 0).pic))
		self.m_levelScore:setText(arg_1_3 or 0)

		if arg_1_1.id == var_0_1:getId() then
			self.m_userHeadComp:updateAsSelf()
		else
			self.m_userHeadComp:updateAsUser(arg_1_1)
		end
	end

	self.m_nameText:setText(var_1_0)
end

return PARecordUserComp
