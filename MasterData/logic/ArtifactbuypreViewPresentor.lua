-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/saintknight/ArtifactbuypreViewPresentor.lua

module("logic.extensions.bonus.view.saintknight.ArtifactbuypreViewPresentor", package.seeall)

local ArtifactbuypreViewPresentor = class("ArtifactbuypreViewPresentor", ViewPresentor)

function ArtifactbuypreViewPresentor:ctor()
	ArtifactbuypreViewPresentor.super.ctor(self)
end

function ArtifactbuypreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArtifactbuypreViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/saintknight/artifactbuypreview.prefab"
	}
end

function ArtifactbuypreViewPresentor:buildViews()
	return {
		ArtifactbuypreView.New()
	}
end

return ArtifactbuypreViewPresentor
