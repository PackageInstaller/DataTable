-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxViewPresentor.lua

module("logic.extensions.assistancebox.view.AssistanceboxViewPresentor", package.seeall)

local AssistanceboxViewPresentor = class("AssistanceboxViewPresentor", ViewPresentor)

function AssistanceboxViewPresentor:ctor()
	AssistanceboxViewPresentor.super.ctor(self)
end

function AssistanceboxViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AssistanceboxViewPresentor:dependWhatResources()
	return {
		"ui/views/assistancebox/assistanceboxview.prefab"
	}
end

function AssistanceboxViewPresentor:buildViews()
	return {
		AssistanceboxView.New()
	}
end

return AssistanceboxViewPresentor
