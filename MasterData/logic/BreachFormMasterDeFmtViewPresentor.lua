-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterDeFmtViewPresentor.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterDeFmtViewPresentor", package.seeall)

local BreachFormMasterDeFmtViewPresentor = class("BreachFormMasterDeFmtViewPresentor", ViewPresentor)

function BreachFormMasterDeFmtViewPresentor:ctor()
	BreachFormMasterDeFmtViewPresentor.super.ctor(self)
end

function BreachFormMasterDeFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BreachFormMasterDeFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/breachformmaster/breachformmasterdefmtview.prefab"
	}
end

function BreachFormMasterDeFmtViewPresentor:buildViews()
	return {
		BreachFormMasterDeFmtView.New()
	}
end

return BreachFormMasterDeFmtViewPresentor
