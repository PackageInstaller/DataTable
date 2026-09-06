-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagSharePrizeViewPresentor.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagSharePrizeViewPresentor", package.seeall)

local BuddyLuckyBagSharePrizeViewPresentor = class("BuddyLuckyBagSharePrizeViewPresentor", ViewPresentor)

function BuddyLuckyBagSharePrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuddyLuckyBagSharePrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyluckybag/buddyluckybagshareprizeview.prefab"
	}
end

function BuddyLuckyBagSharePrizeViewPresentor:buildViews()
	return {
		BuddyLuckyBagSharePrizeView.New()
	}
end

return BuddyLuckyBagSharePrizeViewPresentor
