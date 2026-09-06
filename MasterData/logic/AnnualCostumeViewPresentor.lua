-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/anniversary/AnnualCostumeViewPresentor.lua

module("logic.extensions.bonus.view.anniversary.AnnualCostumeViewPresentor", package.seeall)

local AnnualCostumeViewPresentor = class("AnnualCostumeViewPresentor", ViewPresentor)

function AnnualCostumeViewPresentor:ctor()
	AnnualCostumeViewPresentor.super.ctor(self)
end

function AnnualCostumeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualCostumeViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/anniversary/annualcostumeview.prefab"
	}
end

function AnnualCostumeViewPresentor:buildViews()
	return {
		AnnualCostumeView.New()
	}
end

return AnnualCostumeViewPresentor
