-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/newyear/BaseupdateViewPresentor.lua

module("logic.extensions.bonus.view.newyear.BaseupdateViewPresentor", package.seeall)

local BaseupdateViewPresentor = class("BaseupdateViewPresentor", ViewPresentor)

function BaseupdateViewPresentor:ctor()
	BaseupdateViewPresentor.super.ctor(self)
end

function BaseupdateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BaseupdateViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/newyear/baseupdateview.prefab"
	}
end

function BaseupdateViewPresentor:buildViews()
	return {
		BaseupdateView.New()
	}
end

return BaseupdateViewPresentor
