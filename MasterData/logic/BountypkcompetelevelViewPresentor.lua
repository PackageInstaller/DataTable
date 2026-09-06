-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompetelevelViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompetelevelViewPresentor", package.seeall)

local BountypkcompetelevelViewPresentor = class("BountypkcompetelevelViewPresentor", ViewPresentor)

function BountypkcompetelevelViewPresentor:ctor()
	BountypkcompetelevelViewPresentor.super.ctor(self)
end

function BountypkcompetelevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BountypkcompetelevelViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompetelevelview.prefab"
	}
end

function BountypkcompetelevelViewPresentor:buildViews()
	return {
		BountyPKCompeteLevelView.New()
	}
end

return BountypkcompetelevelViewPresentor
