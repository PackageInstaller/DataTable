-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagCardViewPresentor.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagCardViewPresentor", package.seeall)

local BuddyLuckyBagCardViewPresentor = class("BuddyLuckyBagCardViewPresentor", ViewPresentor)

function BuddyLuckyBagCardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BuddyLuckyBagCardViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyluckybag/buddyluckybagcardview.prefab"
	}
end

function BuddyLuckyBagCardViewPresentor:buildViews()
	return {
		BuddyLuckyBagCardView.New()
	}
end

return BuddyLuckyBagCardViewPresentor
