-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/binglingwang/BinglingwangmainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.binglingwang.BinglingwangmainViewPresentor", package.seeall)

local BinglingwangmainViewPresentor = class("BinglingwangmainViewPresentor", ViewPresentor)

function BinglingwangmainViewPresentor:ctor()
	BinglingwangmainViewPresentor.super.ctor(self)
end

function BinglingwangmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BinglingwangmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/binglingwang/binglingwangmainview.prefab"
	}
end

function BinglingwangmainViewPresentor:buildViews()
	return {
		BinglingwangmainView.New()
	}
end

return BinglingwangmainViewPresentor
