local var_0_0 = g.core.config.outpost_status_text_info
local OutpostStatusPop = class("OutpostStatusPop", require("app.fairyGUI.outpost.UI_OutpostStatusPop"), function()
	return fgui.GComponent:create({
		resName = "OutpostStatusPop",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = false,
		pkgName = "outpost"
	}, ...)
end)

function OutpostStatusPop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_infoComp:updateStatusPanel(arg_2_1)
	self.m_bgPanel:setTitle(var_0_0.get(arg_2_1.type).name)
end

return OutpostStatusPop
