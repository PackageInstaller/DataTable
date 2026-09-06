-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessmatchViewPresentor.lua

module("logic.extensions.autochess.view.AutochessmatchViewPresentor", package.seeall)

local AutochessmatchViewPresentor = class("AutochessmatchViewPresentor", ViewPresentor)

function AutochessmatchViewPresentor:ctor()
	AutochessmatchViewPresentor.super.ctor(self)
end

function AutochessmatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AutochessmatchViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessmatchview.prefab"
	}
end

function AutochessmatchViewPresentor:buildViews()
	return {
		AutochessmatchView.New()
	}
end

return AutochessmatchViewPresentor
