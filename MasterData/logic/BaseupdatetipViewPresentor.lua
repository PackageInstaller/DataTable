-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/newyear/BaseupdatetipViewPresentor.lua

module("logic.extensions.bonus.view.newyear.BaseupdatetipViewPresentor", package.seeall)

local BaseupdatetipViewPresentor = class("BaseupdatetipViewPresentor", ViewPresentor)

function BaseupdatetipViewPresentor:ctor()
	BaseupdatetipViewPresentor.super.ctor(self)
end

function BaseupdatetipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BaseupdatetipViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/newyear/baseupdatetipview.prefab"
	}
end

function BaseupdatetipViewPresentor:buildViews()
	return {
		BaseupdatetipView.New()
	}
end

return BaseupdatetipViewPresentor
