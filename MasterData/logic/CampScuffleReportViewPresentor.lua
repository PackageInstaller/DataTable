-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleReportViewPresentor.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleReportViewPresentor", package.seeall)

local CampScuffleReportViewPresentor = class("CampScuffleReportViewPresentor", ViewPresentor)

function CampScuffleReportViewPresentor:ctor()
	CampScuffleReportViewPresentor.super.ctor(self)
end

function CampScuffleReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CampScuffleReportViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/campscuffle/campscufflereportview.prefab"
	}
end

function CampScuffleReportViewPresentor:buildViews()
	return {
		CampScuffleReportView.New()
	}
end

return CampScuffleReportViewPresentor
