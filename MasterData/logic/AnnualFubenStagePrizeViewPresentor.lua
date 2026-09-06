-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenStagePrizeViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenStagePrizeViewPresentor", package.seeall)

local AnnualFubenStagePrizeViewPresentor = class("AnnualFubenStagePrizeViewPresentor", ViewPresentor)

function AnnualFubenStagePrizeViewPresentor:ctor()
	AnnualFubenStagePrizeViewPresentor.super.ctor(self)
end

function AnnualFubenStagePrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnnualFubenStagePrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubenstageprizeview.prefab"
	}
end

function AnnualFubenStagePrizeViewPresentor:buildViews()
	return {
		AnnualFubenStagePrizeView.New()
	}
end

return AnnualFubenStagePrizeViewPresentor
