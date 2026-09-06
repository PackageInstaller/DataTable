-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompeterankViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompeterankViewPresentor", package.seeall)

local BountypkcompeterankViewPresentor = class("BountypkcompeterankViewPresentor", ViewPresentor)

function BountypkcompeterankViewPresentor:ctor()
	BountypkcompeterankViewPresentor.super.ctor(self)
end

function BountypkcompeterankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BountypkcompeterankViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompeterankview.prefab"
	}
end

function BountypkcompeterankViewPresentor:buildViews()
	return {
		BountyPKCompeteRankView.New()
	}
end

return BountypkcompeterankViewPresentor
