-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamHolyStripeTipViewPresentor.lua

module("logic.extensions.aceteam.view.petshow.AceteamHolyStripeTipViewPresentor", package.seeall)

local AceteamHolyStripeTipViewPresentor = class("AceteamHolyStripeTipViewPresentor", ViewPresentor)

function AceteamHolyStripeTipViewPresentor:ctor()
	AceteamHolyStripeTipViewPresentor.super.ctor(self)
end

function AceteamHolyStripeTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AceteamHolyStripeTipViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamholystripetipview.prefab"
	}
end

function AceteamHolyStripeTipViewPresentor:buildViews()
	return {
		AceteamHolyStripeTipView.New()
	}
end

function AceteamHolyStripeTipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteamHolyStripeTipViewPresentor
