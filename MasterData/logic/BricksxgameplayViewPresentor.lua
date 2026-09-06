-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/view/BricksxgameplayViewPresentor.lua

module("logic.extensions.bricksxgame.view.BricksxgameplayViewPresentor", package.seeall)

local BricksxgameplayViewPresentor = class("BricksxgameplayViewPresentor", ViewPresentor)

function BricksxgameplayViewPresentor:ctor()
	BricksxgameplayViewPresentor.super.ctor(self)
end

function BricksxgameplayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BricksxgameplayViewPresentor:dependWhatResources()
	return {
		"ui/views/bricksxgame/bricksxgameplayview.prefab"
	}
end

function BricksxgameplayViewPresentor:buildViews()
	return {
		BricksxgameplayView.New()
	}
end

return BricksxgameplayViewPresentor
