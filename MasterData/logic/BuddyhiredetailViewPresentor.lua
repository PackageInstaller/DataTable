-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyhire/view/BuddyhiredetailViewPresentor.lua

module("logic.extensions.buddyhire.view.BuddyhiredetailViewPresentor", package.seeall)

local BuddyhiredetailViewPresentor = class("BuddyhiredetailViewPresentor", ViewPresentor)

function BuddyhiredetailViewPresentor:ctor()
	BuddyhiredetailViewPresentor.super.ctor(self)
end

function BuddyhiredetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuddyhiredetailViewPresentor:dependWhatResources()
	return {
		"ui/views/buddyhire/buddyhiredetailview.prefab",
		ItemAttr.ResPath
	}
end

function BuddyhiredetailViewPresentor:buildViews()
	return {
		BuddyhiredetailView.New()
	}
end

return BuddyhiredetailViewPresentor
