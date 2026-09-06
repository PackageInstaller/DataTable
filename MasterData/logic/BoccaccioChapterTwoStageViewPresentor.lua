-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterTwoStageViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterTwoStageViewPresentor", package.seeall)

local BoccaccioChapterTwoStageViewPresentor = class("BoccaccioChapterTwoStageViewPresentor", ViewPresentor)

function BoccaccioChapterTwoStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapterTwoStageViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochaptertwostageview.prefab"
	}
end

function BoccaccioChapterTwoStageViewPresentor:buildViews()
	return {
		BoccaccioChapterTwoStageView.New()
	}
end

return BoccaccioChapterTwoStageViewPresentor
