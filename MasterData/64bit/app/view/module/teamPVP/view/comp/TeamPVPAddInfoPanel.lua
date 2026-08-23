local var_0_0 = g.core.const.ConstMgr.TeamPvpConst
local TeamPVPAddInfoPanel = class("TeamPVPAddInfoPanel", require("app.fairyGUI.teamPVP.UI_TeamPVPAddInfoPanel"))

function TeamPVPAddInfoPanel:updatePanel(arg_1_1)
	self.m_typeController:setSelectedIndex(arg_1_1)

	if arg_1_1 == var_0_0.ADD_POP_TYPE.TIME then
		self.m_timePanel:updatePanel()
	elseif arg_1_1 == var_0_0.ADD_POP_TYPE.TEAM then
		self.m_teamPanel:updatePanel()
	end
end

return TeamPVPAddInfoPanel
