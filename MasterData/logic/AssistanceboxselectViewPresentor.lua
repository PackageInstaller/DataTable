-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxselectViewPresentor.lua

module("logic.extensions.assistancebox.view.AssistanceboxselectViewPresentor", package.seeall)

local AssistanceboxselectViewPresentor = class("AssistanceboxselectViewPresentor", ViewPresentor)

function AssistanceboxselectViewPresentor:ctor()
	AssistanceboxselectViewPresentor.super.ctor(self)
end

function AssistanceboxselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AssistanceboxselectViewPresentor:dependWhatResources()
	return {
		"ui/views/assistancebox/assistanceboxselectview.prefab"
	}
end

function AssistanceboxselectViewPresentor:buildViews()
	return {
		AssistanceboxselectView.New()
	}
end

return AssistanceboxselectViewPresentor
