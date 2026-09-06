-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxprizeViewPresentor.lua

module("logic.extensions.assistancebox.view.AssistanceboxprizeViewPresentor", package.seeall)

local AssistanceboxprizeViewPresentor = class("AssistanceboxprizeViewPresentor", ViewPresentor)

function AssistanceboxprizeViewPresentor:ctor()
	AssistanceboxprizeViewPresentor.super.ctor(self)
end

function AssistanceboxprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AssistanceboxprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/assistancebox/assistanceboxprizeview.prefab"
	}
end

function AssistanceboxprizeViewPresentor:buildViews()
	return {
		AssistanceboxprizeView.New()
	}
end

function AssistanceboxprizeViewPresentor:onClickOutside()
	self:close()
end

return AssistanceboxprizeViewPresentor
