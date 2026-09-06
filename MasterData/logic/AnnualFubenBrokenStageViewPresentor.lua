-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenBrokenStageViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenBrokenStageViewPresentor", package.seeall)

local AnnualFubenBrokenStageViewPresentor = class("AnnualFubenBrokenStageViewPresentor", ViewPresentor)

function AnnualFubenBrokenStageViewPresentor:ctor()
	AnnualFubenBrokenStageViewPresentor.super.ctor(self)
end

function AnnualFubenBrokenStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFubenBrokenStageViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubenbrokenstageview.prefab"
	}
end

function AnnualFubenBrokenStageViewPresentor:buildViews()
	return {
		AnnualFubenBrokenStageView.New()
	}
end

return AnnualFubenBrokenStageViewPresentor
