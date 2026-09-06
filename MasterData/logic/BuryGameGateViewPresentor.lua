-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameGateViewPresentor.lua

module("logic.extensions.burygame.view.BuryGameGateViewPresentor", package.seeall)

local BuryGameGateViewPresentor = class("BuryGameGateViewPresentor", ViewPresentor)

function BuryGameGateViewPresentor:ctor()
	BuryGameGateViewPresentor.super.ctor(self)
end

function BuryGameGateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BuryGameGateViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygamestartview.prefab"
	}
end

function BuryGameGateViewPresentor:buildViews()
	return {
		BuryGameGateView.New()
	}
end

return BuryGameGateViewPresentor
