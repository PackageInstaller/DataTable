-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/bury/BuryGameMainCopyOfTourArenaViewPresentor.lua

module("logic.extensions.tourarena.view.copy.bury.BuryGameMainCopyOfTourArenaViewPresentor", package.seeall)

local BuryGameMainCopyOfTourArenaViewPresentor = class("BuryGameMainCopyOfTourArenaViewPresentor", ViewPresentor)

function BuryGameMainCopyOfTourArenaViewPresentor:ctor()
	BuryGameMainCopyOfTourArenaViewPresentor.super.ctor(self)
end

function BuryGameMainCopyOfTourArenaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BuryGameMainCopyOfTourArenaViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygamemainview.prefab"
	}
end

function BuryGameMainCopyOfTourArenaViewPresentor:buildViews()
	return {
		BuryGameMainCopyOfTourArenaView.New()
	}
end

return BuryGameMainCopyOfTourArenaViewPresentor
