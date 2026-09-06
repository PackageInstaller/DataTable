-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushHolyStripeGainViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushHolyStripeGainViewPresentor", package.seeall)

local AbyssGoldRushHolyStripeGainViewPresentor = class("AbyssGoldRushHolyStripeGainViewPresentor", ViewPresentor)

function AbyssGoldRushHolyStripeGainViewPresentor:ctor()
	AbyssGoldRushHolyStripeGainViewPresentor.super.ctor(self)
end

function AbyssGoldRushHolyStripeGainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushHolyStripeGainViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushholystripegainview.prefab"
	}
end

function AbyssGoldRushHolyStripeGainViewPresentor:buildViews()
	return {
		AbyssGoldRushHolyStripeGainView.New()
	}
end

return AbyssGoldRushHolyStripeGainViewPresentor
