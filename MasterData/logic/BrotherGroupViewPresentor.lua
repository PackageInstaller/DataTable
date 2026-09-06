-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupViewPresentor.lua

module("logic.extensions.brothergroup.view.BrotherGroupViewPresentor", package.seeall)

local BrotherGroupViewPresentor = class("BrotherGroupViewPresentor", ViewPresentor)

function BrotherGroupViewPresentor:ctor()
	BrotherGroupViewPresentor.super.ctor(self)
end

function BrotherGroupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherGroupViewPresentor:dependWhatResources()
	return {
		"ui/views/brothergroup/brothergroupview.prefab"
	}
end

function BrotherGroupViewPresentor:buildViews()
	return {
		BrotherGroupView.New()
	}
end

return BrotherGroupViewPresentor
