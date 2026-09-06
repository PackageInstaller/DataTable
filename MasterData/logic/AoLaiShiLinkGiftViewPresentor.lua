-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aolaishilink/view/AoLaiShiLinkGiftViewPresentor.lua

module("logic.extensions.aolaishilink.view.AoLaiShiLinkGiftViewPresentor", package.seeall)

local AoLaiShiLinkGiftViewPresentor = class("AoLaiShiLinkGiftViewPresentor", ViewPresentor)

function AoLaiShiLinkGiftViewPresentor:ctor()
	AoLaiShiLinkGiftViewPresentor.super.ctor(self)
end

function AoLaiShiLinkGiftViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoLaiShiLinkGiftViewPresentor:dependWhatResources()
	return {
		"ui/views/aolaishilink/aolaishilinkgiftview.prefab"
	}
end

function AoLaiShiLinkGiftViewPresentor:buildViews()
	return {
		AoLaiShiLinkGiftView.New()
	}
end

return AoLaiShiLinkGiftViewPresentor
