-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessplayertipsViewPresentor.lua

module("logic.extensions.autochess.view.AutochessplayertipsViewPresentor", package.seeall)

local AutochessplayertipsViewPresentor = class("AutochessplayertipsViewPresentor", ViewPresentor)

function AutochessplayertipsViewPresentor:ctor()
	AutochessplayertipsViewPresentor.super.ctor(self)
end

function AutochessplayertipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AutochessplayertipsViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessplayertips.prefab"
	}
end

function AutochessplayertipsViewPresentor:buildViews()
	return {
		AutochessplayertipsView.New()
	}
end

function AutochessplayertipsViewPresentor:setGrayMaskGO(grayMaskGO)
	AutochessplayertipsViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return AutochessplayertipsViewPresentor
