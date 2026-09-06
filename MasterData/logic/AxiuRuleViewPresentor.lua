-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/axiu/AxiuRuleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.axiu.AxiuRuleViewPresentor", package.seeall)

local AxiuRuleViewPresentor = class("AxiuRuleViewPresentor", ViewPresentor)

function AxiuRuleViewPresentor:ctor()
	AxiuRuleViewPresentor.super.ctor(self)
end

function AxiuRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AxiuRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/axiu/axiuruleview.prefab"
	}
end

function AxiuRuleViewPresentor:buildViews()
	return {
		AxiuRuleView.New()
	}
end

return AxiuRuleViewPresentor
