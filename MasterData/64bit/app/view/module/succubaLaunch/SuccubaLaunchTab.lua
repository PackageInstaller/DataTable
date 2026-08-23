local SuccubaLaunchTab = class("SuccubaLaunchTab", require("app.fairyGUI.succubaLaunch.UI_SuccubaLaunchTab"))

function SuccubaLaunchTab:updateTab(arg_1_1)
	self.m_tittle:setText(g.core.lang:get(431501, {
		num = arg_1_1.index
	}))

	if not arg_1_1.isUnlock then
		self.m_stateController:setSelectedIndex(1)
	elseif arg_1_1.isFinish then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return SuccubaLaunchTab
