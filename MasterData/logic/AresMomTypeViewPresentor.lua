-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomTypeViewPresentor.lua

module("logic.extensions.aresmom.view.AresMomTypeViewPresentor", package.seeall)

local AresMomTypeViewPresentor = class("AresMomTypeViewPresentor", ViewPresentor)

function AresMomTypeViewPresentor:ctor()
	AresMomTypeViewPresentor.super.ctor(self)
end

function AresMomTypeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AresMomTypeViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/aresmomtypeview.prefab"
	}
end

function AresMomTypeViewPresentor:buildViews()
	return {
		AresMomTypeView.New()
	}
end

return AresMomTypeViewPresentor
