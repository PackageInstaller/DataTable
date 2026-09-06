-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/rank/AoqiGodHelperRankViewPresentor.lua

module("logic.extensions.aoqigod.view.rank.AoqiGodHelperRankViewPresentor", package.seeall)

local AoqiGodHelperRankViewPresentor = class("AoqiGodHelperRankViewPresentor", ViewPresentor)

function AoqiGodHelperRankViewPresentor:ctor()
	AoqiGodHelperRankViewPresentor.super.ctor(self)
end

function AoqiGodHelperRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiGodHelperRankViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodhelperrankview.prefab"
	}
end

function AoqiGodHelperRankViewPresentor:buildViews()
	return {
		AoqiGodHelperRankView.New()
	}
end

function AoqiGodHelperRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AoqiGodHelperRankViewPresentor
