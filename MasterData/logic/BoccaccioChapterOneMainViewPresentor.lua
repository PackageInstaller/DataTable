-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterOneMainViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterOneMainViewPresentor", package.seeall)

local BoccaccioChapterOneMainViewPresentor = class("BoccaccioChapterOneMainViewPresentor", ViewPresentor)

function BoccaccioChapterOneMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapterOneMainViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochapteronemainview.prefab"
	}
end

function BoccaccioChapterOneMainViewPresentor:buildViews()
	return {
		BoccaccioChapterOneMainView.New()
	}
end

return BoccaccioChapterOneMainViewPresentor
