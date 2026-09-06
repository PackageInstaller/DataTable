-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessmissionViewPresentor.lua

module("logic.extensions.autochess.view.AutochessmissionViewPresentor", package.seeall)

local AutochessmissionViewPresentor = class("AutochessmissionViewPresentor", ViewPresentor)

AutochessmissionViewPresentor.Aotuchessmissionextview = "ui/views/autochess/autochessmissionextview.prefab"

function AutochessmissionViewPresentor:ctor()
	AutochessmissionViewPresentor.super.ctor(self)
end

function AutochessmissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AutochessmissionViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessmissionview.prefab",
		AutochessmissionViewPresentor.Aotuchessmissionextview
	}
end

function AutochessmissionViewPresentor:buildViews()
	return {
		AutochessmissionView.New(),
		AutochessFmtRightView.New(),
		AutochessFmtLeftView.New()
	}
end

return AutochessmissionViewPresentor
