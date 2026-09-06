-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorLiveReadyViewPresentor.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorLiveReadyViewPresentor", package.seeall)

local AnchorSimulatorLiveReadyViewPresentor = class("AnchorSimulatorLiveReadyViewPresentor", ViewPresentor)

function AnchorSimulatorLiveReadyViewPresentor:ctor()
	AnchorSimulatorLiveReadyViewPresentor.super.ctor(self)
end

function AnchorSimulatorLiveReadyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnchorSimulatorLiveReadyViewPresentor:dependWhatResources()
	return {
		"ui/views/anchorsimulator/anchorsimulatorlivereadyview.prefab"
	}
end

function AnchorSimulatorLiveReadyViewPresentor:buildViews()
	return {
		AnchorSimulatorLiveReadyView.New()
	}
end

return AnchorSimulatorLiveReadyViewPresentor
