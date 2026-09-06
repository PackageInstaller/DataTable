-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagHelpCardSureViewPresentor.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagHelpCardSureViewPresentor", package.seeall)

local BuddyLuckyBagHelpCardSureViewPresentor = class("BuddyLuckyBagHelpCardSureViewPresentor", ViewPresentor)

function BuddyLuckyBagHelpCardSureViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuddyLuckyBagHelpCardSureViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyluckybag/buddyluckybaghelpcardsureview.prefab"
	}
end

function BuddyLuckyBagHelpCardSureViewPresentor:buildViews()
	return {
		BuddyLuckyBagHelpCardSureView.New()
	}
end

return BuddyLuckyBagHelpCardSureViewPresentor
