-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompetematchViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompetematchViewPresentor", package.seeall)

local BountypkcompetematchViewPresentor = class("BountypkcompetematchViewPresentor", ViewPresentor)

function BountypkcompetematchViewPresentor:ctor()
	BountypkcompetematchViewPresentor.super.ctor(self)
end

function BountypkcompetematchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BountypkcompetematchViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompetematchview.prefab"
	}
end

function BountypkcompetematchViewPresentor:buildViews()
	return {
		BountyPKCompeteMatchView.New()
	}
end

return BountypkcompetematchViewPresentor
