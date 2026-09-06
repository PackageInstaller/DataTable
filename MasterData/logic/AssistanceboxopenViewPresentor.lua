-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxopenViewPresentor.lua

module("logic.extensions.assistancebox.view.AssistanceboxopenViewPresentor", package.seeall)

local AssistanceboxopenViewPresentor = class("AssistanceboxopenViewPresentor", ViewPresentor)

function AssistanceboxopenViewPresentor:ctor()
	AssistanceboxopenViewPresentor.super.ctor(self)
end

function AssistanceboxopenViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AssistanceboxopenViewPresentor:dependWhatResources()
	return {
		"ui/views/assistancebox/assistanceboxopenview.prefab"
	}
end

function AssistanceboxopenViewPresentor:buildViews()
	return {
		AssistanceboxopenView.New()
	}
end

return AssistanceboxopenViewPresentor
