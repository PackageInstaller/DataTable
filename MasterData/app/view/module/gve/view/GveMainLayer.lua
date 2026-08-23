local GveMainLayer = class("GveMainLayer", require("app.fairyGUI.gve.UI_GveMainLayer"), function()
	return fgui.GComponent:create({
		resName = "GveMainLayer",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
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
