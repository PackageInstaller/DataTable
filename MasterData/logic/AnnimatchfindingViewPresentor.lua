-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchfindingViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchfindingViewPresentor", package.seeall)

local AnnimatchfindingViewPresentor = class("AnnimatchfindingViewPresentor", ViewPresentor)

function AnnimatchfindingViewPresentor:ctor()
	AnnimatchfindingViewPresentor.super.ctor(self)
end

function AnnimatchfindingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchfindingViewPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracefindenemyview.prefab"
	}
end

function AnnimatchfindingViewPresentor:buildViews()
	return {
		AnnimatchfindingView.New()
	}
end

return AnnimatchfindingViewPresentor
