-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/ActstargodchangeViewPresentor.lua

module("logic.extensions.aceteam.view.ActstargodchangeViewPresentor", package.seeall)

local ActstargodchangeViewPresentor = class("ActstargodchangeViewPresentor", ViewPresentor)

function ActstargodchangeViewPresentor:ctor()
	ActstargodchangeViewPresentor.super.ctor(self)
end

function ActstargodchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActstargodchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/actstargodchangeview.prefab"
	}
end

function ActstargodchangeViewPresentor:buildViews()
	return {
		ActstargodchangeView.New()
	}
end

return ActstargodchangeViewPresentor
