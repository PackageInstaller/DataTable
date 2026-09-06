-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterRankViewPresentor.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterRankViewPresentor", package.seeall)

local BreachFormMasterRankViewPresentor = class("BreachFormMasterRankViewPresentor", ViewPresentor)

function BreachFormMasterRankViewPresentor:ctor()
	BreachFormMasterRankViewPresentor.super.ctor(self)
end

function BreachFormMasterRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BreachFormMasterRankViewPresentor:dependWhatResources()
	return {
		"ui/views/breachformmaster/breachformmasterrankview.prefab"
	}
end

function BreachFormMasterRankViewPresentor:buildViews()
	return {
		BreachFormMasterRankView.New()
	}
end

return BreachFormMasterRankViewPresentor
