-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleRuleViewPresentor.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleRuleViewPresentor", package.seeall)

local CampScuffleRuleViewPresentor = class("CampScuffleRuleViewPresentor", ViewPresentor)

function CampScuffleRuleViewPresentor:ctor()
	CampScuffleRuleViewPresentor.super.ctor(self)
end

function CampScuffleRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CampScuffleRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/campscuffle/campscuffleruleview.prefab"
	}
end

function CampScuffleRuleViewPresentor:buildViews()
	return {
		CampScuffleRuleView.New()
	}
end

return CampScuffleRuleViewPresentor
