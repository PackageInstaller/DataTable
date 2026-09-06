-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyluckypreviewViewPresentor.lua

module("logic.extensions.buddyluckybag.view.BuddyluckypreviewViewPresentor", package.seeall)

local BuddyluckypreviewViewPresentor = class("BuddyluckypreviewViewPresentor", ViewPresentor)

function BuddyluckypreviewViewPresentor:ctor()
	BuddyluckypreviewViewPresentor.super.ctor(self)
end

function BuddyluckypreviewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BuddyluckypreviewViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyluckybag/buddyluckypreviewview.prefab"
	}
end

function BuddyluckypreviewViewPresentor:buildViews()
	return {
		BuddyluckypreviewView.New()
	}
end

return BuddyluckypreviewViewPresentor
