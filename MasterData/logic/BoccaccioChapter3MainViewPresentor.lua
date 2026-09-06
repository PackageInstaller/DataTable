-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter3MainViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter3MainViewPresentor", package.seeall)

local BoccaccioChapter3MainViewPresentor = class("BoccaccioChapter3MainViewPresentor", ViewPresentor)

function BoccaccioChapter3MainViewPresentor:ctor()
	BoccaccioChapter3MainViewPresentor.super.ctor(self)
end

function BoccaccioChapter3MainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapter3MainViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochapter3mainview.prefab"
	}
end

function BoccaccioChapter3MainViewPresentor:buildViews()
	return {
		BoccaccioChapter3MainView.New()
	}
end

return BoccaccioChapter3MainViewPresentor
