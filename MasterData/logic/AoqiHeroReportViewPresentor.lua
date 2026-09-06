-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroReportViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroReportViewPresentor", package.seeall)

local AoqiHeroReportViewPresentor = class("AoqiHeroReportViewPresentor", ViewPresentor)

function AoqiHeroReportViewPresentor:ctor()
	AoqiHeroReportViewPresentor.super.ctor(self)
end

function AoqiHeroReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroReportViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheroreportview.prefab"
	}
end

function AoqiHeroReportViewPresentor:buildViews()
	return {
		AoqiHeroReportView.New()
	}
end

return AoqiHeroReportViewPresentor
