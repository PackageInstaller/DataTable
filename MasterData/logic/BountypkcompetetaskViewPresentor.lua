-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompetetaskViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompetetaskViewPresentor", package.seeall)

local BountypkcompetetaskViewPresentor = class("BountypkcompetetaskViewPresentor", ViewPresentor)

function BountypkcompetetaskViewPresentor:ctor()
	BountypkcompetetaskViewPresentor.super.ctor(self)
end

function BountypkcompetetaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BountypkcompetetaskViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompetetaskview.prefab"
	}
end

function BountypkcompetetaskViewPresentor:buildViews()
	return {
		BountyPKCompeteTaskView.New()
	}
end

return BountypkcompetetaskViewPresentor
