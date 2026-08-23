local OutpostDebugPop = class("OutpostDebugPop", require("app.fairyGUI.outpost.UI_OutpostDebugPop"), function()
	return fgui.GComponent:create({
		resName = "OutpostDebugPop",
		pkgName = "outpost",
		isFullScreen = false,
		pkgPath = "ui/outpost/outpost"
	}, ...)
end)

function OutpostDebugPop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_btnComp:setMap(arg_2_1.map)
end

return OutpostDebugPop
