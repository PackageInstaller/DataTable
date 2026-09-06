-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aixinmmplus/AiXinmmPlusMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.aixinmmplus.AiXinmmPlusMainViewPresentor", package.seeall)

local AiXinmmPlusMainViewPresentor = class("AiXinmmPlusMainViewPresentor", ViewPresentor)

function AiXinmmPlusMainViewPresentor:ctor()
	AiXinmmPlusMainViewPresentor.super.ctor(self)
end

function AiXinmmPlusMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AiXinmmPlusMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/aixinmmplus/aixinmmplusmainview.prefab"
	}
end

function AiXinmmPlusMainViewPresentor:buildViews()
	return {
		AiXinmmPlusMainView.New()
	}
end

return AiXinmmPlusMainViewPresentor
