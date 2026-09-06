-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorLiveTrainMainViewPresentor.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorLiveTrainMainViewPresentor", package.seeall)

local AnchorSimulatorLiveTrainMainViewPresentor = class("AnchorSimulatorLiveTrainMainViewPresentor", ViewPresentor)

function AnchorSimulatorLiveTrainMainViewPresentor:ctor()
	AnchorSimulatorLiveTrainMainViewPresentor.super.ctor(self)
end

function AnchorSimulatorLiveTrainMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnchorSimulatorLiveTrainMainViewPresentor:dependWhatResources()
	return {
		"ui/views/anchorsimulator/anchorsimulatorlivetrainmainview.prefab"
	}
end

function AnchorSimulatorLiveTrainMainViewPresentor:buildViews()
	return {
		AnchorSimulatorLiveTrainMainView.New()
	}
end

return AnchorSimulatorLiveTrainMainViewPresentor
