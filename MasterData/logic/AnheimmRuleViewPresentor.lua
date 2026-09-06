-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmRuleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmRuleViewPresentor", package.seeall)

local AnheimmRuleViewPresentor = class("AnheimmRuleViewPresentor", ViewPresentor)

function AnheimmRuleViewPresentor:ctor()
	AnheimmRuleViewPresentor.super.ctor(self)
end

function AnheimmRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnheimmRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmruleview.prefab"
	}
end

function AnheimmRuleViewPresentor:buildViews()
	return {
		AnheimmRuleView.New()
	}
end

return AnheimmRuleViewPresentor
