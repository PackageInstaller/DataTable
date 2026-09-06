-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteambuyscoreViewPresentor.lua

module("logic.extensions.aceteam.view.AceteambuyscoreViewPresentor", package.seeall)

local AceteambuyscoreViewPresentor = class("AceteambuyscoreViewPresentor", ViewPresentor)

function AceteambuyscoreViewPresentor:ctor()
	AceteambuyscoreViewPresentor.super.ctor(self)
end

function AceteambuyscoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteambuyscoreViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteambuyscoreview.prefab"
	}
end

function AceteambuyscoreViewPresentor:buildViews()
	return {
		AceteambuyscoreView.New()
	}
end

return AceteambuyscoreViewPresentor
