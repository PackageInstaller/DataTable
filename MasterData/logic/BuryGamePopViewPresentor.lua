-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGamePopViewPresentor.lua

module("logic.extensions.burygame.view.BuryGamePopViewPresentor", package.seeall)

local BuryGamePopViewPresentor = class("BuryGamePopViewPresentor", ViewPresentor)

function BuryGamePopViewPresentor:ctor()
	BuryGamePopViewPresentor.super.ctor(self)
end

function BuryGamePopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuryGamePopViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygamepopview.prefab"
	}
end

function BuryGamePopViewPresentor:buildViews()
	return {
		BuryGamePopView.New()
	}
end

return BuryGamePopViewPresentor
