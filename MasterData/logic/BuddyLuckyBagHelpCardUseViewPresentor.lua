-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagHelpCardUseViewPresentor.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagHelpCardUseViewPresentor", package.seeall)

local BuddyLuckyBagHelpCardUseViewPresentor = class("BuddyLuckyBagHelpCardUseViewPresentor", ViewPresentor)

function BuddyLuckyBagHelpCardUseViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuddyLuckyBagHelpCardUseViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyluckybag/buddyluckybaghelpcarduseview.prefab"
	}
end

function BuddyLuckyBagHelpCardUseViewPresentor:buildViews()
	return {
		BuddyLuckyBagHelpCardUseView.New()
	}
end

return BuddyLuckyBagHelpCardUseViewPresentor
