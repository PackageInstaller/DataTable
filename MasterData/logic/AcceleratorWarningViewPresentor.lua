-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/acceleratorcheck/view/AcceleratorWarningViewPresentor.lua

module("logic.extensions.acceleratorcheck.view.AcceleratorWarningViewPresentor", package.seeall)

local AcceleratorWarningViewPresentor = class("AcceleratorWarningViewPresentor", ViewPresentor)

function AcceleratorWarningViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function AcceleratorWarningViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupwindow_new.prefab"
	}
end

function AcceleratorWarningViewPresentor:buildViews()
	return {
		AcceleratorWarningView.New()
	}
end

return AcceleratorWarningViewPresentor
