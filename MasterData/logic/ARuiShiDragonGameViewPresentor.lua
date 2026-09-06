-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aruishidragongame/view/ARuiShiDragonGameViewPresentor.lua

module("logic.extensions.aruishidragongame.view.ARuiShiDragonGameViewPresentor", package.seeall)

local ARuiShiDragonGameViewPresentor = class("ARuiShiDragonGameViewPresentor", ViewPresentor)

function ARuiShiDragonGameViewPresentor:ctor()
	ARuiShiDragonGameViewPresentor.super.ctor(self)
end

function ARuiShiDragonGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ARuiShiDragonGameViewPresentor:dependWhatResources()
	return {
		"ui/views/aruishidragongame/aruishidragongameview.prefab"
	}
end

function ARuiShiDragonGameViewPresentor:buildViews()
	return {
		ARuiShiDragonGameView.New()
	}
end

return ARuiShiDragonGameViewPresentor
