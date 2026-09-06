-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aolaishilink/view/AoLaiShiStrategyViewPresentor.lua

module("logic.extensions.aolaishilink.view.AoLaiShiStrategyViewPresentor", package.seeall)

local AoLaiShiStrategyViewPresentor = class("AoLaiShiStrategyViewPresentor", ViewPresentor)

function AoLaiShiStrategyViewPresentor:ctor()
	AoLaiShiStrategyViewPresentor.super.ctor(self)
end

function AoLaiShiStrategyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoLaiShiStrategyViewPresentor:dependWhatResources()
	return {
		"ui/views/aolaishilink/aolaishistrategyview.prefab"
	}
end

function AoLaiShiStrategyViewPresentor:buildViews()
	return {
		AoLaiShiStrategyView.New()
	}
end

return AoLaiShiStrategyViewPresentor
