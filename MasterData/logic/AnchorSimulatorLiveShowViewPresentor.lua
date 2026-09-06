-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorLiveShowViewPresentor.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorLiveShowViewPresentor", package.seeall)

local AnchorSimulatorLiveShowViewPresentor = class("AnchorSimulatorLiveShowViewPresentor", ViewPresentor)

function AnchorSimulatorLiveShowViewPresentor:ctor()
	AnchorSimulatorLiveShowViewPresentor.super.ctor(self)
end

function AnchorSimulatorLiveShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnchorSimulatorLiveShowViewPresentor:dependWhatResources()
	return {
		"ui/views/anchorsimulator/anchorsimulatorliveshowview.prefab"
	}
end

function AnchorSimulatorLiveShowViewPresentor:buildViews()
	return {
		AnchorSimulatorLiveShowView.New()
	}
end

return AnchorSimulatorLiveShowViewPresentor
