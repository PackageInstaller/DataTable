-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/axiu/AxiuRuleMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.axiu.AxiuRuleMainViewPresentor", package.seeall)

local AxiuRuleMainViewPresentor = class("AxiuRuleMainViewPresentor", ViewPresentor)

function AxiuRuleMainViewPresentor:ctor()
	AxiuRuleMainViewPresentor.super.ctor(self)
end

function AxiuRuleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AxiuRuleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/axiu/axiurulemainview.prefab"
	}
end

function AxiuRuleMainViewPresentor:buildViews()
	return {
		AxiuRuleMainView.New()
	}
end

return AxiuRuleMainViewPresentor
