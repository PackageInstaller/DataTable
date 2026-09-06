-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomMainViewPresentor.lua

module("logic.extensions.aresmom.view.AresMomMainViewPresentor", package.seeall)

local AresMomMainViewPresentor = class("AresMomMainViewPresentor", ViewPresentor)

function AresMomMainViewPresentor:ctor()
	AresMomMainViewPresentor.super.ctor(self)
end

function AresMomMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AresMomMainViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/aresmommainview.prefab"
	}
end

function AresMomMainViewPresentor:buildViews()
	return {
		AresMomMainView.New()
	}
end

return AresMomMainViewPresentor
