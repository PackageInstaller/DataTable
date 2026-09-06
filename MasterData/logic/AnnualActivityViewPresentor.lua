-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/view/AnnualActivityViewPresentor.lua

module("logic.extensions.annualactivity.view.AnnualActivityViewPresentor", package.seeall)

local AnnualActivityViewPresentor = class("AnnualActivityViewPresentor", ViewPresentor)

function AnnualActivityViewPresentor:ctor()
	AnnualActivityViewPresentor.super.ctor(self)
end

function AnnualActivityViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualActivityViewPresentor:dependWhatResources()
	return {
		"ui/views/annualactivity/annualactivityview.prefab"
	}
end

function AnnualActivityViewPresentor:buildViews()
	return {
		AnnualActivityView.New()
	}
end

return AnnualActivityViewPresentor
