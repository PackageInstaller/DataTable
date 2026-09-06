-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/BreakFormationViewPresentor.lua

module("logic.extensions.breakformation.view.BreakFormationViewPresentor", package.seeall)

local BreakFormationViewPresentor = class("BreakFormationViewPresentor", ViewWithGuidePresentor)

function BreakFormationViewPresentor:ctor()
	BreakFormationViewPresentor.super.ctor(self)
end

function BreakFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BreakFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/breakformation/breakformationview.prefab"
	}
end

function BreakFormationViewPresentor:buildViews()
	return {
		BreakFormationView.New()
	}
end

return BreakFormationViewPresentor
