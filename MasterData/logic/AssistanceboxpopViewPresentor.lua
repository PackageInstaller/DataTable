-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxpopViewPresentor.lua

module("logic.extensions.assistancebox.view.AssistanceboxpopViewPresentor", package.seeall)

local AssistanceboxpopViewPresentor = class("AssistanceboxpopViewPresentor", ViewPresentor)

function AssistanceboxpopViewPresentor:ctor()
	AssistanceboxpopViewPresentor.super.ctor(self)
end

function AssistanceboxpopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AssistanceboxpopViewPresentor:dependWhatResources()
	return {
		"ui/views/assistancebox/assistanceboxpopview.prefab"
	}
end

function AssistanceboxpopViewPresentor:buildViews()
	return {
		AssistanceboxpopView.New()
	}
end

return AssistanceboxpopViewPresentor
