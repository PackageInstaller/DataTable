-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompeteprepareViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompeteprepareViewPresentor", package.seeall)

local BountypkcompeteprepareViewPresentor = class("BountypkcompeteprepareViewPresentor", ViewPresentor)

function BountypkcompeteprepareViewPresentor:ctor()
	BountypkcompeteprepareViewPresentor.super.ctor(self)
end

function BountypkcompeteprepareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BountypkcompeteprepareViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompeteprepareview.prefab"
	}
end

function BountypkcompeteprepareViewPresentor:buildViews()
	return {
		BountyPKCompetePrepareView.New()
	}
end

return BountypkcompeteprepareViewPresentor
