-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/view/AccumulategiftViewPresentor.lua

module("logic.extensions.accumulategift.view.AccumulategiftViewPresentor", package.seeall)

local AccumulategiftViewPresentor = class("AccumulategiftViewPresentor", ViewPresentor)

function AccumulategiftViewPresentor:ctor()
	AccumulategiftViewPresentor.super.ctor(self)
end

function AccumulategiftViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AccumulategiftViewPresentor:dependWhatResources()
	return {
		"ui/views/accumulategift/accumulategiftview.prefab"
	}
end

function AccumulategiftViewPresentor:buildViews()
	return {
		AccumulategiftView.New()
	}
end

return AccumulategiftViewPresentor
