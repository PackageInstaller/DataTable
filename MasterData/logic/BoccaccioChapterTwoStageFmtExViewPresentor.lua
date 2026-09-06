-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterTwoStageFmtExViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterTwoStageFmtExViewPresentor", package.seeall)

local BoccaccioChapterTwoStageFmtExViewPresentor = class("BoccaccioChapterTwoStageFmtExViewPresentor", ViewPresentor)

function BoccaccioChapterTwoStageFmtExViewPresentor:ctor()
	BoccaccioChapterTwoStageFmtExViewPresentor.super.ctor(self)
end

function BoccaccioChapterTwoStageFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapterTwoStageFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochaptertwostagefmtexview.prefab"
	}
end

function BoccaccioChapterTwoStageFmtExViewPresentor:buildViews()
	return {
		BoccaccioChapterTwoStageFmtExView.New()
	}
end

function BoccaccioChapterTwoStageFmtExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return BoccaccioChapterTwoStageFmtExViewPresentor
