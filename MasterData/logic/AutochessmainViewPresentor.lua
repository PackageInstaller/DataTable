-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessmainViewPresentor.lua

module("logic.extensions.autochess.view.AutochessmainViewPresentor", package.seeall)

local AutochessmainViewPresentor = class("AutochessmainViewPresentor", ViewPresentor)

function AutochessmainViewPresentor:ctor()
	AutochessmainViewPresentor.super.ctor(self)
end

function AutochessmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AutochessmainViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessmainview.prefab"
	}
end

function AutochessmainViewPresentor:buildViews()
	return {
		AutochessmainView.New()
	}
end

return AutochessmainViewPresentor
