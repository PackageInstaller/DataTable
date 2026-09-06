-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketRewardLevelViewPresentor.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketRewardLevelViewPresentor", package.seeall)

local AnniversaryMarketRewardLevelViewPresentor = class("AnniversaryMarketRewardLevelViewPresentor", ViewPresentor)

function AnniversaryMarketRewardLevelViewPresentor:ctor()
	AnniversaryMarketRewardLevelViewPresentor.super.ctor(self)
end

function AnniversaryMarketRewardLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniversaryMarketRewardLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarymarket/anniversarymarketrewardlevelview.prefab"
	}
end

function AnniversaryMarketRewardLevelViewPresentor:buildViews()
	return {
		AnniversaryMarketRewardLevelView.New()
	}
end

return AnniversaryMarketRewardLevelViewPresentor
