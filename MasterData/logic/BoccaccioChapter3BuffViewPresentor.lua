-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter3BuffViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter3BuffViewPresentor", package.seeall)

local BoccaccioChapter3BuffViewPresentor = class("BoccaccioChapter3BuffViewPresentor", ViewPresentor)

function BoccaccioChapter3BuffViewPresentor:ctor()
	BoccaccioChapter3BuffViewPresentor.super.ctor(self)
end

function BoccaccioChapter3BuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapter3BuffViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochapter3buffview.prefab"
	}
end

function BoccaccioChapter3BuffViewPresentor:buildViews()
	return {
		BoccaccioChapter3BuffView.New()
	}
end

return BoccaccioChapter3BuffViewPresentor
