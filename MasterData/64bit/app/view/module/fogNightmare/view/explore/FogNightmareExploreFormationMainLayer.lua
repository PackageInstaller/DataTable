local FogNightmareExploreFormationMainLayer = class("FogNightmareExploreFormationMainLayer", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreFormationMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareExploreFormationMainLayer",
		pkgName = "fogNightmare",
		isFullScreen = true
	}, ...)
end)

function FogNightmareExploreFormationMainLayer:ctor()
	self:_initView()
end

function FogNightmareExploreFormationMainLayer:_initView()
	self:addBg("bg/fogNightmare/bg_wjmy_main.jpg")
end

function FogNightmareExploreFormationMainLayer:onLoad()
	return
end

return FogNightmareExploreFormationMainLayer
