-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessbuffshowViewPresentor.lua

module("logic.extensions.autochess.view.AutochessbuffshowViewPresentor", package.seeall)

local AutochessbuffshowViewPresentor = class("AutochessbuffshowViewPresentor", ViewPresentor)

function AutochessbuffshowViewPresentor:ctor()
	AutochessbuffshowViewPresentor.super.ctor(self)
end

function AutochessbuffshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AutochessbuffshowViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessbuffshowview.prefab"
	}
end

function AutochessbuffshowViewPresentor:buildViews()
	return {
		AutochessbuffshowView.New()
	}
end

return AutochessbuffshowViewPresentor
