local var_0_0 = g.core.model.User
local GuildWarActionCommandCell = class("GuildWarActionCommandCell", require("app.fairyGUI.guildWar.UI_GuildWarActionCommandCell"))

function GuildWarActionCommandCell:updateCell(arg_1_1)
	if arg_1_1.user.id == var_0_0:getId() then
		self.m_headIconComp:updateAsSelf()
	else
		self.m_headIconComp:updateAsUser(arg_1_1.user)
	end

	self.m_nameTxt:setText(arg_1_1.user.name)
	self.m_powerTxt:setText(arg_1_1.user.fight_value)
end

return GuildWarActionCommandCell
