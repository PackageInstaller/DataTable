-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameMainViewPresentor.lua

module("logic.extensions.burygame.view.BuryGameMainViewPresentor", package.seeall)

local BuryGameMainViewPresentor = class("BuryGameMainViewPresentor", ViewPresentor)

function BuryGameMainViewPresentor:ctor()
	BuryGameMainViewPresentor.super.ctor(self)
end

function BuryGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BuryGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygamemainview.prefab"
	}
end

function BuryGameMainViewPresentor:buildViews()
	return {
		BuryGameMainView.New()
	}
end

return BuryGameMainViewPresentor
