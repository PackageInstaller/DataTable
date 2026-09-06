-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteammemberViewPresentor.lua

module("logic.extensions.aceteam.view.AceteammemberViewPresentor", package.seeall)

local AceteammemberViewPresentor = class("AceteammemberViewPresentor", ViewPresentor)

function AceteammemberViewPresentor:ctor()
	AceteammemberViewPresentor.super.ctor(self)
end

function AceteammemberViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AceteammemberViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteammemberview.prefab"
	}
end

function AceteammemberViewPresentor:buildViews()
	return {
		AceteammemberView.New()
	}
end

return AceteammemberViewPresentor
