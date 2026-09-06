-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/BackListViewPresentor.lua

module("logic.extensions.sevendays.view.BackListViewPresentor", package.seeall)

local BackListViewPresentor = class("BackListViewPresentor", ViewWithGuidePresentor)

function BackListViewPresentor:ctor()
	BackListViewPresentor.super.ctor(self)
end

function BackListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BackListViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/backlistview.prefab"
	}
end

function BackListViewPresentor:buildViews()
	return {
		BackListView.New()
	}
end

return BackListViewPresentor
