-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/amier/AmierDetailViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.amier.AmierDetailViewPresentor", package.seeall)

local AmierDetailViewPresentor = class("AmierDetailViewPresentor", ViewPresentor)

function AmierDetailViewPresentor:ctor()
	AmierDetailViewPresentor.super.ctor(self)
end

function AmierDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AmierDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/amier/amierdetailview.prefab"
	}
end

function AmierDetailViewPresentor:buildViews()
	return {
		AmierDetailView.New()
	}
end

return AmierDetailViewPresentor
