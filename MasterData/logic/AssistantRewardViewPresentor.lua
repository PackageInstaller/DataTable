-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/AssistantRewardViewPresentor.lua

module("logic.extensions.xiaonuoassistant.view.AssistantRewardViewPresentor", package.seeall)

local AssistantRewardViewPresentor = class("AssistantRewardViewPresentor", ViewPresentor)

function AssistantRewardViewPresentor:ctor()
	AssistantRewardViewPresentor.super.ctor(self)
end

function AssistantRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AssistantRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/xiaonuoassistant/assistantrewardview.prefab"
	}
end

function AssistantRewardViewPresentor:buildViews()
	return {
		AssistantRewardView.New()
	}
end

return AssistantRewardViewPresentor
