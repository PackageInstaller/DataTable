-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgMainViewPresentor.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgMainViewPresentor", package.seeall)

local AngelPowerClgMainViewPresentor = class("AngelPowerClgMainViewPresentor", ViewPresentor)

function AngelPowerClgMainViewPresentor:ctor()
	AngelPowerClgMainViewPresentor.super.ctor(self)
end

function AngelPowerClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AngelPowerClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/angelpowerclg/angelpowerclgmainview.prefab"
	}
end

function AngelPowerClgMainViewPresentor:buildViews()
	return {
		AngelPowerClgMainView.New()
	}
end

return AngelPowerClgMainViewPresentor
