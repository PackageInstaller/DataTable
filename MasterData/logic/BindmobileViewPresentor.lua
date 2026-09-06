-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bindmobile/view/BindmobileViewPresentor.lua

module("logic.extensions.bindmobile.view.BindmobileViewPresentor", package.seeall)

local BindmobileViewPresentor = class("BindmobileViewPresentor", ViewPresentor)

function BindmobileViewPresentor:ctor()
	BindmobileViewPresentor.super.ctor(self)
end

function BindmobileViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BindmobileViewPresentor:dependWhatResources()
	return {
		"ui/views/bindmobile/bindmobileview.prefab"
	}
end

function BindmobileViewPresentor:buildViews()
	return {
		BindmobileView.New()
	}
end

return BindmobileViewPresentor
