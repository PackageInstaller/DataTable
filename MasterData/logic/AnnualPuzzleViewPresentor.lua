-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/view/AnnualPuzzleViewPresentor.lua

module("logic.extensions.annualactivity.view.AnnualPuzzleViewPresentor", package.seeall)

local AnnualPuzzleViewPresentor = class("AnnualPuzzleViewPresentor", ViewPresentor)

function AnnualPuzzleViewPresentor:ctor()
	AnnualPuzzleViewPresentor.super.ctor(self)
end

function AnnualPuzzleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualPuzzleViewPresentor:dependWhatResources()
	return {
		"ui/views/annualactivity/annualpuzzleview.prefab"
	}
end

function AnnualPuzzleViewPresentor:buildViews()
	return {
		AnnualPuzzleView.New()
	}
end

return AnnualPuzzleViewPresentor
