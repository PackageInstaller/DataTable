-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aixinmmplus/AiXinmmPlusGameViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.aixinmmplus.AiXinmmPlusGameViewPresentor", package.seeall)

local AiXinmmPlusGameViewPresentor = class("AiXinmmPlusGameViewPresentor", ViewPresentor)

function AiXinmmPlusGameViewPresentor:ctor()
	AiXinmmPlusGameViewPresentor.super.ctor(self)
end

function AiXinmmPlusGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AiXinmmPlusGameViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/aixinmmplus/aixinmmplusgameview.prefab"
	}
end

function AiXinmmPlusGameViewPresentor:buildViews()
	return {
		AiXinmmPlusGameView.New()
	}
end

return AiXinmmPlusGameViewPresentor
