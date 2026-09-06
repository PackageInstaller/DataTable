-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketRefreshViewPresentor.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketRefreshViewPresentor", package.seeall)

local AnniversaryMarketRefreshViewPresentor = class("AnniversaryMarketRefreshViewPresentor", ViewPresentor)

function AnniversaryMarketRefreshViewPresentor:ctor()
	AnniversaryMarketRefreshViewPresentor.super.ctor(self)
end

function AnniversaryMarketRefreshViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnniversaryMarketRefreshViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarymarket/anniversarymarketrefreshview.prefab"
	}
end

function AnniversaryMarketRefreshViewPresentor:buildViews()
	return {
		AnniversaryMarketRefreshView.New()
	}
end

return AnniversaryMarketRefreshViewPresentor
