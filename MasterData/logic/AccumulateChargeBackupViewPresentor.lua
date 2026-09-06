-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/view/AccumulateChargeBackupViewPresentor.lua

module("logic.extensions.accumulatecharge.view.AccumulateChargeBackupViewPresentor", package.seeall)

local AccumulateChargeBackupViewPresentor = class("AccumulateChargeBackupViewPresentor", ViewPresentor)

function AccumulateChargeBackupViewPresentor:ctor()
	AccumulateChargeBackupViewPresentor.super.ctor(self)
end

function AccumulateChargeBackupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AccumulateChargeBackupViewPresentor:dependWhatResources()
	return {
		"ui/views/accumulatecharge/accumulatechargebackupview.prefab"
	}
end

function AccumulateChargeBackupViewPresentor:buildViews()
	return {
		AccumulateChargeBackupView.New()
	}
end

return AccumulateChargeBackupViewPresentor
