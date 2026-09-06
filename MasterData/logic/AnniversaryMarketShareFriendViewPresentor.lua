-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketShareFriendViewPresentor.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketShareFriendViewPresentor", package.seeall)

local AnniversaryMarketShareFriendViewPresentor = class("AnniversaryMarketShareFriendViewPresentor", ViewPresentor)

function AnniversaryMarketShareFriendViewPresentor:ctor()
	AnniversaryMarketShareFriendViewPresentor.super.ctor(self)
end

function AnniversaryMarketShareFriendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniversaryMarketShareFriendViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarymarket/anniversarymarketsharefriendview.prefab"
	}
end

function AnniversaryMarketShareFriendViewPresentor:buildViews()
	return {
		AnniversaryMarketShareFriendView.New()
	}
end

return AnniversaryMarketShareFriendViewPresentor
