-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter4MainViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter4MainViewPresentor", package.seeall)

local BoccaccioChapter4MainViewPresentor = class("BoccaccioChapter4MainViewPresentor", ViewPresentor)

function BoccaccioChapter4MainViewPresentor:ctor()
	BoccaccioChapter4MainViewPresentor.super.ctor(self)
end

function BoccaccioChapter4MainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapter4MainViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochapter4mainview.prefab"
	}
end

function BoccaccioChapter4MainViewPresentor:buildViews()
	return {
		BoccaccioChapter4MainView.New()
	}
end

return BoccaccioChapter4MainViewPresentor
