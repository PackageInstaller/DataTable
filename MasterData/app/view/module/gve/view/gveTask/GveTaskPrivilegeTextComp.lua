local var_0_0 = g.core.config.gve_privilege_info
local GveTaskPrivilegeTextComp = class("GveTaskPrivilegeTextComp", require("app.fairyGUI.gve.UI_GveTaskPrivilegeTextComp"))
local var_0_2 = 6

function GveTaskPrivilegeTextComp:ctor()
	return
end

function GveTaskPrivilegeTextComp:updateView(arg_2_1)
	for iter_2_0 = 1, #arg_2_1 do
		self["m_privilegeText" .. iter_2_0]:setText(g.core.utils.String.formatText(var_0_0.get(arg_2_1[iter_2_0].privilegeType).des, {
			num = arg_2_1[iter_2_0].privilegeValue
		}))
	end

	for iter_2_1 = #arg_2_1 + 1, var_0_2 do
		self["m_privilegeText" .. iter_2_1]:setText("")
	end
end

return GveTaskPrivilegeTextComp
