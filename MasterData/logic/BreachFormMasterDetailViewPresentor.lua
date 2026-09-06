-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterDetailViewPresentor.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterDetailViewPresentor", package.seeall)

local BreachFormMasterDetailViewPresentor = class("BreachFormMasterDetailViewPresentor", ViewPresentor)

function BreachFormMasterDetailViewPresentor:ctor()
	BreachFormMasterDetailViewPresentor.super.ctor(self)
end

function BreachFormMasterDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BreachFormMasterDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/breachformmaster/breachformmasterdetailview.prefab"
	}
end

function BreachFormMasterDetailViewPresentor:buildViews()
	return {
		BreachFormMasterDetailView.New()
	}
end

return BreachFormMasterDetailViewPresentor
