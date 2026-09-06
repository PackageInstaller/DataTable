-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aixinmmplus/AiXinmmPlusLevelViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.aixinmmplus.AiXinmmPlusLevelViewPresentor", package.seeall)

local AiXinmmPlusLevelViewPresentor = class("AiXinmmPlusLevelViewPresentor", ViewPresentor)

function AiXinmmPlusLevelViewPresentor:ctor()
	AiXinmmPlusLevelViewPresentor.super.ctor(self)
end

function AiXinmmPlusLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AiXinmmPlusLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/aixinmmplus/aixinmmpluslevelview.prefab"
	}
end

function AiXinmmPlusLevelViewPresentor:buildViews()
	return {
		AiXinmmPlusLevelView.New()
	}
end

return AiXinmmPlusLevelViewPresentor
