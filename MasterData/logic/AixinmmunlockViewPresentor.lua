-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmunlockViewPresentor.lua

module("logic.extensions.aixinmm.view.AixinmmunlockViewPresentor", package.seeall)

local AixinmmunlockViewPresentor = class("AixinmmunlockViewPresentor", ViewPresentor)

function AixinmmunlockViewPresentor:ctor()
	AixinmmunlockViewPresentor.super.ctor(self)
end

function AixinmmunlockViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AixinmmunlockViewPresentor:dependWhatResources()
	return {
		"ui/views/aixinmm/aixinmmunlockview.prefab"
	}
end

function AixinmmunlockViewPresentor:buildViews()
	return {
		AixinmmunlockView.New()
	}
end

return AixinmmunlockViewPresentor
