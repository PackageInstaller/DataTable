-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameEggViewPresentor.lua

module("logic.extensions.burygame.view.BuryGameEggViewPresentor", package.seeall)

local BuryGameEggViewPresentor = class("BuryGameEggViewPresentor", ViewPresentor)

function BuryGameEggViewPresentor:ctor()
	BuryGameEggViewPresentor.super.ctor(self)
end

function BuryGameEggViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuryGameEggViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygameeggview.prefab"
	}
end

function BuryGameEggViewPresentor:buildViews()
	return {
		BuryGameEggView.New()
	}
end

return BuryGameEggViewPresentor
