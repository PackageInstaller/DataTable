local GvgLayer = class("GvgLayer", require("app.fairyGUI.gvg.UI_GvgLayer"), function()
	return fgui.GComponent:create({
		resName = "GvgLayer",
		pkgName = "gvg",
		isFullScreen = true,
		pkgPath = "ui/gvg/gvg"
	}, ...)
end)

function GvgLayer:ctor(arg_2_1)
	self._params = arg_2_1 or {}

	self:_initView()
end

function GvgLayer:onLoad()
	self:_updateView()
end

function GvgLayer:onUnload()
	return
end

function GvgLayer:_initView()
	return
end

function GvgLayer:_updateView()
	return
end

return GvgLayer
