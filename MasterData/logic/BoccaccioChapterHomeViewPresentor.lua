-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterHomeViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterHomeViewPresentor", package.seeall)

local BoccaccioChapterHomeViewPresentor = class("BoccaccioChapterHomeViewPresentor", ViewPresentor)

function BoccaccioChapterHomeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapterHomeViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochapterhomeview.prefab"
	}
end

function BoccaccioChapterHomeViewPresentor:buildViews()
	return {
		BoccaccioChapterHomeView.New()
	}
end

return BoccaccioChapterHomeViewPresentor
