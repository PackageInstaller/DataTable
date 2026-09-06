-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchFailViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchFailViewPresentor", package.seeall)

local AnnimatchFailViewPresentor = class("AnnimatchFailViewPresentor", ViewPresentor)

function AnnimatchFailViewPresentor:ctor()
	AnnimatchFailViewPresentor.super.ctor(self)
end

function AnnimatchFailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchFailViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchfailview.prefab"
	}
end

function AnnimatchFailViewPresentor:buildViews()
	return {
		AnnimatchwinView.New()
	}
end

return AnnimatchFailViewPresentor
