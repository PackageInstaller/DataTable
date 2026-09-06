-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter4RankViewPresentor.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter4RankViewPresentor", package.seeall)

local BoccaccioChapter4RankViewPresentor = class("BoccaccioChapter4RankViewPresentor", ViewPresentor)

function BoccaccioChapter4RankViewPresentor:ctor()
	BoccaccioChapter4RankViewPresentor.super.ctor(self)
end

function BoccaccioChapter4RankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioChapter4RankViewPresentor:dependWhatResources()
	return {
		"ui/views/boccacciochapter/boccacciochapter4rankview.prefab"
	}
end

function BoccaccioChapter4RankViewPresentor:buildViews()
	return {
		BoccaccioChapter4RankView.New()
	}
end

return BoccaccioChapter4RankViewPresentor
