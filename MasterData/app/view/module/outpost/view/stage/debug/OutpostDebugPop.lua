local OutpostDebugPop = class("OutpostDebugPop", require("app.fairyGUI.outpost.UI_OutpostDebugPop"), function()
	return fgui.GComponent:create({
		resName = "OutpostDebugPop",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = false,
		pkgName = "outpost"
	}, ...)
end)

function OutpostDebugPop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_btnComp:setMap(arg_2_1.map)
end

return OutpostDebugPop
