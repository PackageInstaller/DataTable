-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketSoldViewPresentor.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketSoldViewPresentor", package.seeall)

local AnniversaryMarketSoldViewPresentor = class("AnniversaryMarketSoldViewPresentor", ViewPresentor)

function AnniversaryMarketSoldViewPresentor:ctor()
	AnniversaryMarketSoldViewPresentor.super.ctor(self)
end

function AnniversaryMarketSoldViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniversaryMarketSoldViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarymarket/anniversarymarketsoldview.prefab"
	}
end

function AnniversaryMarketSoldViewPresentor:buildViews()
	return {
		AnniversaryMarketSoldView.New()
	}
end

return AnniversaryMarketSoldViewPresentor
