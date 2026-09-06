-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmtipsViewPresentor.lua

module("logic.extensions.aixinmm.view.AixinmmtipsViewPresentor", package.seeall)

local AixinmmtipsViewPresentor = class("AixinmmtipsViewPresentor", ViewPresentor)

function AixinmmtipsViewPresentor:ctor()
	AixinmmtipsViewPresentor.super.ctor(self)
end

function AixinmmtipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AixinmmtipsViewPresentor:dependWhatResources()
	return {
		"ui/views/aixinmm/aixinmmtipsview.prefab"
	}
end

function AixinmmtipsViewPresentor:buildViews()
	return {
		AixinmmtipsView.New()
	}
end

function AixinmmtipsViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return AixinmmtipsViewPresentor
