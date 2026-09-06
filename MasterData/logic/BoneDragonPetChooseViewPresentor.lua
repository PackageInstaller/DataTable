-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonPetChooseViewPresentor.lua

module("logic.extensions.bonedragon.view.BoneDragonPetChooseViewPresentor", package.seeall)

local BoneDragonPetChooseViewPresentor = class("BoneDragonPetChooseViewPresentor", ViewPresentor)

function BoneDragonPetChooseViewPresentor:ctor()
	BoneDragonPetChooseViewPresentor.super.ctor(self)
end

function BoneDragonPetChooseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoneDragonPetChooseViewPresentor:dependWhatResources()
	return {
		"ui/views/bonedragon/bonedragonpetchooseview.prefab"
	}
end

function BoneDragonPetChooseViewPresentor:buildViews()
	return {
		BoneDragonPetChooseView.New()
	}
end

return BoneDragonPetChooseViewPresentor
