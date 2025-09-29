-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleUnitEffectUtil.lua

module("logic.battle.util.BattleUnitEffectUtil", package.seeall)

local BattleUnitEffectUtil = {}

function BattleUnitEffectUtil.initUnitStates(unit)
	BattleUnitEffectUtil.judgeUnitState_WEAKPOINT_FROZEN(unit)
	unit.stateEffect:refreshStateEffect()
end

function BattleUnitEffectUtil.initUnitPropertyEffects(unit)
	BattleUnitEffectUtil.processPropertyEffect_CURRENT_SAN(unit)
end

function BattleUnitEffectUtil.processPropertyEffect_CURRENT_SAN(unit)
	local sanityValue = unit.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)

	if not sanityValue then
		return
	end

	if sanityValue < 0 then
		unit.effectPlayer:playLoopEffect(BattleConst.LOW_SANITY)
	else
		unit.effectPlayer:stopLoopEffect(BattleConst.LOW_SANITY)
	end
end

function BattleUnitEffectUtil.judgeUnitState_WEAKPOINT_FROZEN(unit)
	if unit.property:isShowWeakPoint() then
		local weakPointHp = unit.property:getWeakPointHp()

		if weakPointHp > 0 then
			unit.property:activeState(BattleEnum.State.HAS_WEAK_POINT)
			unit.property:inactiveState(BattleEnum.State.WEAKPOINT_FROZEN)
		else
			unit.property:inactiveState(BattleEnum.State.HAS_WEAK_POINT)
			unit.property:activeState(BattleEnum.State.WEAKPOINT_FROZEN)
		end
	end
end

return BattleUnitEffectUtil
