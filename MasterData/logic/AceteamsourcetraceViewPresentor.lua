-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamsourcetraceViewPresentor.lua

module("logic.extensions.aceteam.view.petshow.AceteamsourcetraceViewPresentor", package.seeall)

local AceteamsourcetraceViewPresentor = class("AceteamsourcetraceViewPresentor", ViewPresentor)

function AceteamsourcetraceViewPresentor:ctor()
	AceteamsourcetraceViewPresentor.super.ctor(self)
end

function AceteamsourcetraceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamsourcetraceViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamsourcetraceview.prefab"
	}
end

function AceteamsourcetraceViewPresentor:buildViews()
	return {
		AceteamsourcetraceView.New()
	}
end

function AceteamsourcetraceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteamsourcetraceViewPresentor
