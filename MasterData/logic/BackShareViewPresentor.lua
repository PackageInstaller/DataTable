-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/BackShareViewPresentor.lua

module("logic.extensions.playerreturn.view.BackShareViewPresentor", package.seeall)

local BackShareViewPresentor = class("BackShareViewPresentor", ViewPresentor)

function BackShareViewPresentor:ctor()
	BackShareViewPresentor.super.ctor(self)
end

function BackShareViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BackShareViewPresentor:dependWhatResources()
	return {
		"ui/views/playerreturn/backshareview.prefab"
	}
end

function BackShareViewPresentor:buildViews()
	return {
		BackShareView.New()
	}
end

return BackShareViewPresentor
