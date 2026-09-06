-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/AQAFBuffMgr.lua

module("logic.extensions.aoqiattackforce.minigame.AQAFBuffMgr", package.seeall)

local AQAFBuffMgr = class("AQAFBuffMgr")

AQAFBuffMgr.BUFF_TYPE_ADD = 1
AQAFBuffMgr.BUFF_TYPE_COVER = 2
AQAFBuffMgr.BUFF_TYPE_STACK = 3
AQAFBuffMgr.TRIGGER_STAGE_CREATE = 1
AQAFBuffMgr.TRIGGER_STAGE_ATTACK = 2
AQAFBuffMgr.TRIGGER_STAGE_HIT = 3
AQAFBuffMgr.TRIGGER_STAGE_BEHIT = 4
AQAFBuffMgr.TRIGGER_STAGE_DAMAGE_BF = 5
AQAFBuffMgr.TRIGGER_STAGE_DAMAGE_AF = 6
AQAFBuffMgr.TRIGGER_STAGE_CRIT = 7
AQAFBuffMgr.TRIGGER_STAGE_CAUSE_DAMAGE_BF = 8
AQAFBuffMgr.TRIGGER_Fixed_Interval = 9
AQAFBuffMgr.TRIGGER_STAGE_CAUSE_DAMAGE_AF = 10
AQAFBuffMgr.TRIGGER_STAGE_DEAD = 11
AQAFBuffMgr.IDX_ICE = 1
AQAFBuffMgr.IDX_POISON = 2
AQAFBuffMgr.IDX_FIRE = 3
AQAFBuffMgr.EFFECT_PATH_LIST = {
	[AQAFBuffMgr.IDX_ICE] = "20250124/aqtgd/fx_ui_aqtgd_bingdong.prefab",
	[AQAFBuffMgr.IDX_POISON] = "20250124/aqtgd/fx_ui_aqtgd_du.prefab",
	[AQAFBuffMgr.IDX_FIRE] = "20250124/aqtgd/fx_ui_aqtgd_zhuoshao.prefab"
}

function AQAFBuffMgr:ctor()
	self._buffObjPool = self._buffObjPool or {}
end

function AQAFBuffMgr:resetAll()
	return
end

function AQAFBuffMgr:addBuffToUnit(unit, buffType, cfg)
	if buffType == AQAFBuffMgr.BUFF_TYPE_ADD then
		local buff = self:getOrcreateBuff(unit, cfg.triggerDone, cfg.buffId, cfg.triggerPhase, cfg)

		table.insert(unit.buffList, buff)
	elseif buffType == AQAFBuffMgr.BUFF_TYPE_COVER then
		local buff = self:getOrcreateBuff(unit, cfg.triggerDone, cfg.buffId, cfg.triggerPhase, cfg)

		for i, v in ipairs(unit.buffList) do
			if v.buffCfgId == cfg.buffId then
				buff:setCover()

				unit.buffList[i] = buff

				return
			end
		end

		table.insert(unit.buffList, buff)
	elseif buffType == AQAFBuffMgr.BUFF_TYPE_STACK then
		for i, v in ipairs(unit.buffList) do
			if v.buffCfgId == cfg.buffId then
				v:addLayerCount()

				return
			end
		end

		local buff = self:getOrcreateBuff(unit, cfg.triggerDone, cfg.buffId, cfg.triggerPhase, cfg)

		table.insert(unit.buffList, buff)
	end
end

function AQAFBuffMgr:getOrcreateBuff(unit, name, buffCfgId, triggerStage, cfg)
	local buff = self:getBuffInPool(unit, name)

	buff:initData(unit, buffCfgId, triggerStage, cfg)

	return buff
end

function AQAFBuffMgr:getBuffInPool(unit, buffName)
	if self._buffObjPool[buffName] == nil then
		local function createFuncBuff()
			return (self:createBuff(unit, buffName))
		end

		local function disposeFuncBuff(buff)
			return
		end

		local function resetFuncBuff(buff)
			return
		end

		self._buffObjPool[buffName] = ObjectPool.New(20, createFuncBuff, disposeFuncBuff, resetFuncBuff)
	end

	return (self._buffObjPool[buffName]:fetchObject())
end

function AQAFBuffMgr:disposeBuff(buff)
	if self._buffObjPool and self._buffObjPool[buff.buffName] then
		self._buffObjPool[buff.buffName]:returnObject(buff)
	end
end

function AQAFBuffMgr:createBuff(unit, name, buffCfgId, triggerStage, cfg)
	local buff

	if name == "change_attr" then
		buff = AQAFChangeAttrBuff.New(name)
	elseif name == "change_bullet_count" then
		buff = AQAFChangeBulletCountBuff.New(name)
	elseif name == "change_damage" then
		buff = AQAFChangeDamageBuff.New(name)
	elseif name == "create_status" then
		buff = AQAFCreateStatusBuff.New(name)
	elseif name == "life_stealing" then
		buff = AQAFLifeStealingBuff.New(name)
	elseif name == "new_buff" then
		buff = AQAFNewBuffBuff.New(name)
	elseif name == "new_bullet" then
		buff = AQAFNewBulletBuff.New(name)
	elseif name == "one_hit_kill" then
		buff = AQAFOneHitKillBuff.New(name)
	elseif name == "flight_mode" then
		buff = AQAFNewFlightModeBuff.New(name)
	elseif name == "new_status" then
		buff = AQAFNewFlightModeBuff.New(name)
	elseif name == "cold_state" then
		buff = AQAFColdStatusBuff.New(name)
	elseif name == "blood_loss_state" then
		buff = AQAFBloodLossStatusBuff.New(name)
	elseif name == "froze_state" then
		buff = AQAFFrozenStatusBuff.New(name)
	elseif name == "knockback" then
		buff = AQAFKnockbackBuff.New(name)
	elseif name == "split" then
		buff = AQAFSplitBuff.New(name)
	end

	return buff
end

function AQAFBuffMgr:checkUnitIsBoss(unit, param)
	local isBoss = unit:getTag() == AQAFGameEnum.UnitTag.Monster and unit:isBoss()

	if checknumber(param) == 0 then
		return not isBoss
	else
		return isBoss
	end
end

function AQAFBuffMgr:checkPlayerHp(param)
	return true
end

function AQAFBuffMgr:checkTargetType(param)
	return true
end

function AQAFBuffMgr:checkTargetAtkType(param)
	return true
end

function AQAFBuffMgr:onUpdate(unit)
	for i, v in ipairs(unit.buffList) do
		v:onUpdate()
	end
end

function AQAFBuffMgr:onAdd(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onAdd(target)
	end
end

function AQAFBuffMgr:onHit(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onHit(target)
	end
end

function AQAFBuffMgr:onBeHit(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onBeHit(target)
	end
end

function AQAFBuffMgr:onCrit(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onCrit(target)
	end
end

function AQAFBuffMgr:onAttack(unit)
	for i, v in ipairs(unit.buffList) do
		v:onAttack(unit)
	end
end

function AQAFBuffMgr:onBeforeDammage(unit, target, dammage)
	for i, v in ipairs(unit.buffList) do
		v:onBeforeDammage(target, dammage)
	end
end

function AQAFBuffMgr:onAfterDammage(unit, target, dammage)
	for i, v in ipairs(unit.buffList) do
		v:onAfterDammage(target, dammage)
	end
end

function AQAFBuffMgr:onBeforeCauseDamage(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onBeforeCauseDamage(target)
	end
end

function AQAFBuffMgr:onAfterCauseDamage(unit, target, dammage)
	for i, v in ipairs(unit.buffList) do
		v:onAfterCauseDamage(target, dammage)
	end
end

function AQAFBuffMgr:onSelfDead(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onSelfDead(target)
	end
end

AQAFBuffMgr.instance = AQAFBuffMgr.New()

return AQAFBuffMgr
