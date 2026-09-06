-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodDiamondCostViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodDiamondCostViewPresentor", package.seeall)

local AoqiGodDiamondCostViewPresentor = class("AoqiGodDiamondCostViewPresentor", ViewPresentor)

function AoqiGodDiamondCostViewPresentor:ctor()
	AoqiGodDiamondCostViewPresentor.super.ctor(self)
end

function AoqiGodDiamondCostViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiGodDiamondCostViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigoddiamondcostview.prefab"
	}
end

function AoqiGodDiamondCostViewPresentor:buildViews()
	return {
		AoqiGodDiamondCostView.New()
	}
end

return AoqiGodDiamondCostViewPresentor
