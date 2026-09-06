-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompetefmtViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompetefmtViewPresentor", package.seeall)

local BountypkcompetefmtViewPresentor = class("BountypkcompetefmtViewPresentor", ViewPresentor)

function BountypkcompetefmtViewPresentor:ctor()
	BountypkcompetefmtViewPresentor.super.ctor(self)
end

function BountypkcompetefmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BountypkcompetefmtViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompetefmtview.prefab"
	}
end

function BountypkcompetefmtViewPresentor:buildViews()
	return {
		BountyPKCompeteFmtView.New()
	}
end

return BountypkcompetefmtViewPresentor
