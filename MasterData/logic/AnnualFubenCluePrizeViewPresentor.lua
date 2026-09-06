-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenCluePrizeViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenCluePrizeViewPresentor", package.seeall)

local AnnualFubenCluePrizeViewPresentor = class("AnnualFubenCluePrizeViewPresentor", ViewPresentor)

function AnnualFubenCluePrizeViewPresentor:ctor()
	AnnualFubenCluePrizeViewPresentor.super.ctor(self)
end

function AnnualFubenCluePrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnnualFubenCluePrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubenclueprizeview.prefab"
	}
end

function AnnualFubenCluePrizeViewPresentor:buildViews()
	return {
		AnnualFubenCluePrizeView.New()
	}
end

return AnnualFubenCluePrizeViewPresentor
