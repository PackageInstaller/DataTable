-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteammainViewPresentor.lua

module("logic.extensions.aceteam.view.AceteammainViewPresentor", package.seeall)

local AceteammainViewPresentor = class("AceteammainViewPresentor", ViewPresentor)

function AceteammainViewPresentor:ctor()
	AceteammainViewPresentor.super.ctor(self)
end

function AceteammainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteammainViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteammainview.prefab"
	}
end

function AceteammainViewPresentor:buildViews()
	return {
		AceteammainView.New()
	}
end

function AceteammainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteammainViewPresentor
