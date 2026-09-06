-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/view/AnnualTaskViewPresentor.lua

module("logic.extensions.annualactivity.view.AnnualTaskViewPresentor", package.seeall)

local AnnualTaskViewPresentor = class("AnnualTaskViewPresentor", ViewPresentor)

function AnnualTaskViewPresentor:ctor()
	AnnualTaskViewPresentor.super.ctor(self)
end

function AnnualTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/annualactivity/annualtaskview.prefab"
	}
end

function AnnualTaskViewPresentor:buildViews()
	return {
		AnnualTaskView.New()
	}
end

return AnnualTaskViewPresentor
