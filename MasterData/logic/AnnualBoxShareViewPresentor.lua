-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualbox/view/AnnualBoxShareViewPresentor.lua

module("logic.extensions.annualbox.view.AnnualBoxShareViewPresentor", package.seeall)

local AnnualBoxShareViewPresentor = class("AnnualBoxShareViewPresentor", ViewPresentor)

function AnnualBoxShareViewPresentor:ctor()
	AnnualBoxShareViewPresentor.super.ctor(self)
end

function AnnualBoxShareViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnnualBoxShareViewPresentor:dependWhatResources()
	return {
		"ui/views/annualbox/annualboxshareview.prefab"
	}
end

function AnnualBoxShareViewPresentor:buildViews()
	return {
		AnnualBoxShareView.New()
	}
end

function AnnualBoxShareViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AnnualBoxShareViewPresentor
