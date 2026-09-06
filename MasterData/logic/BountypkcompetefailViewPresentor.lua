-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompetefailViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompetefailViewPresentor", package.seeall)

local BountypkcompetefailViewPresentor = class("BountypkcompetefailViewPresentor", ViewPresentor)

function BountypkcompetefailViewPresentor:ctor()
	BountypkcompetefailViewPresentor.super.ctor(self)
end

function BountypkcompetefailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BountypkcompetefailViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompetefailview.prefab"
	}
end

function BountypkcompetefailViewPresentor:buildViews()
	return {
		BountyPKCompeteFailView.New()
	}
end

return BountypkcompetefailViewPresentor
