-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessselectfullstarbuffViewPresentor.lua

module("logic.extensions.autochess.view.AutochessselectfullstarbuffViewPresentor", package.seeall)

local AutochessselectfullstarbuffViewPresentor = class("AutochessselectfullstarbuffViewPresentor", ViewPresentor)

function AutochessselectfullstarbuffViewPresentor:ctor()
	AutochessselectfullstarbuffViewPresentor.super.ctor(self)
end

function AutochessselectfullstarbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AutochessselectfullstarbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/autochess/autochessselectfullstarbuffview.prefab"
	}
end

function AutochessselectfullstarbuffViewPresentor:buildViews()
	return {
		AutochessselectfullstarbuffView.New()
	}
end

return AutochessselectfullstarbuffViewPresentor
