-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagShareViewPresentor.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagShareViewPresentor", package.seeall)

local BuddyLuckyBagShareViewPresentor = class("BuddyLuckyBagShareViewPresentor", ViewPresentor)

function BuddyLuckyBagShareViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuddyLuckyBagShareViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyluckybag/buddyluckybagshareview.prefab"
	}
end

function BuddyLuckyBagShareViewPresentor:buildViews()
	return {
		BuddyLuckyBagShareView.New()
	}
end

return BuddyLuckyBagShareViewPresentor
