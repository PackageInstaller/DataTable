-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aruisi/AruisiDetailViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.aruisi.AruisiDetailViewPresentor", package.seeall)

local AruisiDetailViewPresentor = class("AruisiDetailViewPresentor", ViewPresentor)

function AruisiDetailViewPresentor:ctor()
	AruisiDetailViewPresentor.super.ctor(self)
end

function AruisiDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AruisiDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/aruisidetailview.prefab"
	}
end

function AruisiDetailViewPresentor:buildViews()
	return {
		AruisiDetailView.New()
	}
end

return AruisiDetailViewPresentor
