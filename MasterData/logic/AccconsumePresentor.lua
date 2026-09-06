-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/AccconsumePresentor.lua

module("logic.extensions.payshop.view.AccconsumePresentor", package.seeall)

local AccconsumePresentor = class("AccconsumePresentor", ViewPresentor)

function AccconsumePresentor:ctor()
	AccconsumePresentor.super.ctor(self)
end

function AccconsumePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AccconsumePresentor:dependWhatResources()
	return {
		"ui/views/payshop/accconsumeview.prefab"
	}
end

function AccconsumePresentor:buildViews()
	return {
		AccconsumeView.New()
	}
end

function AccconsumePresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AccconsumePresentor
