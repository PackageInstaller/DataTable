-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameLetterViewPresentor.lua

module("logic.extensions.burygame.view.BuryGameLetterViewPresentor", package.seeall)

local BuryGameLetterViewPresentor = class("BuryGameLetterViewPresentor", ViewPresentor)

function BuryGameLetterViewPresentor:ctor()
	BuryGameLetterViewPresentor.super.ctor(self)
end

function BuryGameLetterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuryGameLetterViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygameletterview.prefab"
	}
end

function BuryGameLetterViewPresentor:buildViews()
	return {
		BuryGameLetterView.New()
	}
end

return BuryGameLetterViewPresentor
