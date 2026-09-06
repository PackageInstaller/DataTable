-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketMainViewPresentor.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketMainViewPresentor", package.seeall)

local AnniversaryMarketMainViewPresentor = class("AnniversaryMarketMainViewPresentor", ViewPresentor)

function AnniversaryMarketMainViewPresentor:ctor()
	AnniversaryMarketMainViewPresentor.super.ctor(self)
end

function AnniversaryMarketMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniversaryMarketMainViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarymarket/anniversarymarketmainview.prefab"
	}
end

function AnniversaryMarketMainViewPresentor:buildViews()
	return {
		AnniversaryMarketMainView.New()
	}
end

return AnniversaryMarketMainViewPresentor
