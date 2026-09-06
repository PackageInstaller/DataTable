-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenamainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenamainViewPresentor", package.seeall)

local AthenamainViewPresentor = class("AthenamainViewPresentor", ViewPresentor)

function AthenamainViewPresentor:ctor()
	AthenamainViewPresentor.super.ctor(self)
end

function AthenamainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AthenamainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/athena/athenamainview.prefab"
	}
end

function AthenamainViewPresentor:buildViews()
	return {
		AthenaMainView.New()
	}
end

return AthenamainViewPresentor
