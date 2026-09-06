-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgFmtViewPresentor.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgFmtViewPresentor", package.seeall)

local AngelPowerClgFmtViewPresentor = class("AngelPowerClgFmtViewPresentor", ViewPresentor)

function AngelPowerClgFmtViewPresentor:ctor()
	AngelPowerClgFmtViewPresentor.super.ctor(self)
end

function AngelPowerClgFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AngelPowerClgFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/angelpowerclg/angelpowerclgfmtview.prefab"
	}
end

function AngelPowerClgFmtViewPresentor:buildViews()
	return {
		AngelPowerClgFmtView.New()
	}
end

return AngelPowerClgFmtViewPresentor
