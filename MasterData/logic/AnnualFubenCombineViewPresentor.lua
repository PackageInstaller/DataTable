-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenCombineViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenCombineViewPresentor", package.seeall)

local AnnualFubenCombineViewPresentor = class("AnnualFubenCombineViewPresentor", ViewPresentor)

function AnnualFubenCombineViewPresentor:ctor()
	AnnualFubenCombineViewPresentor.super.ctor(self)
end

function AnnualFubenCombineViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFubenCombineViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubencombineview.prefab"
	}
end

function AnnualFubenCombineViewPresentor:buildViews()
	return {
		AnnualFubenCombineView.New()
	}
end

return AnnualFubenCombineViewPresentor
