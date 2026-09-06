-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorRankViewPresentor.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorRankViewPresentor", package.seeall)

local AnchorSimulatorRankViewPresentor = class("AnchorSimulatorRankViewPresentor", ViewPresentor)

function AnchorSimulatorRankViewPresentor:ctor()
	AnchorSimulatorRankViewPresentor.super.ctor(self)
end

function AnchorSimulatorRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnchorSimulatorRankViewPresentor:dependWhatResources()
	return {
		"ui/views/anchorsimulator/anchorsimulatorrankview.prefab"
	}
end

function AnchorSimulatorRankViewPresentor:buildViews()
	return {
		AnchorSimulatorRankView.New()
	}
end

return AnchorSimulatorRankViewPresentor
