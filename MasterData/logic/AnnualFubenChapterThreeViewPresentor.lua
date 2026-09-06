-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenChapterThreeViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenChapterThreeViewPresentor", package.seeall)

local AnnualFubenChapterThreeViewPresentor = class("AnnualFubenChapterThreeViewPresentor", ViewPresentor)

function AnnualFubenChapterThreeViewPresentor:ctor()
	AnnualFubenChapterThreeViewPresentor.super.ctor(self)
end

function AnnualFubenChapterThreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFubenChapterThreeViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubenchapterthreeview.prefab"
	}
end

function AnnualFubenChapterThreeViewPresentor:buildViews()
	return {
		AnnualFubenChapterThreeView.New()
	}
end

return AnnualFubenChapterThreeViewPresentor
