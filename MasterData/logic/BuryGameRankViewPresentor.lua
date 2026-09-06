-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameRankViewPresentor.lua

module("logic.extensions.burygame.view.BuryGameRankViewPresentor", package.seeall)

local BuryGameRankViewPresentor = class("BuryGameRankViewPresentor", ViewPresentor)

function BuryGameRankViewPresentor:ctor()
	BuryGameRankViewPresentor.super.ctor(self)
end

function BuryGameRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BuryGameRankViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygamerankview.prefab"
	}
end

function BuryGameRankViewPresentor:buildViews()
	return {
		BuryGameRankView.New()
	}
end

return BuryGameRankViewPresentor
