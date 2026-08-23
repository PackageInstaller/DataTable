local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local TeamPVPAddInfoTeamPanel = class("TeamPVPAddInfoTeamPanel", require("app.fairyGUI.teamPVP.UI_TeamPVPAddInfoTeamPanel"))

function TeamPVPAddInfoTeamPanel:updatePanel()
	local var_1_0, var_1_1 = var_0_0:getAddition()

	for iter_1_0 = 1, 3 do
		local var_1_2 = var_0_0:getTeamPVPParameterById(var_0_1.PARAMETER_ID[var_0_1.ADD_TYPE_MAP[iter_1_0]]) / 10
		local var_1_3

		if var_1_1[iter_1_0] and var_1_1[iter_1_0] > 0 then
			var_1_3 = var_1_2 * var_1_1[iter_1_0] or 0
		end

		self["m_info" .. iter_1_0]:setText(g.core.lang:get(var_0_1.ADD_LANG_ID[iter_1_0], {
			num = var_1_2
		}))
		self["m_add" .. iter_1_0]:setText(var_1_3 .. "%")
	end
end

return TeamPVPAddInfoTeamPanel
