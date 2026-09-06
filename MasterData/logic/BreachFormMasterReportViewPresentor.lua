-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterReportViewPresentor.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterReportViewPresentor", package.seeall)

local BreachFormMasterReportViewPresentor = class("BreachFormMasterReportViewPresentor", ViewPresentor)

function BreachFormMasterReportViewPresentor:ctor()
	BreachFormMasterReportViewPresentor.super.ctor(self)
end

function BreachFormMasterReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BreachFormMasterReportViewPresentor:dependWhatResources()
	return {
		"ui/views/breachformmaster/breachformmasterreportview.prefab"
	}
end

function BreachFormMasterReportViewPresentor:buildViews()
	return {
		BreachFormMasterReportView.New()
	}
end

return BreachFormMasterReportViewPresentor
