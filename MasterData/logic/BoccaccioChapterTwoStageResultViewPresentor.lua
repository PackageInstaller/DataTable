-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterTwoStageResultViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterTwoStageResultViewPresentor", package.seeall)

local BoccaccioChapterTwoStageResultViewPresentor = class("BoccaccioChapterTwoStageResultViewPresentor", ViewPresentor)

function BoccaccioChapterTwoStageResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BoccaccioChapterTwoStageResultViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochaptertwostageresultview.prefab"
	}
end

function BoccaccioChapterTwoStageResultViewPresentor:buildViews()
	return {
		BoccaccioChapterTwoStageResultView.New()
	}
end

return BoccaccioChapterTwoStageResultViewPresentor
