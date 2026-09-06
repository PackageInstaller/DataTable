-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchmainViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchmainViewPresentor", package.seeall)

local AnnimatchmainViewPresentor = class("AnnimatchmainViewPresentor", ViewPresentor)

function AnnimatchmainViewPresentor:ctor()
	AnnimatchmainViewPresentor.super.ctor(self)
end

function AnnimatchmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchmainViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchmainview.prefab"
	}
end

function AnnimatchmainViewPresentor:buildViews()
	return {
		AnnimatchmainView.New()
	}
end

return AnnimatchmainViewPresentor
