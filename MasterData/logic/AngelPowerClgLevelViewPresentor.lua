-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgLevelViewPresentor.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgLevelViewPresentor", package.seeall)

local AngelPowerClgLevelViewPresentor = class("AngelPowerClgLevelViewPresentor", ViewPresentor)

function AngelPowerClgLevelViewPresentor:ctor()
	AngelPowerClgLevelViewPresentor.super.ctor(self)
end

function AngelPowerClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AngelPowerClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/angelpowerclg/angelpowerclglevelview.prefab"
	}
end

function AngelPowerClgLevelViewPresentor:buildViews()
	return {
		AngelPowerClgLevelView.New()
	}
end

return AngelPowerClgLevelViewPresentor
