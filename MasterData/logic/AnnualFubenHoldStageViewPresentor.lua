-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenHoldStageViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenHoldStageViewPresentor", package.seeall)

local AnnualFubenHoldStageViewPresentor = class("AnnualFubenHoldStageViewPresentor", ViewPresentor)

function AnnualFubenHoldStageViewPresentor:ctor()
	AnnualFubenHoldStageViewPresentor.super.ctor(self)
end

function AnnualFubenHoldStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFubenHoldStageViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubenholdstageview.prefab"
	}
end

function AnnualFubenHoldStageViewPresentor:buildViews()
	return {
		AnnualFubenHoldStageView.New()
	}
end

return AnnualFubenHoldStageViewPresentor
