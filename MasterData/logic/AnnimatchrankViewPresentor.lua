-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchrankViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchrankViewPresentor", package.seeall)

local AnnimatchrankViewPresentor = class("AnnimatchrankViewPresentor", ViewPresentor)

function AnnimatchrankViewPresentor:ctor()
	AnnimatchrankViewPresentor.super.ctor(self)
end

function AnnimatchrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchrankViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchrankview.prefab"
	}
end

function AnnimatchrankViewPresentor:buildViews()
	return {
		AnnimatchrankView.New()
	}
end

return AnnimatchrankViewPresentor
