-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryCountDownViewPresentor.lua

module("logic.extensions.burygame.view.BuryCountDownViewPresentor", package.seeall)

local BuryCountDownViewPresentor = class("BuryCountDownViewPresentor", ViewPresentor)

function BuryCountDownViewPresentor:ctor()
	BuryCountDownViewPresentor.super.ctor(self)
end

function BuryCountDownViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuryCountDownViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burycountdownview.prefab"
	}
end

function BuryCountDownViewPresentor:buildViews()
	return {
		BuryCountDownView.New()
	}
end

return BuryCountDownViewPresentor
