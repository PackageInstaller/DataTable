-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodFlowerCostViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodFlowerCostViewPresentor", package.seeall)

local AoqiGodFlowerCostViewPresentor = class("AoqiGodFlowerCostViewPresentor", ViewPresentor)

function AoqiGodFlowerCostViewPresentor:ctor()
	AoqiGodFlowerCostViewPresentor.super.ctor(self)
end

function AoqiGodFlowerCostViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiGodFlowerCostViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodflowercostview.prefab"
	}
end

function AoqiGodFlowerCostViewPresentor:buildViews()
	return {
		AoqiGodFlowerCostView.New()
	}
end

return AoqiGodFlowerCostViewPresentor
