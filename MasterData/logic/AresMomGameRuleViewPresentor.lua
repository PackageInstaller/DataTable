-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomGameRuleViewPresentor.lua

module("logic.extensions.aresmom.view.AresMomGameRuleViewPresentor", package.seeall)

local AresMomGameRuleViewPresentor = class("AresMomGameRuleViewPresentor", ViewPresentor)

function AresMomGameRuleViewPresentor:ctor()
	AresMomGameRuleViewPresentor.super.ctor(self)
end

function AresMomGameRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AresMomGameRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/aresmomgameruleview.prefab"
	}
end

function AresMomGameRuleViewPresentor:buildViews()
	return {
		AresMomGameRuleView.New()
	}
end

return AresMomGameRuleViewPresentor
