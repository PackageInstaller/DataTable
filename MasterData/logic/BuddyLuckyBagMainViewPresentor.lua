-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagMainViewPresentor.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagMainViewPresentor", package.seeall)

local BuddyLuckyBagMainViewPresentor = class("BuddyLuckyBagMainViewPresentor", ViewPresentor)

function BuddyLuckyBagMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BuddyLuckyBagMainViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyluckybag/buddyluckybagmainview.prefab"
	}
end

function BuddyLuckyBagMainViewPresentor:buildViews()
	return {
		BuddyLuckyBagMainView.New()
	}
end

return BuddyLuckyBagMainViewPresentor
