-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenSearchViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenSearchViewPresentor", package.seeall)

local AnnualFubenSearchViewPresentor = class("AnnualFubenSearchViewPresentor", ViewPresentor)

function AnnualFubenSearchViewPresentor:ctor()
	AnnualFubenSearchViewPresentor.super.ctor(self)
end

function AnnualFubenSearchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFubenSearchViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubensearchview.prefab"
	}
end

function AnnualFubenSearchViewPresentor:buildViews()
	return {
		AnnualFubenSearchView.New()
	}
end

return AnnualFubenSearchViewPresentor
