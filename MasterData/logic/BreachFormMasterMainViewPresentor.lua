-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterMainViewPresentor.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterMainViewPresentor", package.seeall)

local BreachFormMasterMainViewPresentor = class("BreachFormMasterMainViewPresentor", ViewPresentor)

function BreachFormMasterMainViewPresentor:ctor()
	BreachFormMasterMainViewPresentor.super.ctor(self)
end

function BreachFormMasterMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BreachFormMasterMainViewPresentor:dependWhatResources()
	return {
		"ui/views/breachformmaster/breachformmastermainview.prefab"
	}
end

function BreachFormMasterMainViewPresentor:buildViews()
	return {
		BreachFormMasterMainView.New()
	}
end

return BreachFormMasterMainViewPresentor
