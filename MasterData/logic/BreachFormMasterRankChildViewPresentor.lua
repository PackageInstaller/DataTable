-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterRankChildViewPresentor.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterRankChildViewPresentor", package.seeall)

local BreachFormMasterRankChildViewPresentor = class("BreachFormMasterRankChildViewPresentor", ViewPresentor)

function BreachFormMasterRankChildViewPresentor:ctor()
	BreachFormMasterRankChildViewPresentor.super.ctor(self)
end

function BreachFormMasterRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BreachFormMasterRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/breachformmaster/breachformmasterrankchildview.prefab"
	}
end

function BreachFormMasterRankChildViewPresentor:buildViews()
	return {
		BreachFormMasterRankChildView.New()
	}
end

function BreachFormMasterRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return BreachFormMasterRankChildViewPresentor
