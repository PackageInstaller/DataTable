-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/view/BricksxgamerankViewPresentor.lua

module("logic.extensions.bricksxgame.view.BricksxgamerankViewPresentor", package.seeall)

local BricksxgamerankViewPresentor = class("BricksxgamerankViewPresentor", ViewPresentor)

function BricksxgamerankViewPresentor:ctor()
	BricksxgamerankViewPresentor.super.ctor(self)
end

function BricksxgamerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BricksxgamerankViewPresentor:dependWhatResources()
	return {
		"ui/views/bricksxgame/bricksxgamerankview.prefab"
	}
end

function BricksxgamerankViewPresentor:buildViews()
	return {
		BricksxgamerankView.New()
	}
end

return BricksxgamerankViewPresentor
