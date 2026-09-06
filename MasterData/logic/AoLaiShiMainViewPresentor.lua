-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/AoLaiShiMainViewPresentor.lua

module("logic.extensions.operationsummary.view.AoLaiShiMainViewPresentor", package.seeall)

local AoLaiShiMainViewPresentor = class("AoLaiShiMainViewPresentor", ViewPresentor)

function AoLaiShiMainViewPresentor:ctor()
	AoLaiShiMainViewPresentor.super.ctor(self)
end

function AoLaiShiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoLaiShiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/aolaishimainview.prefab"
	}
end

function AoLaiShiMainViewPresentor:buildViews()
	return {
		AoLaiShiMainView.New()
	}
end

return AoLaiShiMainViewPresentor
