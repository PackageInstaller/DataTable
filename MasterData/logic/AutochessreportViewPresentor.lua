-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessreportViewPresentor.lua

module("logic.extensions.autochess.view.AutochessreportViewPresentor", package.seeall)

local AutochessreportViewPresentor = class("AutochessreportViewPresentor", ViewPresentor)

function AutochessreportViewPresentor:ctor()
	AutochessreportViewPresentor.super.ctor(self)
end

function AutochessreportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AutochessreportViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessreportview.prefab"
	}
end

function AutochessreportViewPresentor:buildViews()
	return {
		AutochessreportView.New()
	}
end

return AutochessreportViewPresentor
