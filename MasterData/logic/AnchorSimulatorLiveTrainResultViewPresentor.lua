-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorLiveTrainResultViewPresentor.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorLiveTrainResultViewPresentor", package.seeall)

local AnchorSimulatorLiveTrainResultViewPresentor = class("AnchorSimulatorLiveTrainResultViewPresentor", ViewPresentor)

function AnchorSimulatorLiveTrainResultViewPresentor:ctor()
	AnchorSimulatorLiveTrainResultViewPresentor.super.ctor(self)
end

function AnchorSimulatorLiveTrainResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnchorSimulatorLiveTrainResultViewPresentor:dependWhatResources()
	return {
		"ui/views/anchorsimulator/anchorsimulatorlivetrainresultview.prefab"
	}
end

function AnchorSimulatorLiveTrainResultViewPresentor:buildViews()
	return {
		AnchorSimulatorLiveTrainResultView.New()
	}
end

return AnchorSimulatorLiveTrainResultViewPresentor
