-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompUIFollow.lua

module("logic.battle.unit.comp.BattleUnitCompUIFollow", package.seeall)

local BattleUnitCompUIFollow = class("BattleUnitCompUIFollow", UnitCompUIFollow, IBattleUnitComponent)

function BattleUnitCompUIFollow:onInit()
	BattleUnitCompUIFollow.super.onInit(self)
	self._uiFollow:CreateFollowGroup(0, 1.2)
	self._uiFollow:CreateFollowGroup(0, 0.5)
	self._uiFollow:SetPerspectiveEnable(false)
end

function BattleUnitCompUIFollow:turnOnPerspective()
	self._uiFollow:SetPerspectiveArgs(8, 1, 3)
	self._uiFollow:SetPerspectiveEnable(true)
end

function BattleUnitCompUIFollow:turnOffPerspective()
	self._uiFollow:SetPerspectiveEnable(false)
end

return BattleUnitCompUIFollow
