-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorMainViewPresentor.lua

module("logic.extensions.ashlesslongyan.view.AnchorSimulatorMainViewPresentor", package.seeall)

local AnchorSimulatorMainViewPresentor = class("AnchorSimulatorMainViewPresentor", ViewPresentor)

function AnchorSimulatorMainViewPresentor:ctor()
	AnchorSimulatorMainViewPresentor.super.ctor(self)
end

function AnchorSimulatorMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnchorSimulatorMainViewPresentor:dependWhatResources()
	return {
		"ui/views/anchorsimulator/anchorsimulatormainview.prefab"
	}
end

function AnchorSimulatorMainViewPresentor:buildViews()
	return {
		AnchorSimulatorMainView.New()
	}
end

return AnchorSimulatorMainViewPresentor
