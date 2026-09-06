-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteampetskillViewPresentor.lua

module("logic.extensions.aceteam.view.petshow.AceteampetskillViewPresentor", package.seeall)

local AceteampetskillViewPresentor = class("AceteampetskillViewPresentor", ViewPresentor)

function AceteampetskillViewPresentor:ctor()
	AceteampetskillViewPresentor.super.ctor(self)
end

function AceteampetskillViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteampetskillViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteampetskillview.prefab"
	}
end

function AceteampetskillViewPresentor:buildViews()
	return {
		AceteampetskillView.New()
	}
end

function AceteampetskillViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteampetskillViewPresentor
