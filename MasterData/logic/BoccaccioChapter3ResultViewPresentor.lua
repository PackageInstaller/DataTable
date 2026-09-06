-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter3ResultViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter3ResultViewPresentor", package.seeall)

local BoccaccioChapter3ResultViewPresentor = class("BoccaccioChapter3ResultViewPresentor", ViewPresentor)

function BoccaccioChapter3ResultViewPresentor:ctor()
	BoccaccioChapter3ResultViewPresentor.super.ctor(self)
end

function BoccaccioChapter3ResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapter3ResultViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochapter3resultview.prefab"
	}
end

function BoccaccioChapter3ResultViewPresentor:buildViews()
	return {
		BoccaccioChapter3ResultView.New()
	}
end

return BoccaccioChapter3ResultViewPresentor
