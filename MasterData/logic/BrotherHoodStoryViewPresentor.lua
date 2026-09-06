-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brotherhood/view/BrotherHoodStoryViewPresentor.lua

module("logic.extensions.brotherhood.view.BrotherHoodStoryViewPresentor", package.seeall)

local BrotherHoodStoryViewPresentor = class("BrotherHoodStoryViewPresentor", ViewPresentor)

function BrotherHoodStoryViewPresentor:ctor()
	BrotherHoodStoryViewPresentor.super.ctor(self)
end

function BrotherHoodStoryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherHoodStoryViewPresentor:dependWhatResources()
	return {
		"ui/views/brotherhood/brotherhoodstoryview.prefab"
	}
end

function BrotherHoodStoryViewPresentor:buildViews()
	return {
		BrotherHoodStoryView.New()
	}
end

return BrotherHoodStoryViewPresentor
