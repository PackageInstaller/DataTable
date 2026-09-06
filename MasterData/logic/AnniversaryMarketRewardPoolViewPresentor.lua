-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketRewardPoolViewPresentor.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketRewardPoolViewPresentor", package.seeall)

local AnniversaryMarketRewardPoolViewPresentor = class("AnniversaryMarketRewardPoolViewPresentor", ViewPresentor)

function AnniversaryMarketRewardPoolViewPresentor:ctor()
	AnniversaryMarketRewardPoolViewPresentor.super.ctor(self)
end

function AnniversaryMarketRewardPoolViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniversaryMarketRewardPoolViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarymarket/anniversarymarketrewardpoolview.prefab"
	}
end

function AnniversaryMarketRewardPoolViewPresentor:buildViews()
	return {
		AnniversaryMarketRewardPoolView.New()
	}
end

return AnniversaryMarketRewardPoolViewPresentor
