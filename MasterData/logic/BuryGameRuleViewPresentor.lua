-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameRuleViewPresentor.lua

module("logic.extensions.burygame.view.BuryGameRuleViewPresentor", package.seeall)

local BuryGameRuleViewPresentor = class("BuryGameRuleViewPresentor", ViewPresentor)

function BuryGameRuleViewPresentor:ctor()
	BuryGameRuleViewPresentor.super.ctor(self)
end

function BuryGameRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuryGameRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygameruleview.prefab"
	}
end

function BuryGameRuleViewPresentor:buildViews()
	return {
		BuryGameRuleView.New()
	}
end

return BuryGameRuleViewPresentor
