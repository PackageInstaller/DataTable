-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaforceViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaforceViewPresentor", package.seeall)

local AthenaforceViewPresentor = class("AthenaforceViewPresentor", ViewPresentor)

function AthenaforceViewPresentor:ctor()
	AthenaforceViewPresentor.super.ctor(self)
end

function AthenaforceViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AthenaforceViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/athena/athenaforceview.prefab"
	}
end

function AthenaforceViewPresentor:buildViews()
	return {
		AthenaForceView.New()
	}
end

return AthenaforceViewPresentor
