-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupTaskViewPresentor.lua

module("logic.extensions.brothergroup.view.BrotherGroupTaskViewPresentor", package.seeall)

local BrotherGroupTaskViewPresentor = class("BrotherGroupTaskViewPresentor", ViewPresentor)

function BrotherGroupTaskViewPresentor:ctor()
	BrotherGroupTaskViewPresentor.super.ctor(self)
end

function BrotherGroupTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherGroupTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/brothergroup/brothergrouptaskview.prefab"
	}
end

function BrotherGroupTaskViewPresentor:buildViews()
	return {
		BrotherGroupTaskView.New()
	}
end

return BrotherGroupTaskViewPresentor
