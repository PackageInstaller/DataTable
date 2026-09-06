-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aruishidragongame/view/ARuiShiDragonGameStartViewPresentor.lua

module("logic.extensions.aruishidragongame.view.ARuiShiDragonGameStartViewPresentor", package.seeall)

local ARuiShiDragonGameStartViewPresentor = class("ARuiShiDragonGameStartViewPresentor", ViewPresentor)

function ARuiShiDragonGameStartViewPresentor:ctor()
	ARuiShiDragonGameStartViewPresentor.super.ctor(self)
end

function ARuiShiDragonGameStartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ARuiShiDragonGameStartViewPresentor:dependWhatResources()
	return {
		"ui/views/aruishidragongame/aruishidragongamestartview.prefab"
	}
end

function ARuiShiDragonGameStartViewPresentor:buildViews()
	return {
		ARuiShiDragonGameStartView.New()
	}
end

return ARuiShiDragonGameStartViewPresentor
