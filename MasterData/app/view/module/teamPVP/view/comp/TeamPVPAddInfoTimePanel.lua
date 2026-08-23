local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local TeamPVPAddInfoTimePanel = class("TeamPVPAddInfoTimePanel", require("app.fairyGUI.teamPVP.UI_TeamPVPAddInfoTimePanel"))

function TeamPVPAddInfoTimePanel:updatePanel()
	local var_1_0 = var_0_0:isHotTime()
	local var_1_1 = var_0_0:getTeamPVPParameterById(var_0_1.PARAMETER_ID.HOT_TIME) / 10
	local var_1_2 = var_0_0:getTeamPVPParameterById(var_0_1.PARAMETER_ID.HOT_TIME_SCORE) / 10

	self.m_add1:setText((var_1_0 and var_1_1 or 0) .. "%")
	self.m_info1:setText(g.core.lang:get(420438, {
		num = var_1_1
	}))
	self.m_add2:setText((var_1_0 and var_1_2 or 0) .. "%")
	self.m_info2:setText(g.core.lang:get(420449, {
		num = var_1_2
	}))
end

return TeamPVPAddInfoTimePanel
