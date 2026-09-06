-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenBrokenRankViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenBrokenRankViewPresentor", package.seeall)

local AnnualFubenBrokenRankViewPresentor = class("AnnualFubenBrokenRankViewPresentor", ViewPresentor)

function AnnualFubenBrokenRankViewPresentor:ctor()
	AnnualFubenBrokenRankViewPresentor.super.ctor(self)
end

function AnnualFubenBrokenRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFubenBrokenRankViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubenbrokenrankview.prefab"
	}
end

function AnnualFubenBrokenRankViewPresentor:buildViews()
	return {
		AnnualFubenBrokenRankView.New()
	}
end

return AnnualFubenBrokenRankViewPresentor
