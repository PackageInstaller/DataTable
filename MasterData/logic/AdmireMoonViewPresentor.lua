-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/admiremoon/view/AdmireMoonViewPresentor.lua

module("logic.extensions.admiremoon.view.AdmireMoonViewPresentor", package.seeall)

local AdmireMoonViewPresentor = class("AdmireMoonViewPresentor", ViewPresentor)

function AdmireMoonViewPresentor:ctor()
	AdmireMoonViewPresentor.super.ctor(self)
end

function AdmireMoonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AdmireMoonViewPresentor:dependWhatResources()
	return {
		"ui/views/admiremoon/admiremoonview.prefab"
	}
end

function AdmireMoonViewPresentor:buildViews()
	return {
		AdmireMoonView.New()
	}
end

return AdmireMoonViewPresentor
