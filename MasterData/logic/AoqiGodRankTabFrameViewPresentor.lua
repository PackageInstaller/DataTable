-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/rank/AoqiGodRankTabFrameViewPresentor.lua

module("logic.extensions.aoqigod.view.rank.AoqiGodRankTabFrameViewPresentor", package.seeall)

local AoqiGodRankTabFrameViewPresentor = class("AoqiGodRankTabFrameViewPresentor", ViewPresentor)

function AoqiGodRankTabFrameViewPresentor:ctor()
	AoqiGodRankTabFrameViewPresentor.super.ctor(self)
end

function AoqiGodRankTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiGodRankTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodranktabframeview.prefab"
	}
end

function AoqiGodRankTabFrameViewPresentor:buildViews()
	return {
		AoqiGodRankTabFrameView.New()
	}
end

return AoqiGodRankTabFrameViewPresentor
