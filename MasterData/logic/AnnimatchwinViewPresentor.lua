-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchwinViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchwinViewPresentor", package.seeall)

local AnnimatchwinViewPresentor = class("AnnimatchwinViewPresentor", ViewPresentor)

function AnnimatchwinViewPresentor:ctor()
	AnnimatchwinViewPresentor.super.ctor(self)
end

function AnnimatchwinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchwinViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchwinview.prefab"
	}
end

function AnnimatchwinViewPresentor:buildViews()
	return {
		AnnimatchwinView.New()
	}
end

return AnnimatchwinViewPresentor
