-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomPrizeViewPresentor.lua

module("logic.extensions.aresmom.view.AresMomPrizeViewPresentor", package.seeall)

local AresMomPrizeViewPresentor = class("AresMomPrizeViewPresentor", ViewPresentor)

function AresMomPrizeViewPresentor:ctor()
	AresMomPrizeViewPresentor.super.ctor(self)
end

function AresMomPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AresMomPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/aresmomprizeview.prefab"
	}
end

function AresMomPrizeViewPresentor:buildViews()
	return {
		AresMomPrizeView.New()
	}
end

return AresMomPrizeViewPresentor
