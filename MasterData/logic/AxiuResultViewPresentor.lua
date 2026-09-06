-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/axiu/AxiuResultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.axiu.AxiuResultViewPresentor", package.seeall)

local AxiuResultViewPresentor = class("AxiuResultViewPresentor", ViewPresentor)

function AxiuResultViewPresentor:ctor()
	AxiuResultViewPresentor.super.ctor(self)
end

function AxiuResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AxiuResultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/axiu/axiuresultview.prefab"
	}
end

function AxiuResultViewPresentor:buildViews()
	return {
		AxiuResultView.New()
	}
end

return AxiuResultViewPresentor
