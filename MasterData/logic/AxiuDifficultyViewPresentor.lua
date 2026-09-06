-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/axiu/AxiuDifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.axiu.AxiuDifficultyViewPresentor", package.seeall)

local AxiuDifficultyViewPresentor = class("AxiuDifficultyViewPresentor", ViewPresentor)

function AxiuDifficultyViewPresentor:ctor()
	AxiuDifficultyViewPresentor.super.ctor(self)
end

function AxiuDifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AxiuDifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/axiu/axiudifficultyview.prefab"
	}
end

function AxiuDifficultyViewPresentor:buildViews()
	return {
		AxiuDifficultyView.New()
	}
end

return AxiuDifficultyViewPresentor
