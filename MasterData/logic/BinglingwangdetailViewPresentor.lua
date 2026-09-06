-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/binglingwang/BinglingwangdetailViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.binglingwang.BinglingwangdetailViewPresentor", package.seeall)

local BinglingwangdetailViewPresentor = class("BinglingwangdetailViewPresentor", ViewPresentor)

function BinglingwangdetailViewPresentor:ctor()
	BinglingwangdetailViewPresentor.super.ctor(self)
end

function BinglingwangdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BinglingwangdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/binglingwang/binglingwangdetailview.prefab"
	}
end

function BinglingwangdetailViewPresentor:buildViews()
	return {
		BinglingwangdetailView.New()
	}
end

return BinglingwangdetailViewPresentor
