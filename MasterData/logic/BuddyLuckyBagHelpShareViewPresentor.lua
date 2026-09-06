-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagHelpShareViewPresentor.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagHelpShareViewPresentor", package.seeall)

local BuddyLuckyBagHelpShareViewPresentor = class("BuddyLuckyBagHelpShareViewPresentor", ViewPresentor)

function BuddyLuckyBagHelpShareViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuddyLuckyBagHelpShareViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyluckybag/buddyluckybaghelpshareview.prefab"
	}
end

function BuddyLuckyBagHelpShareViewPresentor:buildViews()
	return {
		BuddyLuckyBagHelpShareView.New()
	}
end

return BuddyLuckyBagHelpShareViewPresentor
