-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/BufftipsViewPresentor.lua

module("logic.extensions.common.view.BufftipsViewPresentor", package.seeall)

local BufftipsViewPresentor = class("BufftipsViewPresentor", ViewPresentor)

function BufftipsViewPresentor:ctor()
	BufftipsViewPresentor.super.ctor(self)
end

function BufftipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function BufftipsViewPresentor:dependWhatResources()
	return {
		"ui/views/common/bufftipsview.prefab"
	}
end

function BufftipsViewPresentor:buildViews()
	return {
		BufftipsView.New()
	}
end

return BufftipsViewPresentor
