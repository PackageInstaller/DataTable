-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterStoryViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterStoryViewPresentor", package.seeall)

local BoccaccioChapterStoryViewPresentor = class("BoccaccioChapterStoryViewPresentor", ViewPresentor)

function BoccaccioChapterStoryViewPresentor:ctor()
	BoccaccioChapterStoryViewPresentor.super.ctor(self)
end

function BoccaccioChapterStoryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapterStoryViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochapterstoryview.prefab"
	}
end

function BoccaccioChapterStoryViewPresentor:buildViews()
	return {
		BoccaccioChapterStoryView.New()
	}
end

return BoccaccioChapterStoryViewPresentor
