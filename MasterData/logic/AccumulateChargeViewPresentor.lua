-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/view/AccumulateChargeViewPresentor.lua

module("logic.extensions.accumulatecharge.view.AccumulateChargeViewPresentor", package.seeall)

local AccumulateChargeViewPresentor = class("AccumulateChargeViewPresentor", ViewPresentor)

function AccumulateChargeViewPresentor:ctor()
	AccumulateChargeViewPresentor.super.ctor(self)
end

function AccumulateChargeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AccumulateChargeViewPresentor:dependWhatResources()
	return {
		"ui/views/accumulatecharge/accumulatechargeview.prefab"
	}
end

function AccumulateChargeViewPresentor:buildViews()
	return {
		AccumulateChargeView.New()
	}
end

return AccumulateChargeViewPresentor
