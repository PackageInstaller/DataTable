-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchtaskViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchtaskViewPresentor", package.seeall)

local AnnimatchtaskViewPresentor = class("AnnimatchtaskViewPresentor", ViewPresentor)

function AnnimatchtaskViewPresentor:ctor()
	AnnimatchtaskViewPresentor.super.ctor(self)
end

function AnnimatchtaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchtaskViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchtaskview.prefab"
	}
end

function AnnimatchtaskViewPresentor:buildViews()
	return {
		AnnimatchtaskView.New()
	}
end

return AnnimatchtaskViewPresentor
