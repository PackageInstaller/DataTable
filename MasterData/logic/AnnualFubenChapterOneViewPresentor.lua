-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenChapterOneViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenChapterOneViewPresentor", package.seeall)

local AnnualFubenChapterOneViewPresentor = class("AnnualFubenChapterOneViewPresentor", ViewPresentor)

function AnnualFubenChapterOneViewPresentor:ctor()
	AnnualFubenChapterOneViewPresentor.super.ctor(self)
end

function AnnualFubenChapterOneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFubenChapterOneViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubenchapteroneview.prefab"
	}
end

function AnnualFubenChapterOneViewPresentor:buildViews()
	return {
		AnnualFubenChapterOneView.New()
	}
end

return AnnualFubenChapterOneViewPresentor
