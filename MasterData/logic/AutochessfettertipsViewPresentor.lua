-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessfettertipsViewPresentor.lua

module("logic.extensions.autochess.view.AutochessfettertipsViewPresentor", package.seeall)

local AutochessfettertipsViewPresentor = class("AutochessfettertipsViewPresentor", ViewPresentor)

function AutochessfettertipsViewPresentor:ctor()
	AutochessfettertipsViewPresentor.super.ctor(self)
end

function AutochessfettertipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AutochessfettertipsViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessfettertips.prefab"
	}
end

function AutochessfettertipsViewPresentor:buildViews()
	return {
		AutochessfettertipsView.New()
	}
end

function AutochessfettertipsViewPresentor:setGrayMaskGO(grayMaskGO)
	AutochessfettertipsViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return AutochessfettertipsViewPresentor
