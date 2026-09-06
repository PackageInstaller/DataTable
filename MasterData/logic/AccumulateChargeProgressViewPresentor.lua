-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/view/AccumulateChargeProgressViewPresentor.lua

module("logic.extensions.accumulatecharge.view.AccumulateChargeProgressViewPresentor", package.seeall)

local AccumulateChargeProgressViewPresentor = class("AccumulateChargeProgressViewPresentor", ViewPresentor)

function AccumulateChargeProgressViewPresentor:ctor()
	AccumulateChargeProgressViewPresentor.super.ctor(self)
end

function AccumulateChargeProgressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AccumulateChargeProgressViewPresentor:dependWhatResources()
	return {
		"ui/views/accumulatecharge/accumulatechargeprogressview.prefab"
	}
end

function AccumulateChargeProgressViewPresentor:buildViews()
	return {
		AccumulateChargeProgressView.New()
	}
end

return AccumulateChargeProgressViewPresentor
