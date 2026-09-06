-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchenterViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchenterViewPresentor", package.seeall)

local AnnimatchenterViewPresentor = class("AnnimatchenterViewPresentor", ViewPresentor)

function AnnimatchenterViewPresentor:ctor()
	AnnimatchenterViewPresentor.super.ctor(self)
end

function AnnimatchenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchenterViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchenterview.prefab"
	}
end

function AnnimatchenterViewPresentor:buildViews()
	return {
		AnnimatchenterView.New()
	}
end

return AnnimatchenterViewPresentor
