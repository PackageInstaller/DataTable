local OutpostElementTipPop = class("OutpostElementTipPop", require("app.fairyGUI.outpost.UI_OutpostElementTipPop"), function()
	return fgui.GComponent:create({
		resName = "OutpostElementTipPop",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = false,
		pkgName = "outpost"
	}, ...)
end)

function OutpostElementTipPop:ctor()
	self:showAtCenter()
end

return OutpostElementTipPop
