-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupMatchViewPresentor.lua

module("logic.extensions.brothergroup.view.BrotherGroupMatchViewPresentor", package.seeall)

local BrotherGroupMatchViewPresentor = class("BrotherGroupMatchViewPresentor", ViewPresentor)

function BrotherGroupMatchViewPresentor:ctor()
	BrotherGroupMatchViewPresentor.super.ctor(self)
end

function BrotherGroupMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherGroupMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/brothergroup/brothergroupmatchview.prefab"
	}
end

function BrotherGroupMatchViewPresentor:buildViews()
	return {
		BrotherGroupMatchView.New()
	}
end

return BrotherGroupMatchViewPresentor
