-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxlistViewPresentor.lua

module("logic.extensions.assistancebox.view.AssistanceboxlistViewPresentor", package.seeall)

local AssistanceboxlistViewPresentor = class("AssistanceboxlistViewPresentor", ViewPresentor)

function AssistanceboxlistViewPresentor:ctor()
	AssistanceboxlistViewPresentor.super.ctor(self)
end

function AssistanceboxlistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AssistanceboxlistViewPresentor:dependWhatResources()
	return {
		"ui/views/assistancebox/assistanceboxlistview.prefab"
	}
end

function AssistanceboxlistViewPresentor:buildViews()
	return {
		AssistanceboxlistView.New()
	}
end

return AssistanceboxlistViewPresentor
