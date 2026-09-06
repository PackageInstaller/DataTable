-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenMainViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenMainViewPresentor", package.seeall)

local AnnualFubenMainViewPresentor = class("AnnualFubenMainViewPresentor", ViewPresentor)

function AnnualFubenMainViewPresentor:ctor()
	AnnualFubenMainViewPresentor.super.ctor(self)
end

function AnnualFubenMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFubenMainViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubenmainview.prefab"
	}
end

function AnnualFubenMainViewPresentor:buildViews()
	return {
		AnnualFubenMainView.New()
	}
end

return AnnualFubenMainViewPresentor
