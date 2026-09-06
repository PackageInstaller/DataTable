-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/view/BricksxgameresultViewPresentor.lua

module("logic.extensions.bricksxgame.view.BricksxgameresultViewPresentor", package.seeall)

local BricksxgameresultViewPresentor = class("BricksxgameresultViewPresentor", ViewPresentor)

function BricksxgameresultViewPresentor:ctor()
	BricksxgameresultViewPresentor.super.ctor(self)
end

function BricksxgameresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BricksxgameresultViewPresentor:dependWhatResources()
	return {
		"ui/views/bricksxgame/bricksxgameresultview.prefab"
	}
end

function BricksxgameresultViewPresentor:buildViews()
	return {
		BricksxgameresultView.New()
	}
end

return BricksxgameresultViewPresentor
