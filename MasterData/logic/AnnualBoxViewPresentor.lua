-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualbox/view/AnnualBoxViewPresentor.lua

module("logic.extensions.annualbox.view.AnnualBoxViewPresentor", package.seeall)

local AnnualBoxViewPresentor = class("AnnualBoxViewPresentor", ViewPresentor)

function AnnualBoxViewPresentor:ctor()
	AnnualBoxViewPresentor.super.ctor(self)
end

function AnnualBoxViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualBoxViewPresentor:dependWhatResources()
	return {
		"ui/views/annualbox/annualboxview.prefab"
	}
end

function AnnualBoxViewPresentor:buildViews()
	return {
		AnnualBoxView.New()
	}
end

return AnnualBoxViewPresentor
