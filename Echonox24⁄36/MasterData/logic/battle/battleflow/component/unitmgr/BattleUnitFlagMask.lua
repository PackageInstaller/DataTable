-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/unitmgr/BattleUnitFlagMask.lua

module("logic.battle.battleflow.component.unitmgr.BattleUnitFlagMask", package.seeall)

local BattleUnitFlagMask = {}

local function createMask(...)
	return BitUtils.EnableBits(0, ...)
end

BattleUnitFlagMask.FlagOperatable = 0
BattleUnitFlagMask.FlagAttackable = 1
BattleUnitFlagMask.FlagIntangible = 2
BattleUnitFlagMask.FlagStepable = 3
BattleUnitFlagMask.MaskNormal = createMask(BattleUnitFlagMask.FlagOperatable, BattleUnitFlagMask.FlagAttackable, BattleUnitFlagMask.FlagStepable)
BattleUnitFlagMask.MaskAttackable = createMask(BattleUnitFlagMask.FlagOperatable, BattleUnitFlagMask.FlagAttackable)
BattleUnitFlagMask.MaskTerrain = 0
BattleUnitFlagMask.MaskIntangible = createMask(BattleUnitFlagMask.FlagIntangible)
BattleUnitFlagMask.MaskNpc = createMask(BattleUnitFlagMask.FlagOperatable)

function BattleUnitFlagMask.checkMaskEnable(value, mask)
	return BitUtils.IsEnableBits(value, mask)
end

function BattleUnitFlagMask.checkFlagEnable(value, flag)
	return BitUtils.IsEnableBit(value, flag)
end

return BattleUnitFlagMask
