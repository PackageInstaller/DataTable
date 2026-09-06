-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenClueTipViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenClueTipViewPresentor", package.seeall)

local AnnualFubenClueTipViewPresentor = class("AnnualFubenClueTipViewPresentor", ViewPresentor)

function AnnualFubenClueTipViewPresentor:ctor()
	AnnualFubenClueTipViewPresentor.super.ctor(self)
end

function AnnualFubenClueTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnnualFubenClueTipViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubencluetipview.prefab"
	}
end

function AnnualFubenClueTipViewPresentor:buildViews()
	return {
		AnnualFubenClueTipView.New()
	}
end

return AnnualFubenClueTipViewPresentor
