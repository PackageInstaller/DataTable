-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroAllReportViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroAllReportViewPresentor", package.seeall)

local AoqiHeroAllReportViewPresentor = class("AoqiHeroAllReportViewPresentor", ViewPresentor)

function AoqiHeroAllReportViewPresentor:ctor()
	AoqiHeroAllReportViewPresentor.super.ctor(self)
end

function AoqiHeroAllReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiHeroAllReportViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheroallreportview.prefab"
	}
end

function AoqiHeroAllReportViewPresentor:buildViews()
	return {
		AoqiHeroAllReportView.New()
	}
end

return AoqiHeroAllReportViewPresentor
