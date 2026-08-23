local FogNightmareExploreFormationMainLayer = class("FogNightmareExploreFormationMainLayer", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreFormationMainLayer"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareExploreFormationMainLayer",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
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
