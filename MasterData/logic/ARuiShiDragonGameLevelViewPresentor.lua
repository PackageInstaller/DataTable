-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aruishidragongame/view/ARuiShiDragonGameLevelViewPresentor.lua

module("logic.extensions.aruishidragongame.view.ARuiShiDragonGameLevelViewPresentor", package.seeall)

local ARuiShiDragonGameLevelViewPresentor = class("ARuiShiDragonGameLevelViewPresentor", ViewPresentor)

function ARuiShiDragonGameLevelViewPresentor:ctor()
	ARuiShiDragonGameLevelViewPresentor.super.ctor(self)
end

function ARuiShiDragonGameLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ARuiShiDragonGameLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/aruishidragongame/aruishidragongamelevelview.prefab"
	}
end

function ARuiShiDragonGameLevelViewPresentor:buildViews()
	return {
		ARuiShiDragonGameLevelView.New()
	}
end

return ARuiShiDragonGameLevelViewPresentor
