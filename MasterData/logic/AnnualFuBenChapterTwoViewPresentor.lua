-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFuBenChapterTwoViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFuBenChapterTwoViewPresentor", package.seeall)

local AnnualFuBenChapterTwoViewPresentor = class("AnnualFuBenChapterTwoViewPresentor", ViewPresentor)

function AnnualFuBenChapterTwoViewPresentor:ctor()
	AnnualFuBenChapterTwoViewPresentor.super.ctor(self)
end

function AnnualFuBenChapterTwoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFuBenChapterTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubenchaptertwoview.prefab"
	}
end

function AnnualFuBenChapterTwoViewPresentor:buildViews()
	return {
		AnnualFuBenChapterTwoView.New()
	}
end

return AnnualFuBenChapterTwoViewPresentor
