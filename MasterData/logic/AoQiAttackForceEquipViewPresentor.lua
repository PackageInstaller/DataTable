-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceEquipViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceEquipViewPresentor", package.seeall)

local AoQiAttackForceEquipViewPresentor = class("AoQiAttackForceEquipViewPresentor", ViewPresentor)

function AoQiAttackForceEquipViewPresentor:ctor()
	AoQiAttackForceEquipViewPresentor.super.ctor(self)
end

function AoQiAttackForceEquipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiAttackForceEquipViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackforceequipview.prefab"
	}
end

function AoQiAttackForceEquipViewPresentor:buildViews()
	return {
		AoQiAttackForceEquipView.New()
	}
end

function AoQiAttackForceEquipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AoQiAttackForceEquipViewPresentor
