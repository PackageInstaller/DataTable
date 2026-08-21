require "class"
---@class BuffController:BaseClass
local BuffController = class("BuffController")
local BattleCore = require "BattleCore"


function BuffController:ctor(owner)
	---@type BattleRole
	self._owner = owner
	---@type Buff[]
	self._buffsList = {}

	self.moveCostOffsetDic = {}

	---@type table<integer, integer> 被添加的buff的回合数修正值
	self.addBuffRoundOffsetDic = {}
	---@type table<integer, integer> 添加的buff的回合数修正值
	self.setBuffRoundOffsetDic = {}
end

---@return Buff[]
function BuffController:getBuffList()
	local r = {}
	local buffsList = self._buffsList
	for index = 1, #buffsList do
		r[index] = tablex.clone(buffsList[index])
	end
	return r
end

---@return Buff[]
function BuffController:getRawBuffList()
	return self._buffsList
end

---@param buffs BuffSnapshot[]|Buff[]?
function BuffController:resetBuffList(buffs)
	self._buffsList = {}
	if not buffs or not tablex.next(buffs) then
		return
	end
	local buffHandler = BattleCore.getBuffHandler()
	for _, entry in ipairs(buffs) do
		local buff = nil
		if type(entry) == "table" and entry.configData then
			-- 兼容旧存档中的 Buff 实例
			buff = entry
			buff:setOwner(self._owner.id)
			buffHandler:checkBuffAffixes(self._owner, buff, nil, 0)
		elseif type(entry) == "table" and entry.id and entry.sourceId then
			buff = buffHandler:createBuffFromSnapshot(entry, self._owner)
			if buff then
				buffHandler:checkBuffAffixes(self._owner, buff, nil, 0)
			end
		end
		if buff then
			table.insert(self._buffsList, buff)
		end
	end
end

---刷新Buff回合
function BuffController:refreshRemainRounds()
	-- local remove_list = {}
	for _, buff in ipairs(self._buffsList) do
		local needReduce = true
		local tags = buff:getTags()
		if tablex.next(tags) then
			for _, tag in ipairs(tags) do
				local buffIdList = self._cacheKeepBuffRoundDic[tag]
				if buffIdList then
					for _, buffId in ipairs(buffIdList) do
						if buffId ~= buff.id then
							needReduce = false
							break
						end
					end
				end
			end
		end
		if needReduce then
			buff:reduceRemainRounds()
		end
	end
end

---检测buff效果生效次数限制
---@param buff Buff
function BuffController:checkBuffEffectLimit(buff)
	if buff:getEffectLimit() <= 0 then
		self:removeBuff(buff)
	end
end

---检查Buff状态
function BuffController:checkBuffsState()
	local remove_list = {}
	for _, buff in ipairs(self._buffsList) do
		-- buff:reduceRemainRounds()
		if (buff:getRemainRounds() <= 0) or buff:getEffectLimit() <= 0 then
			table.insert(remove_list, buff)
		end
	end

	if (#remove_list > 0) then
		for _, buff in ipairs(remove_list) do
			-- LuaLogger.ds("BuffController:addBuff 移除", buff.id)
			self:removeBuff(buff)
		end
	end
end

---检查Buff效果
---@param timing any 时机
---@param delay any 表现延迟
---@param getPendingAffixes boolean 获取待生效效果
function BuffController:checkBuffAffixes(timing, delay, getPendingAffixes)
	delay = delay or 0
	local buffHandler = BattleCore.getBuffHandler()
	local pendingAffixes = {}
	for _, buff in ipairs(self._buffsList) do
		local list = buffHandler:checkBuffAffixes(self._owner, buff, timing, delay, getPendingAffixes)
		pendingAffixes = tablex.combine(pendingAffixes, list)
	end
	return pendingAffixes
end

---获取待生效效果
---@param timing BattleTiming 时机
---@param delay number? 表现延迟
---@return table pendingAffixes
function BuffController:getPendingBuffAffixes(timing, delay)
	return self:checkBuffAffixes(timing, delay, true)
end

---加Buff
---@param buff Buff
function BuffController:addBuff(buff, delay)
	local isProcessed = false
	local groupList = self:getBuffsByGroupId(buff.groupId)
	if (#groupList > 0) then
		for _, b in ipairs(groupList) do
			if (b.id == buff.id and not b:isMaxLevel()) then --叠加
				BattleCore.ds("BuffController:addBuff 叠加", buff.id)
				b:addLevel(buff:getRemainRounds())
				isProcessed = true
				break
			end
		end
		if (not isProcessed) then
			-- local battleMgr = BattleCore:getBattleMgr()
			local buffConfig = buff.configData --battleMgr:getBuffConfig(buff.id)
			if (#groupList < buffConfig.existNum) then --新增
				BattleCore.ds("BuffController:addBuff 新增", buff.id)
				table.insert(self._buffsList, buff)
				isProcessed = true
			end
		end
		if (not isProcessed) then
			local curBuff = groupList[1]
			local remainRound = curBuff:getRemainRounds()
			---优先级比较高或者剩余回合为0时，替换对应的buff
			if (curBuff.order ~= -1 and (buff.order >= curBuff.order or remainRound == 0)) then
				BattleCore.ds("BuffController:addBuff 替换", buff.id)
				self:removeBuff(curBuff)
				table.insert(self._buffsList, buff)
			end
		end
	else
		-- LuaLogger.ds("BuffController:addBuff 新增2", buff.id)
		table.insert(self._buffsList, buff) --新增
	end

	-- if (buffIndex > 0 and buffConfig and buffConfig.Effect ~= "") then
	-- 	self._owner:addBuffEffectReport(buffIndex, buffConfig.Effect, delay)
	-- end

	self._owner:SetRoleTag(GE.ActionTagType.BuffHasChange)
	self._owner:setBuffChangeChangeFlag(true)
	buff:setOwner(self._owner.id)
	local buffHandler = BattleCore.getBuffHandler()
	buffHandler:checkBuffAffixes(self._owner, buff, nil, delay)
	self._owner:updateAttributeBaseValue()
	self._owner:updateAttributeTotalValue()
	self:updateAllCacheFiled()
end

---移除Buff
---@param buff Buff
function BuffController:removeBuff(buff)
	local listIndex
	for index, ibuff in ipairs(self._buffsList) do
		if (ibuff.id == buff.id) then
			listIndex = index
			break
		end
	end
	if listIndex then
        self:removeBuffByIndex(listIndex)
    else
        BattleCore.ds("BuffController:移除buff, 未能找到对应id", buff.id)
	end
end

function BuffController:removeBuffByIndex(listIndex, delay)
	local buff = self._buffsList[listIndex]
    local buffHandler = BattleCore.getBuffHandler()
	buffHandler:removeBuffAffix(self._owner, buff)
    table.remove(self._buffsList, listIndex)
	self._owner:SetRoleTag(GE.ActionTagType.BuffHasChange)
	self._owner:setBuffChangeChangeFlag(true)
	self._owner:updateAttributeBaseValue()
	self._owner:updateAttributeTotalValue()
	self:updateAllCacheFiled()
end

---通过Tags移除Buff
---@param tags table tag list
function BuffController:removeBuffByTags(tags, count, delay)
	if (not count) then
		count = 99
	end
	local removeCnt = 0
	for _, tag in ipairs(tags) do
		local buffCount = #self._buffsList
		for i = buffCount, 1, -1 do
			if (self._buffsList[i]:isTagExist(tag)) then
				self:removeBuffByIndex(i, delay)
				removeCnt = removeCnt + 1
				if (removeCnt >= count) then
					return
				end
			end
		end
	end
end

---通过Tags获取Buff数组
---@param tags table tag list
---@return Buff[] Buff数组
function BuffController:getBuffsByTags(tags)
	local buffs = {}
	for _, tag in ipairs(tags) do
		for _, buff in ipairs(self._buffsList) do
			if (buff:isTagExist(tag)) then
				table.insert(buffs, buff)
			end
		end
	end
	return buffs
end

---通过GroupId获取Buff数组
---@param groupId integer 组id
---@return Buff[] Buff数组
function BuffController:getBuffsByGroupId(groupId)
	local buffs = {}
	for _, buff in ipairs(self._buffsList) do
		if (groupId == buff.groupId) then
			table.insert(buffs, buff)
		end
	end
	return buffs
end

---获取特殊属性
---@param attribType string 属性类型
---@return number
function BuffController:getExAttrib(attribType)
	local exAttrib = 0
	for _, buff in ipairs(self._buffsList) do
		exAttrib = exAttrib + buff:getExAttrib(attribType)
	end
	return exAttrib
end

---获取特殊属性
---@param attribType AttribType 属性类型
---@return integer|number
function BuffController:getFormOtherExAttrib(attribType)
    local exAttrib = 0
    for _, buff in ipairs(self._buffsList) do
        exAttrib = exAttrib + buff:getFromOtherAttrib(attribType)
    end
	---除六维以外的属性不需要取整
	if attribType <= 10 and attribType ~= GE.AttribType.BaseDamageRate then
		exAttrib = math.floor(exAttrib)
	end
    return exAttrib
end

---获取技能额外选择范围
---@param searchType SkillRangeChangeType
---@return integer
function BuffController:getExSkillSelectRange(searchType)
    local exAttrib = 0
    for _, buff in ipairs(self._buffsList) do
        exAttrib = exAttrib + buff:getSkillSelectRangeChangeValue(searchType)
    end
    return exAttrib
end

---获取技能额外覆盖范围
---@param searchType SkillRangeChangeType
---@return integer
function BuffController:getExSkillCoverRange(searchType)
    local exAttrib = 0
    for _, buff in ipairs(self._buffsList) do
        exAttrib = exAttrib + buff:getSkillCoverRangeChangeValue(searchType)
    end
    return exAttrib
end

---获取替换的主动技能
---@return table<integer, integer>
function BuffController:getReplaceSkillList()
    local result = {}
    for _, buff in ipairs(self._buffsList) do
        local l = buff:getReplaceActiveSkillList()
		if l then
			tablex.merge(result, l)
		end
    end
    return result
end

---获取替换的被动技能
---@return table<integer, integer>
function BuffController:getReplacePassiveSkillList()
    local result = {}
    for _, buff in ipairs(self._buffsList) do
        local l = buff:getReplacePassiveSkillList()
        if l then
            tablex.merge(result, l)
        end
    end
    return result
end

---获取新增的被动技能
---@return integer[]
function BuffController:getAdditionalPassiveSkillList()
	---@type integer[]
	local result = {}
    for _, buff in ipairs(self._buffsList) do
        local l = buff:getAdditionalPassiveSkillList()
        if l then
            result = tablex.combine(result, l)
        end
    end
    return result
end

---获取舰种修正值
---@param restraintType integer
function BuffController:getRestraintRatio(restraintType)
    local result = 0
    for _, buff in ipairs(self._buffsList) do
        local v = buff:getRestraintRatioList(restraintType) or 0
		result = result + v
    end
    return result
end

---获取地形补正修正值
---@param terrainType integer[]
function BuffController:getTerrainRatio(terrainType)
    local result = 0
    for _, buff in ipairs(self._buffsList) do
        local v = buff:getTerrainRatioList(terrainType) or 0
        result = result + v
    end
    return result
end

---获取地形移动消耗修正值
---@return table<integer,integer>
function BuffController:getTerrainMoveCost()
    return self.moveCostOffsetDic
end

function BuffController:updateTerrainMoveCost()
	self.moveCostOffsetDic = {}
    for _, buff in ipairs(self._buffsList) do
        local v = buff:getMoveCostOffset()
        if v then
			for key, value in pairs(v) do
				if not self.moveCostOffsetDic[key] then
					self.moveCostOffsetDic[key] = 0
				end
                self.moveCostOffsetDic[key] = self.moveCostOffsetDic[key] + value
			end
		end
    end
end

---刷新获得的buff回合数修正值
function BuffController:updateAddBuffRoundOffset()
	self.addBuffRoundOffsetDic = {}
	for _, buff in ipairs(self._buffsList) do
        local v = buff:getAddBuffRoundOffset()
        if v then
			for key, value in pairs(v) do
				if self.addBuffRoundOffsetDic[key] == nil then
					self.addBuffRoundOffsetDic[key] = 0
				end
                self.addBuffRoundOffsetDic[key] = self.addBuffRoundOffsetDic[key] + value
			end
		end
    end
end

---获取被添加的buff回合数修正值
---@param buffTags integer[]
---@return integer
function BuffController:getAddBuffRoundOffset(buffTags)
	local offset = 0
	if next(self.addBuffRoundOffsetDic) == nil or not buffTags then
		return offset
	end
	for _, value in ipairs(buffTags) do
		local dicValue = self.addBuffRoundOffsetDic[value]
		if dicValue then
			offset = dicValue
			break
		end
	end
	return offset
end

---刷新添加的buff回合数修正值
function BuffController:updateSetBuffRoundOffset()
	self.setBuffRoundOffsetDic = {}
	for _, buff in ipairs(self._buffsList) do
        local v = buff:getSetBuffRoundOffset()
        if v then
			for key, value in pairs(v) do
				if self.setBuffRoundOffsetDic[key] == nil then
					self.setBuffRoundOffsetDic[key] = 0
				end
                self.setBuffRoundOffsetDic[key] = self.setBuffRoundOffsetDic[key] + value
			end
		end
    end
end

---获取到添加的buff回合数修正值
---@param buffTags integer[]
---@return integer
function BuffController:getSetBuffRoundOffset(buffTags)
	local offset = 0
	if next(self.setBuffRoundOffsetDic) == nil or not buffTags then
		return offset
	end
	for _, value in ipairs(buffTags) do
		local dicValue = self.setBuffRoundOffsetDic[value]
		if dicValue then
			offset = dicValue
			break
		end
	end
	return offset
end

---按技能标签获取技能选择范围修正值
---@param skillTag integer[] 技能标签
function BuffController:getSkillSelectRangeChangeBySkillTag(skillTag)
	local changeValue = 0
	for _, buff in ipairs(self._buffsList) do
		changeValue = changeValue + buff:getSkillSelectRangeChangeBySkillTag(skillTag)
	end
	return changeValue
end

---更新保持回合数不变的buff标签字典
function BuffController:updateCacheKeepBuffRoundByTags()
	---@type table<integer, integer[]> key:buffTag, value:buffIdDic<buffId, true>
	self._cacheKeepBuffRoundDic = {}
	for _, buff in ipairs(self._buffsList) do
		local keepBuffRoundDic = buff:getHasKeepBuffRoundDic()
		if keepBuffRoundDic and buff:checkBuffCondition() then
			for key, _ in pairs(keepBuffRoundDic) do
				if not self._cacheKeepBuffRoundDic[key] then
					self._cacheKeepBuffRoundDic[key] = {}
				end
				local dic = self._cacheKeepBuffRoundDic[key]
				dic[#dic + 1] = buff.id
			end
		end
	end
	return self._cacheKeepBuffRoundDic
end

---更新所有缓存字段
function BuffController:updateAllCacheFiled()
	self:updateTerrainMoveCost()
	self:updateAddBuffRoundOffset()
	self:updateSetBuffRoundOffset()
	self:updateCacheKeepBuffRoundByTags()
end

---获取免疫列表
function BuffController:getImmuneList(type)
	local immuneList = {}
	for _, buff in ipairs(self._buffsList) do
		local list = buff:getImmuneList(type)
		immuneList = tablex.combine(immuneList, list)
	end
	return immuneList
end

---检测是否含有禁疗buff
function BuffController:checkCanHealth()
    local r, curBuff = self:checkHasEffectByEffectType(GE.SkillAffixType.BanHealth)
    r = not r
	return r
end

---检测是否强制保留1滴血
function BuffController:checkMustLeftOneHP()
    local r, curBuff = self:checkHasEffectByEffectType(GE.SkillAffixType.MustLeftOneHp)
	return r, curBuff
end

---检测是否眩晕
function BuffController:checkCanDoAction()
    local r, curBuff = self:checkHasEffectByEffectType(GE.SkillAffixType.CanNotDoAction)
    r = not r
    return r
end

---检测是否有护卫
---@return boolean, Buff?
function BuffController:checkHasGuard()
    local r, curBuff = self:checkHasEffectByEffectType(GE.SkillAffixType.guardTarget)
    return r, curBuff
end

---检测是否有无视护卫
---@return boolean, Buff?
function BuffController:checkHasIgnoreGuard()
    local r, curBuff = self:checkHasEffectByEffectType(GE.SkillAffixType.IgnoreGuard)
    return r, curBuff
end

---检测是否有无法使用主动技能
---@return boolean, Buff?
function BuffController:checkHasCanNotUseActiveSkill()
    local r, curBuff = self:checkHasEffectByEffectType(GE.SkillAffixType.CanNotUseActiveSkill)
    return r, curBuff
end

---检测是否有无视敌方占据的格子,拥有该buff时可以穿过敌方格子
---@return boolean, Buff?
function BuffController:checkHasIgnoreEnemyBlock()
	local r, curBuff = self:checkHasEffectByEffectType(GE.SkillAffixType.IgnoreEnemyBlock)
	return r, curBuff
end

---@param exParam integer[][]?
---@param damageType SkillDamage?
---@param effectTag integer[]?
---@return boolean
function BuffController:_checkBuffDamageFilter(exParam, damageType, effectTag)
	if not exParam then
		return false
	end
	local r = false
	local buffDamageType = exParam[1] or {}
	local buffEffectTag = exParam[2] or {}
	if type(buffDamageType) ~= "table" or type(buffEffectTag) ~= "table" then
		return r
	end
	if buffDamageType and damageType then
		for _, t in ipairs(buffDamageType) do
			if t == damageType or t == 3 then
				r = true
				break
			end
		end
	end
	if r == false and effectTag and buffEffectTag then
		for _, tag in ipairs(effectTag) do
			if tablex.contains(buffEffectTag, tag) then
				r = true
				break
			end
		end
	end
	return r
end

---@param damageType SkillDamage? 技能伤害类型
---@param effectTag integer[]? 效果伤害来源标签
---@return boolean, Buff? 
function BuffController:checkHasCanNotBeDamage(damageType, effectTag)
	local r = false
	local curBuff = nil
	local effectType = GE.SkillAffixType.CanNotBeDamage
	for _, buff in ipairs(self._buffsList) do
		if buff:checkBuffTypeExist(effectType) and buff:checkBuffCondition() then
			r = self:_checkBuffDamageFilter(buff:getExParam1(), damageType, effectTag)
			if r then
				curBuff = buff
				break
			end
		end
	end
	return r, curBuff
end

---@param damageType SkillDamage? 技能伤害类型
---@param effectTag integer[]? 效果伤害来源标签
---@return boolean, Buff?, integer?, number?
function BuffController:checkHasTransferDamageToBuffSource(damageType, effectTag)
	local effectType = GE.SkillAffixType.TransferDamageToBuffSource
	for _, buff in ipairs(self._buffsList) do
		if buff:checkBuffTypeExist(effectType) and buff:checkBuffCondition() then
			if self:_checkBuffDamageFilter(buff:getExParam1(), damageType, effectTag) then
				local exParam1 = buff:getExParam2()
				local transferRule = exParam1 and exParam1[1] or nil
				local transferRatio = exParam1 and exParam1[2] or nil
				if transferRule and transferRatio and transferRatio > 0 then
					return true, buff, transferRule, transferRatio
				end
			end
		end
	end
	return false, nil, nil, nil
end

---@param effectType SkillAffixType
---@return boolean, Buff?
function BuffController:checkHasEffectByEffectType(effectType)
	local r = false
	local curBuff = nil
    for _, buff in ipairs(self._buffsList) do
        if buff:checkBuffTypeExist(effectType) and buff:checkBuffCondition() then
			r = true
			curBuff = buff
			break
        end
    end
	return r, curBuff
end

---@param isAddAffix boolean 是否是添加光环效果
function BuffController:checkHaloBuff(isAddAffix)
    local buffHandler = BattleCore.getBuffHandler()
    for _, buff in ipairs(self._buffsList) do
        buffHandler:checkHaloBuff(self._owner, buff, isAddAffix)
    end
end

function BuffController:removeHaloTypeBuff()
    for i = #self._buffsList, 1, -1 do
		local buff = self._buffsList[i]
        if buff.configData.buffType == GE.BuffType.Block then
            self:removeBuffByIndex(i, nil)
        end
    end
end

return BuffController------------------------------------