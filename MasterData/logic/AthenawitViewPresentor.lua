-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenawitViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenawitViewPresentor", package.seeall)

local AthenawitViewPresentor = class("AthenawitViewPresentor", ViewPresentor)

function AthenawitViewPresentor:ctor()
	AthenawitViewPresentor.super.ctor(self)
end

function AthenawitViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AthenawitViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/athena/athenawitview.prefab"
	}
end

function AthenawitViewPresentor:buildViews()
	return {
		AthenaWitView.New()
	}
end

return AthenawitViewPresentor
