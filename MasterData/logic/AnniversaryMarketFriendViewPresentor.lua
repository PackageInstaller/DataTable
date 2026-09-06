-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketFriendViewPresentor.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketFriendViewPresentor", package.seeall)

local AnniversaryMarketFriendViewPresentor = class("AnniversaryMarketFriendViewPresentor", ViewPresentor)

function AnniversaryMarketFriendViewPresentor:ctor()
	AnniversaryMarketFriendViewPresentor.super.ctor(self)
end

function AnniversaryMarketFriendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniversaryMarketFriendViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarymarket/anniversarymarketfriendview.prefab"
	}
end

function AnniversaryMarketFriendViewPresentor:buildViews()
	return {
		AnniversaryMarketFriendView.New()
	}
end

return AnniversaryMarketFriendViewPresentor
