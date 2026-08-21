require "class"
---@class BuffHandler:BaseClass
local BuffHandler = class("BuffHandler")
local Buff = require "Buff"
local BattleCore = require "BattleCore"

---记录在buff身上的数据
local specailBuffTypes = {
    [GE.SkillAffixType.ModifyAttrib] = 1,
    [GE.SkillAffixType.replaceActiveSkill] = 1,
    [GE.SkillAffixType.replacePassiveSkill] = 1,
    [GE.SkillAffixType.additionalPassiveSkill] = 1,
    [GE.SkillAffixType.ChangeSkillCoverRange] = 1,
    [GE.SkillAffixType.ChangeSkillSelectRange] = 1,
    [GE.SkillAffixType.ModifyRestraintRatio] = 1,
    [GE.SkillAffixType.ModifyTerrainRatio] = 1,
	[GE.SkillAffixType.ModifyAttribByOther] = 1,
	[GE.SkillAffixType.SetBuffRoundOffset] = 1,
	[GE.SkillAffixType.AddBuffRoundOffset] = 1,
	[GE.SkillAffixType.MoveCostChange] = 1,
	[GE.SkillAffixType.ImmuneBuff] = 1,
	[GE.SkillAffixType.ImmuneBuffEffect] = 1,
	[GE.SkillAffixType.ImmuneEffect] = 1,
	[GE.SkillAffixType.ImmuneEffectTrigger] = 1,
	[GE.SkillAffixType.ChangeSkillSelectRangeBySkillTag] = 1,
	[GE.SkillAffixType.KeepBuffRoundByTagOffset] = 1,
}

function BuffHandler:ctor()

end

---实例化
---@return BuffHandler BuffHandler
function BuffHandler.instance()
	if (BuffHandler._instance == nil) then
		BuffHandler._instance = BuffHandler:new()
	end
	return BuffHandler._instance
end

---@class BuffData
---@field id integer buff的id
---@field rounds integer
---@field buffCondition integer[] buff生效条件
---@field source BattleRole
---@field buffConfig BuffTable

---@class BuffSnapshot 回溯存档用 Buff 快照（纯数据，无循环引用）
---@field id integer
---@field sourceId integer
---@field remainRounds integer
---@field curLevel integer
---@field effectActivationLimit integer?

---导出 Buff 快照（仅序列化必要字段，避免 clone Buff 循环引用栈溢出）
---@param buff Buff
---@return BuffSnapshot
function BuffHandler:exportSnapshot(buff)
	---@type BuffSnapshot
	local snapshot = {
		id = buff.id,
		sourceId = buff.sourceId,
		remainRounds = buff:getRemainRounds(),
		curLevel = buff:getLevel(),
		effectActivationLimit = buff._effectActivationLimit,
	}
	return snapshot
end

---根据快照重建 Buff，并重新挂载 Buff 效果（由调用方触发 checkBuffAffixes）
---@param snapshot BuffSnapshot
---@param owner BattleRole
---@return Buff?
function BuffHandler:createBuffFromSnapshot(snapshot, owner)
	if not snapshot or not snapshot.id then
		return nil
	end
	local roleMgr = BattleCore:getBattleRoleMgr()
	local source = roleMgr:getRole(snapshot.sourceId, true) or owner
	local buffConfig = Config.GetBuffInfo(snapshot.id)
	if not buffConfig then
		BattleCore.es("BuffHandler:createBuffFromSnapshot no buff config", snapshot.id)
		return nil
	end
	local remainRounds = snapshot.remainRounds or 1
	local buff = self:createBuff(snapshot.id, remainRounds, {}, source, buffConfig)
	local curLevel = snapshot.curLevel or 1
	if curLevel > 1 then
		buff:restoreLevel(curLevel, remainRounds)
	end
	if snapshot.effectActivationLimit ~= nil then
		buff:restoreEffectActivationLimit(snapshot.effectActivationLimit)
	end
	buff:setOwner(owner.id)
	return buff
end

---创建Buff
---@param id integer BuffID
---@param rounds integer 持续回合数
---@param buffCondition table buff条件
---@param source BattleRole 来源
---@param buffConfig BuffTable buff配置
---@return Buff Buff
function BuffHandler:createBuff(id, rounds, buffCondition, source, buffConfig)
	---@type BuffData
	local buffData = {
		id = id,
		buffCondition = buffCondition,
		rounds = rounds,
		source = source,
		buffConfig = buffConfig
	}
	local _buff = Buff:new(buffData)
	return _buff
end

---检测Buff效果
---@param owner BattleRole Buff携带者
---@param _buff Buff Buff数据
---@param delay number 表现延迟
---@param getPendingAffixes boolean? 获取待生效效果
function BuffHandler:checkBuffAffixes(owner, _buff, timing, delay, getPendingAffixes)
	-- LuaLogger.ds("BuffHandler:checkBuffAffixes",_buff.id)
	local skillMgr = BattleCore.getSkillMgr()
	---@type BuffTable
	local buffConfig = _buff.configData
	local pendingAffixes = {}
	if (buffConfig) then
		local checkResult = true
		local buffTiming = buffConfig.effectTiming
		local canCheckCondition = (timing == nil and buffTiming == 0) or
			(timing == nil and buffTiming == GE.BattleTiming.RoleHpChange) or
			(buffTiming == timing)
		--检测Buff时机，不配置生效时机的buff只有在添加时生效，与血量相关的buff添加时也需要检测
		if not canCheckCondition then
			return pendingAffixes
		end
		---添加时暂时不检测Buff条件，防止出现Buff无法添加的情况
		if (timing ~= nil) or (timing == nil and buffTiming == GE.BattleTiming.RoleHpChange) then
			local isPass = _buff:checkBuffCondition()
			checkResult = isPass
		end
		if (buffConfig.effectId) then
			--执行效果
			for _, effectId in ipairs(buffConfig.effectId) do
				-- LuaLogger.ds("BuffHandler:doAffix effectId",effectId)
                local effectConfig = Config.GetEffectInfo(effectId)
                -- local effectConfig = tablex.clone(configData)
				---@type BattleRole|Buff
                local _source = owner
				local attriType = effectConfig.effectAttriType
                if specailBuffTypes[attriType] then
                    _source = _buff
                end
				if (not getPendingAffixes) then
                    skillMgr:checkAffixData(_source, owner, effectConfig, checkResult, delay)
				else
					---@type pendingAffixData
					local pendingAffixData = {
						priority = effectConfig.priority,
                        source = _source,
						target = owner,
						effectConfig = effectConfig,
						isDoAffix = checkResult,
						delay = delay
					}
					table.insert(pendingAffixes, pendingAffixData)
				end
			end
		end
	end
	return pendingAffixes
end

---检测光环类Buff效果
---@param owner BattleRole Buff携带者
---@param _buff Buff Buff数据
function BuffHandler:checkHaloBuff(owner, _buff, isAddAffix)
	local delay = 0
    local skillMgr = BattleCore.getSkillMgr()
    ---@type BuffTable
    local buffConfig = _buff.configData
    local roleMgr = BattleCore:getBattleRoleMgr()
    local buffSource = roleMgr:getRole(_buff.sourceId)
    if (buffConfig) then
        local checkResult = _buff:checkBuffCondition()
        -- LuaLogger.ds("检测光环buff效果是否通过", checkResult)
        if checkResult == false then
            return
        end
        --检测Buff条件
        if (buffConfig.effectId) then
            --执行效果
            for _, effectId in ipairs(buffConfig.effectId) do
                local effectConfig = tablex.clone(Config.GetEffectInfo(effectId))
                if effectConfig.effectAttriType == GE.SkillAffixType.HaloBuff then
                    if isAddAffix then
                        skillMgr:doAffix(buffSource, owner, effectConfig, delay)
					end
                end
            end
        end
    end
end

---移除Buff效果
---@param owner BattleRole Buff携带者
---@param _buff Buff Buff数据
function BuffHandler:removeBuffAffix(owner, _buff)
    local skillMgr = BattleCore.getSkillMgr()
    local buffConfig = _buff.configData
    local roleMgr = BattleCore:getBattleRoleMgr()
    local buffSource = roleMgr:getRole(_buff.sourceId)
    --检测Buff条件
    if (buffConfig.effectId) then
        --执行效果
        for _, effectId in ipairs(buffConfig.effectId) do
            -- LuaLogger.ds("BuffHandler:removeBuffAffix effectId", effectId)
            local effectConfig = Config.GetEffectInfo(effectId)
            skillMgr:removeAffix(buffSource, owner, effectConfig, nil)
        end
    end
end

return BuffHandler