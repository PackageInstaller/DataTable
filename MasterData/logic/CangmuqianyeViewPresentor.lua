-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/CangmuqianyeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.CangmuqianyeViewPresentor", package.seeall)

local CangmuqianyeViewPresentor = class("CangmuqianyeViewPresentor", ViewPresentor)

function CangmuqianyeViewPresentor:ctor()
	CangmuqianyeViewPresentor.super.ctor(self)
end

function CangmuqianyeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CangmuqianyeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/tianmanking/cangmuqianyeview.prefab"
	}
end

function CangmuqianyeViewPresentor:buildViews()
	return {
		CangmuqianyeView.New()
	}
end

return CangmuqianyeViewPresentor
