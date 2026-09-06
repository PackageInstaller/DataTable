-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchReplaceViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchReplaceViewPresentor", package.seeall)

local AnnimatchReplaceViewPresentor = class("AnnimatchReplaceViewPresentor", ViewPresentor)

function AnnimatchReplaceViewPresentor:ctor()
	AnnimatchReplaceViewPresentor.super.ctor(self)
end

function AnnimatchReplaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchReplaceViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchreplaceview.prefab"
	}
end

function AnnimatchReplaceViewPresentor:buildViews()
	return {
		AnnimatchReplaceView.New()
	}
end

return AnnimatchReplaceViewPresentor
