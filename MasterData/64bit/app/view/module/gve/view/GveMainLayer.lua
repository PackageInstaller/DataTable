local GveMainLayer = class("GveMainLayer", require("app.fairyGUI.gve.UI_GveMainLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/gve/gve",
		resName = "GveMainLayer",
		pkgName = "gve"
	}, ...)
end)

function GveMainLayer:ctor()
	return
end

function GveMainLayer:onLoad()
	return
end

function GveMainLayer:onUnload()
	return
end

return GveMainLayer
