local OutpostElementTipPop = class("OutpostElementTipPop", require("app.fairyGUI.outpost.UI_OutpostElementTipPop"), function()
	return fgui.GComponent:create({
		pkgName = "outpost",
		isFullScreen = false,
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostElementTipPop"
	}, ...)
end)

function OutpostElementTipPop:ctor()
	self:showAtCenter()
end

return OutpostElementTipPop
