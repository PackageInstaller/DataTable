-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompBloodFollow.lua

module("logic.battle.unit.comp.BattleUnitCompBloodFollow", package.seeall)

local BattleUnitCompBloodFollow = class("BattleUnitCompBloodFollow", UnitCompUIFollow, IBattleUnitComponent)

function BattleUnitCompBloodFollow:onInit()
	BattleUnitCompBloodFollow.super.onInit(self)
end

function BattleUnitCompBloodFollow:_createUIFollow()
	local uiFollow = UIFollowUnit.Get(self._unit.mountRoot:getAvatarRoot())

	uiFollow:CreateFollowGroup(0, 0)

	return uiFollow
end

function BattleUnitCompBloodFollow:_onMeshModelLoaded()
	self:setSize(0, 0)
end

function BattleUnitCompBloodFollow:setBloodFollowMainGameObject(go)
	self:setMainGameObject(go)
end

return BattleUnitCompBloodFollow
