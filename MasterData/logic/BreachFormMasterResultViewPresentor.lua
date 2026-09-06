-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterResultViewPresentor.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterResultViewPresentor", package.seeall)

local BreachFormMasterResultViewPresentor = class("BreachFormMasterResultViewPresentor", ViewPresentor)

function BreachFormMasterResultViewPresentor:ctor()
	BreachFormMasterResultViewPresentor.super.ctor(self)
end

function BreachFormMasterResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BreachFormMasterResultViewPresentor:dependWhatResources()
	return {
		"ui/views/breachformmaster/breachformmasterresultview.prefab"
	}
end

function BreachFormMasterResultViewPresentor:buildViews()
	return {
		BreachFormMasterResultView.New()
	}
end

return BreachFormMasterResultViewPresentor
