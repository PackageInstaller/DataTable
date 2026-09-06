-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annuityprivilege/view/AnnuityPrivilegeTipsViewPresentor.lua

module("logic.extensions.annuityprivilege.view.AnnuityPrivilegeTipsViewPresentor", package.seeall)

local AnnuityPrivilegeTipsViewPresentor = class("AnnuityPrivilegeTipsViewPresentor", ViewPresentor)

function AnnuityPrivilegeTipsViewPresentor:ctor()
	AnnuityPrivilegeTipsViewPresentor.super.ctor(self)
end

function AnnuityPrivilegeTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnnuityPrivilegeTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/annuityprivilege/annuityprivilegetipsview.prefab"
	}
end

function AnnuityPrivilegeTipsViewPresentor:buildViews()
	return {
		AnnuityPrivilegeTipsView.New()
	}
end

function AnnuityPrivilegeTipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AnnuityPrivilegeTipsViewPresentor
