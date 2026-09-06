-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodCharmCostViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodCharmCostViewPresentor", package.seeall)

local AoqiGodCharmCostViewPresentor = class("AoqiGodCharmCostViewPresentor", ViewPresentor)

function AoqiGodCharmCostViewPresentor:ctor()
	AoqiGodCharmCostViewPresentor.super.ctor(self)
end

function AoqiGodCharmCostViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiGodCharmCostViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodcharmcostview.prefab"
	}
end

function AoqiGodCharmCostViewPresentor:buildViews()
	return {
		AoqiGodCharmCostView.New()
	}
end

return AoqiGodCharmCostViewPresentor
