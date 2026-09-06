-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/view/AnnualWelfareMainViewPresentor.lua

module("logic.extensions.firstannualwelfare.view.AnnualWelfareMainViewPresentor", package.seeall)

local AnnualWelfareMainViewPresentor = class("AnnualWelfareMainViewPresentor", ViewPresentor)

function AnnualWelfareMainViewPresentor:ctor()
	AnnualWelfareMainViewPresentor.super.ctor(self)
end

function AnnualWelfareMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualWelfareMainViewPresentor:dependWhatResources()
	return {
		"ui/views/firstannualwelfare/annualmain/annualwelfaremainview.prefab"
	}
end

function AnnualWelfareMainViewPresentor:buildViews()
	return {
		AnnualWelfareMainView.New()
	}
end

return AnnualWelfareMainViewPresentor
