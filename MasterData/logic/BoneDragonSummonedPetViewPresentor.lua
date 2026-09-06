-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonSummonedPetViewPresentor.lua

module("logic.extensions.bonedragon.view.BoneDragonSummonedPetViewPresentor", package.seeall)

local BoneDragonSummonedPetViewPresentor = class("BoneDragonSummonedPetViewPresentor", ViewPresentor)

function BoneDragonSummonedPetViewPresentor:ctor()
	BoneDragonSummonedPetViewPresentor.super.ctor(self)
end

function BoneDragonSummonedPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoneDragonSummonedPetViewPresentor:dependWhatResources()
	return {
		"ui/views/bonedragon/bonedragonsummonedpetview.prefab"
	}
end

function BoneDragonSummonedPetViewPresentor:buildViews()
	return {
		BoneDragonSummonedPetView.New()
	}
end

return BoneDragonSummonedPetViewPresentor
