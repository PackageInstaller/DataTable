-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterTwoMainViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterTwoMainViewPresentor", package.seeall)

local BoccaccioChapterTwoMainViewPresentor = class("BoccaccioChapterTwoMainViewPresentor", ViewPresentor)

function BoccaccioChapterTwoMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapterTwoMainViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochaptertwomainview.prefab"
	}
end

function BoccaccioChapterTwoMainViewPresentor:buildViews()
	return {
		BoccaccioChapterTwoMainView.New()
	}
end

return BoccaccioChapterTwoMainViewPresentor
