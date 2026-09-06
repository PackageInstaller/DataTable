-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamruleViewPresentor.lua

module("logic.extensions.aceteam.view.AceteamruleViewPresentor", package.seeall)

local AceteamruleViewPresentor = class("AceteamruleViewPresentor", ViewPresentor)

function AceteamruleViewPresentor:ctor()
	AceteamruleViewPresentor.super.ctor(self)
end

function AceteamruleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AceteamruleViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamruleview.prefab"
	}
end

function AceteamruleViewPresentor:buildViews()
	return {
		AceteamruleView.New()
	}
end

return AceteamruleViewPresentor
