-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompetepopViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompetepopViewPresentor", package.seeall)

local BountypkcompetepopViewPresentor = class("BountypkcompetepopViewPresentor", ViewPresentor)

function BountypkcompetepopViewPresentor:ctor()
	BountypkcompetepopViewPresentor.super.ctor(self)
end

function BountypkcompetepopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BountypkcompetepopViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompetepopview.prefab"
	}
end

function BountypkcompetepopViewPresentor:buildViews()
	return {
		BountyPKCompetePopView.New()
	}
end

return BountypkcompetepopViewPresentor
