-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/baioogamescommunity/view/BaioogamescommunityViewPresentor.lua

module("logic.extensions.baioogamescommunity.view.BaioogamescommunityViewPresentor", package.seeall)

local BaioogamescommunityViewPresentor = class("BaioogamescommunityViewPresentor", ViewPresentor)

function BaioogamescommunityViewPresentor:ctor()
	BaioogamescommunityViewPresentor.super.ctor(self)
end

function BaioogamescommunityViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BaioogamescommunityViewPresentor:dependWhatResources()
	return {
		"ui/views/baioogamescommunity/baioogamescommunityview.prefab"
	}
end

function BaioogamescommunityViewPresentor:buildViews()
	return {
		BaioogamescommunityView.New()
	}
end

return BaioogamescommunityViewPresentor
