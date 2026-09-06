-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketInviteViewPresentor.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketInviteViewPresentor", package.seeall)

local AnniversaryMarketInviteViewPresentor = class("AnniversaryMarketInviteViewPresentor", ViewPresentor)

function AnniversaryMarketInviteViewPresentor:ctor()
	AnniversaryMarketInviteViewPresentor.super.ctor(self)
end

function AnniversaryMarketInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniversaryMarketInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarymarket/anniversarymarketinviteview.prefab"
	}
end

function AnniversaryMarketInviteViewPresentor:buildViews()
	return {
		AnniversaryMarketInviteView.New()
	}
end

return AnniversaryMarketInviteViewPresentor
