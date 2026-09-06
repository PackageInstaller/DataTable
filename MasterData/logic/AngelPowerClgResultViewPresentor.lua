-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgResultViewPresentor.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgResultViewPresentor", package.seeall)

local AngelPowerClgResultViewPresentor = class("AngelPowerClgResultViewPresentor", ViewPresentor)

function AngelPowerClgResultViewPresentor:ctor()
	AngelPowerClgResultViewPresentor.super.ctor(self)
end

function AngelPowerClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AngelPowerClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/battlesettlement/battlesettlementsuccess.prefab"
	}
end

function AngelPowerClgResultViewPresentor:buildViews()
	return {
		AngelPowerClgResultView.New()
	}
end

return AngelPowerClgResultViewPresentor
