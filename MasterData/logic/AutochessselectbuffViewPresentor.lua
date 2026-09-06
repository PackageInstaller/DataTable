-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessselectbuffViewPresentor.lua

module("logic.extensions.autochess.view.AutochessselectbuffViewPresentor", package.seeall)

local AutochessselectbuffViewPresentor = class("AutochessselectbuffViewPresentor", ViewPresentor)

function AutochessselectbuffViewPresentor:ctor()
	AutochessselectbuffViewPresentor.super.ctor(self)
end

function AutochessselectbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AutochessselectbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessselectbuffview.prefab"
	}
end

function AutochessselectbuffViewPresentor:buildViews()
	return {
		AutochessselectbuffView.New()
	}
end

return AutochessselectbuffViewPresentor
