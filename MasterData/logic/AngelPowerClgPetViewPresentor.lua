-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgPetViewPresentor.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgPetViewPresentor", package.seeall)

local AngelPowerClgPetViewPresentor = class("AngelPowerClgPetViewPresentor", ViewPresentor)

function AngelPowerClgPetViewPresentor:ctor()
	AngelPowerClgPetViewPresentor.super.ctor(self)
end

function AngelPowerClgPetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AngelPowerClgPetViewPresentor:dependWhatResources()
	return {
		"ui/views/angelpowerclg/angelpowerclgpetview.prefab"
	}
end

function AngelPowerClgPetViewPresentor:buildViews()
	return {
		AngelPowerClgPetView.New()
	}
end

return AngelPowerClgPetViewPresentor
