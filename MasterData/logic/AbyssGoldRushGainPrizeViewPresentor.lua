-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushGainPrizeViewPresentor.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushGainPrizeViewPresentor", package.seeall)

local AbyssGoldRushGainPrizeViewPresentor = class("AbyssGoldRushGainPrizeViewPresentor", ViewPresentor)

function AbyssGoldRushGainPrizeViewPresentor:ctor()
	AbyssGoldRushGainPrizeViewPresentor.super.ctor(self)
end

function AbyssGoldRushGainPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AbyssGoldRushGainPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/abyssgoldrush/abyssgoldrushgainprizeview.prefab"
	}
end

function AbyssGoldRushGainPrizeViewPresentor:buildViews()
	return {
		AbyssGoldRushGainPrizeView.New()
	}
end

return AbyssGoldRushGainPrizeViewPresentor
