-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompetemainViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompetemainViewPresentor", package.seeall)

local BountypkcompetemainViewPresentor = class("BountypkcompetemainViewPresentor", ViewPresentor)

function BountypkcompetemainViewPresentor:ctor()
	BountypkcompetemainViewPresentor.super.ctor(self)
end

function BountypkcompetemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BountypkcompetemainViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompetemainview.prefab"
	}
end

function BountypkcompetemainViewPresentor:buildViews()
	return {
		BountyPKCompeteMainView.New()
	}
end

return BountypkcompetemainViewPresentor
