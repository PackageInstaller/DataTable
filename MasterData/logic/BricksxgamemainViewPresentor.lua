-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/view/BricksxgamemainViewPresentor.lua

module("logic.extensions.bricksxgame.view.BricksxgamemainViewPresentor", package.seeall)

local BricksxgamemainViewPresentor = class("BricksxgamemainViewPresentor", ViewPresentor)

function BricksxgamemainViewPresentor:ctor()
	BricksxgamemainViewPresentor.super.ctor(self)
end

function BricksxgamemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BricksxgamemainViewPresentor:dependWhatResources()
	return {
		"ui/views/bricksxgame/bricksxgamemainview.prefab"
	}
end

function BricksxgamemainViewPresentor:buildViews()
	return {
		BricksxgamemainView.New()
	}
end

return BricksxgamemainViewPresentor
