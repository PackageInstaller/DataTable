-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterPrizeViewPresentor.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterPrizeViewPresentor", package.seeall)

local BreachFormMasterPrizeViewPresentor = class("BreachFormMasterPrizeViewPresentor", ViewPresentor)

function BreachFormMasterPrizeViewPresentor:ctor()
	BreachFormMasterPrizeViewPresentor.super.ctor(self)
end

function BreachFormMasterPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BreachFormMasterPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/breachformmaster/breachformmasterprizeview.prefab"
	}
end

function BreachFormMasterPrizeViewPresentor:buildViews()
	return {
		BreachFormMasterPrizeView.New()
	}
end

return BreachFormMasterPrizeViewPresentor
