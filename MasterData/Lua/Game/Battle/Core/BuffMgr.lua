--
-- Author:luqucheng
-- Date: 2019-10-22 11:15:31
--
local Buff = import('Game.Battle.Core.Buff')
local BuffMgr = Class("BuffMgr")

--@RefType [Game.Battle.Core.Buff#Buff<>]
BuffMgr._buffs = nil

--@RefType [Game.Battle.Entity.Role#Role]
BuffMgr.owner = nil

--对应Constants.StatusAbility
BuffMgr.statusAbility = nil--当前buff决定的能力状态，是否可以行动，放技能等

BuffMgr._needRefreshAttr = false
BuffMgr._needRefreshStatus= false
BuffMgr._needRefreshShield = false
BuffMgr._needRefreshUnique = false
BuffMgr._needRefreshScreen = false

BuffMgr._triggerDic = nil
BuffMgr._endTriggerDic = nil
function  BuffMgr:__init(owner)
    self.owner = owner
    self._buffs = {}
    self.statusAbility = {}
    self._triggerDic = {}
    self._triggerDic[1] = {}
    self._triggerDic[2] = {}
    self._triggerDic[3] = {}
    self._endTriggerDic = {}
    self._endTriggerDic[1] = {}
    self._endTriggerDic[2] = {}
    self._endTriggerDic[3] = {}
    for k,v in pairs(Constants.StatusAbility) do
        self.statusAbility[k] = true
    end
    self.specialStatusId2InfoDict = {}     --特殊状态信息

    self.lockAttrIds = {}   -- 锁定属性id
end

--@buffData: [Game.Battle.Data.BuffData#BuffData]
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BuffMgr:AddBuff( attacker, buffData, layNum, effectParams )
    --如果目标死亡,不再执行
    if self.owner:IsDead() then
        return
    end

    --判定效果命中和抵抗
    local isHit, isDodge = Core:CheckEffectHit(attacker, self.owner, buffData.effectRate)
    if not isHit then
        RecordMgr:AddRecord(RecordMgr.TagRecord.New(isDodge and Constants.RecordType.DodgeBuff or Constants.RecordType.MissBuff, self.owner.id))
        return
    end

    --@TODO 2019-10-29 18:27:01 buff护佑效果
    --buff护佑
    --buff覆盖叠加
    --找到buff第一个效果的类型
    local firstEffect = buffData.effects[1]
    local mainEffectType = buffData.mainEffectType
    local subEffectType = buffData.subEffectType
    local miniEffectType = buffData.miniEffectType
    -- local buffEffectData = Core:GetBuffEffectData(firstEffect, buffData.star, buffData.lv)
    -- if buffEffectData then
    --     mainEffectType = buffEffectData.mainEffectType
    --     subEffectType = buffEffectData.subEffectType
    --     miniEffectType = buffEffectData.miniEffectType
    -- end

    --阵营唯一判定
    if buffData.isUniqueAll then
        local hasOther = false
        local uniqueBuff = nil
        local uniqueBuffOwner = nil
        local rs = BattleMgr:GetAliveRoles(self.owner.camp)
        for i,role in ipairs(rs) do
            role.buffMgr:WalkAllBuff(function ( b )
                if b.data.isUniqueAll and Core:IsBuffType(b, mainEffectType, subEffectType, miniEffectType) then
                    --找到了，后面不用找了，buff不能加
                    hasOther = true
                    uniqueBuff = b
                    uniqueBuffOwner = role
                    return true
                end
            end)
        end
        if hasOther then
            --判断叠覆盖还是独立
            if buffData.sameBuffStackingType == Constants.BuffLayType.Independence then
                printError("阵营唯一buff 叠加方式不能配置为独立 "..tostring(buffData.id))
                return
            elseif buffData.sameBuffStackingType == Constants.BuffLayType.Cover then
                --覆盖之前先删除
                uniqueBuffOwner.buffMgr:RemoveBuff(uniqueBuff, nil, nil, true)
                return self:ForceAddBuff(attacker, buffData, layNum, effectParams)
            elseif buffData.sameBuffStackingType == Constants.BuffLayType.Stack then
                --处理叠加
                layNum = layNum or 1
                uniqueBuff:AddLayer(layNum)
                if uniqueBuff.remainRound < buffData.round then
                    uniqueBuffOwner.buffMgr:ChangeBuffDuration(uniqueBuff, buffData.round)
                end
                -- sameIdBuff.remainRound = buffData.round
                RecordMgr:AddRecord(RecordMgr.ChangeBuffRecord.New(uniqueBuff))
                uniqueBuffOwner.buffMgr:CheckUpdate(uniqueBuff)
                BattleMgr:Trig(uniqueBuffOwner, Constants.TriggerMainType.BuffAdd, {buff = uniqueBuff}, attacker)
                return uniqueBuff
            elseif buffData.sameBuffStackingType == Constants.BuffLayType.Reject then
                return
            else
                printError("阵营唯一buff 需要指定有同id的Buff存在时的叠加方式 "..tostring(buffData.id))
                return
            end
            return
        end
    end

    -- print("AddBuff", self.owner.id, #self._buffs)
    local sameIdBuff = nil
    layNum = layNum or 1
    self:WalkAllBuff(function ( buff )
        if buff.data.id == buffData.id then
            sameIdBuff = buff
            return true
        end
    end)

    if sameIdBuff then
        --判断叠覆盖还是独立
        if buffData.sameBuffStackingType == Constants.BuffLayType.Independence then

        elseif buffData.sameBuffStackingType == Constants.BuffLayType.Cover then
            --覆盖之前先删除
            self:RemoveBuff(sameIdBuff, nil, nil, true)
        elseif buffData.sameBuffStackingType == Constants.BuffLayType.Stack then
             --处理叠加
            sameIdBuff:AddLayer(layNum)
            if sameIdBuff.remainRound < buffData.round then
                self:ChangeBuffDuration(sameIdBuff, buffData.round)
            end
            -- sameIdBuff.remainRound = buffData.round
            RecordMgr:AddRecord(RecordMgr.ChangeBuffRecord.New(sameIdBuff))
            self:CheckUpdate(sameIdBuff)
            BattleMgr:Trig(self.owner, Constants.TriggerMainType.BuffAdd, {buff = sameIdBuff}, attacker)
            return sameIdBuff
        elseif buffData.sameBuffStackingType == Constants.BuffLayType.Reject then
            return
        end
    else
        --如果buff本身是独立型的，就直接添加
        if buffData.stackingType == Constants.BuffLayType.Independence then
        
        else
            --如果buff本身是覆盖类的，那就要找同样覆盖类的buff，相同类型，覆盖类的buff只会有一个
            local beRejected = false
            self:WalkAllBuff(function ( buff )
                -- print("----------------buff", buff.mainEffectType, buff.subEffectType, buff.miniEffectType)
                -- print("----------------buffData", mainEffectType, subEffectType, miniEffectType)
                if buff.mainEffectType == mainEffectType
                and buff.subEffectType == subEffectType
                and buff.miniEffectType == miniEffectType then
                    -- 寻找是否有相同类型但是为覆盖型的buff
                    if buffData.stackingType == Constants.BuffLayType.Cover then
                        -- 移除老buff
                        self:RemoveBuff(buff, nil, nil, true)
                        -- 添加新buff
                        return true
                    elseif buffData.stackingType == Constants.BuffLayType.Reject then
                        beRejected = true
                        
                        return true
                    end
                end
            end)
            if beRejected then
                -- print("beRejected")
                return
            end
        end
    end
    --没有叠加独立覆盖情况下，直接加上这个buff
    return self:ForceAddBuff(attacker, buffData, layNum, effectParams)
end

function BuffMgr:AddUseTag(  )
    self:WalkAllBuff(function ( b )
        b.useTag = true
    end)
end

function BuffMgr:RemoveUseTag(  )
    self:WalkAllBuff(function ( b )
        b.useTag = false
    end)
end

--回合开始时调用
function BuffMgr:TurnStart(  )
end

--回合结束调用
function BuffMgr:TurnEnd( camp )
    local Dot = Constants.BuffType.Dot
    local Hot = Constants.BuffType.Hot

    --dot,hot的生效
    if camp == self.owner.camp then
        self:DoDot()
    end

    -- 如果携带者身上有buff效果11,3,1，那么指定buff在TurnEnd时不会减少回合数
    local effectList = {}
    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect:IsType(11, 3, 1) then
            local effect = {}
            effect.buffType = buffEffect.data.effectNum1[1]
            effect.excludeMainEffectTypeList = {}
            for i, type in ipairs(buffEffect.data.effectNum1) do
                if i > 1 then
                    table.insert(effect.excludeMainEffectTypeList, type)
                end
            end
            table.insert(effectList, effect)
        end
    end)


    self:WalkAllBuff(function ( b )
        if b.useTag == nil or b.useTag == false then
            return false
        end
        -- 判断buff是否满足11,3,1的条件
        local thisBuffType =  b.data.buffType
        local satisfy = false
        for i, effect in ipairs(effectList) do
            if effect.buffType == thisBuffType then
                if not table.isContain(effect.excludeMainEffectTypeList, b.mainEffectType) then
                    satisfy = true
                    break
                end
            elseif effect.buffType == 3 then
                if thisBuffType == 1 or thisBuffType == 2 then
                    if not table.isContain(effect.excludeMainEffectTypeList, b.mainEffectType) then
                        satisfy = true
                        break
                    end
                end
            end
        end
        if satisfy then
            return false
        end
        if b.useTag then
            self:ChangeBuffDuration(b, b.remainRound - 0.5)
            b:OnChangeDuration(- 0.5)
        end
    end)

    --清除失效buff
    local ReadyToRemove = Constants.BuffState.ReadyToRemove
    for i,v in fipairs(self._buffs) do
        if v.state == ReadyToRemove then
            self:RemoveTriggerDic(v)
            table.remove(self._buffs, i)
        end
    end

    self:AfterChangeBuff()
end

--@buff: [Game.Battle.Core.Buff#Buff]
function BuffMgr:ChangeBuffDuration( buff, round, checkMax )
    checkMax = checkMax or false
    buff.remainRound = round
    if checkMax then
        buff.remainRound = math.min(buff.data.round, buff.remainRound)
    end
    if buff.remainRound <= 0.1 then
        self:RemoveBuff(buff, nil, true)
    else
        RecordMgr:AddRecord(RecordMgr.ChangeBuffRecord.New(buff))
    end
end

function BuffMgr:GetLastBuff(fIndex)
    if self._buffs and #self._buffs > 0 then
        return self._buffs[#self._buffs - fIndex + 1]
    else
        return nil
    end
end

function BuffMgr:SetBuffLayer( buff, layerNum, overrideMax )
    if layerNum <= 0 then
        self:RemoveBuff(buff, nil, true)
    else
        buff:SetLayer(layerNum, overrideMax)
        self:CheckUpdate(buff)
        RecordMgr:AddRecord(RecordMgr.ChangeBuffRecord.New(buff))
    end
end

function BuffMgr:AddBuffLayer(buff, layerNum, overrideMax)
    local newLayerNum = buff:AddLayer(layerNum, overrideMax)
    if newLayerNum <= 0 then
        self:RemoveBuff(buff, nil, true)
    else
        self:CheckUpdate(buff)
        RecordMgr:AddRecord(RecordMgr.ChangeBuffRecord.New(buff))
    end
end

function BuffMgr:RemoveBuff( buff, layNum, isTurnOver, noTrig )
    isTurnOver = isTurnOver and true or false
    self:WalkAllBuff(function ( b )
        if buff == b then
            if layNum and layNum < buff.layNum then
                buff:AddLayer(-layNum)
                RecordMgr:AddRecord(RecordMgr.ChangeBuffRecord.New(buff))
                self:CheckUpdate(buff)
            else
                RecordMgr:AddRecord(RecordMgr.RemoveBuffRecord.New(buff))
                if not noTrig then
                    BattleMgr:Trig(self.owner, Constants.TriggerMainType.BuffBeforeRemoved, {buff = buff, isTurnOver = isTurnOver}, self.owner)
                end
                buff.state = Constants.BuffState.ReadyToRemove
                buff:OnRemove()
                self:CheckUpdate(buff)
                if not noTrig then
                    BattleMgr:Trig(self.owner, Constants.TriggerMainType.BuffRemoved, {buff = buff, isTurnOver = isTurnOver}, self.owner)
                end
            end
            return true
        end
    end)
end

function BuffMgr:ForceAddBuff( attacker, buffData, layNum, effectParams )
    --@TODO 2019-10-29 18:27:27 添加buff时候可能会有当即计算的额外数值
    layNum = layNum or 1
    local buff = Buff.New(self.owner, attacker, buffData, layNum, effectParams)
    if effectParams and effectParams.buffOverrideValue then
        buff:SetOverrideValue(effectParams.buffOverrideValue)
    end
    table.insert(self._buffs, buff)
    local node = RecordMgr:AddRecord(RecordMgr.AddBuffRecord.New(buff))
    self:CheckUpdate(buff)
    self:AddTriggerDic(buff)
    --如果这个buff是自己给自己加的，则需要加个当回合不需要减持续时间的标记
    -- if attacker and attacker.id == self.owner.id then
    --     buff.mineFirst = true
    -- end

    BattleMgr:Trig(self.owner, Constants.TriggerMainType.BuffAdd, {buff = buff}, attacker)
    return buff, node
end

function BuffMgr:AfterChangeBuff(  )
    --处理屏蔽会影响其他类型buff，一定要放第一个
    if self._needRefreshScreen then
        Core:RefreshScreen(self)
        self._needRefreshScreen = false
    end

    --一定要放在第一个
    if self._needRefreshUnique then
        Core:RefreshUnique(self)
        self._needRefreshUnique = false
    end

    if self._needRefreshAttr then
        --监测最大血量的变更
        local maxHp = self.owner:GetAttr(Constants.AttrTypeId.Hp)
        Core:RefreshAttr(self, self.owner.attr)
        local newMaxHp = self.owner:GetAttr(Constants.AttrTypeId.Hp)
        if math.abs(maxHp - newMaxHp) > 0.001 then
            --血量上限有变化

            --当前生命保持相同百分比
            local nowHp = self.owner:GetNowHp()
            nowHp = nowHp / maxHp * newMaxHp
            nowHp = math.range(nowHp, 1, newMaxHp)
            self.owner:ForceSetNowHp(nowHp)
            RecordMgr:AddRecord(RecordMgr.ChangeMaxHpRecord.New(self.owner.id, self.owner:GetNowHp(), newMaxHp, self.owner.attr:GetOriginValue(Constants.AttrTypeId.Hp)))
        end
        self._needRefreshAttr = false
    end

    if self._needRefreshStatus then
        Core:RefreshStatus(self, self.statusAbility)
        self._needRefreshStatus = false
        RecordMgr:AddRecord(RecordMgr.SyncRoleStatusRecord.New(self.owner.id, self.statusAbility))
    end

    if self._needRefreshShield then
        self._needRefreshShield = false
        local shield = self:GetShieldValue()
        local shieldMax = self:GetShieldValueMax()
        RecordMgr:AddRecord(RecordMgr.ChangeShieldRecord.New(self.owner.id, shield, shieldMax))
    end

end

function BuffMgr:Refresh()
    self:WalkAllBuff(function ( buff )
        local isRefreshed = buff:Refresh()
        if isRefreshed then
            self:CheckUpdate(buff)
        end
    end)
    self:AfterChangeBuff()
end

function BuffMgr:WalkAllBuffEffects( func, includeDisabled )
    self:WalkAllBuff(function ( buff )
        buff:WalkAllEffects(func, includeDisabled)
    end)
end

function BuffMgr:WalkAllBuff( func, buffs, ...)
    local Active = Constants.BuffState.Active
    buffs = buffs or self._buffs
    local len = #buffs
    --为了让本次触发加上的buff不会进入触发
    for i=1,len do
        local buff = buffs[i]
        if func and buff and buff.state == Active then
            local stop = func(buff, ...)
            if stop then
                return true
            end
        end
    end
end

function BuffMgr:AddTriggerDic(buff)
    if buff.data.triggerOrder == 3 then
        self:AddTriggerDicByTriggerId(self._triggerDic[3], buff, buff.data.effectTrigger)
    elseif buff.data.triggerOrder == 2  then
        self:AddTriggerDicByTriggerId(self._triggerDic[2], buff, buff.data.effectTrigger)
    else
        self:AddTriggerDicByTriggerId(self._triggerDic[1], buff, buff.data.effectTrigger)
    end

    if buff.data.endOrder == 3 then
        self:AddTriggerDicByTriggerId(self._endTriggerDic[3], buff, buff.data.endType)
    elseif buff.data.endOrder == 2  then
        self:AddTriggerDicByTriggerId(self._endTriggerDic[2], buff, buff.data.endType)
    else
        self:AddTriggerDicByTriggerId(self._endTriggerDic[1], buff, buff.data.endType)
    end


end

function BuffMgr:AddTriggerDicByTriggerId(dic, buff, triggerId)
    if Tools.isNullKey(triggerId) then
        return
    end
    local trigData = Core:GetTriggerData(triggerId)
    local mainType = trigData.mainType
    if Tools.isNullKey(mainType) then
        return
    end
    local trigBuffs = dic[mainType] or {}
    table.insert(trigBuffs, buff)
    dic[mainType] = trigBuffs
end

function BuffMgr:RemoveTriggerDic(buff)
    if #self._triggerDic == 0 then
        return
    end
    if buff.data.triggerOrder == 3 then
        self:RemoveTriggerDicByTriggerId(self._triggerDic[3], buff, buff.data.effectTrigger)
    elseif buff.data.triggerOrder == 2  then
        self:RemoveTriggerDicByTriggerId(self._triggerDic[2], buff, buff.data.effectTrigger)
    else
        self:RemoveTriggerDicByTriggerId(self._triggerDic[1], buff, buff.data.effectTrigger)
    end

    if buff.data.endOrder == 3 then
        self:RemoveTriggerDicByTriggerId(self._endTriggerDic[3], buff, buff.data.endType)
    elseif buff.data.endOrder == 2  then
        self:RemoveTriggerDicByTriggerId(self._endTriggerDic[2], buff, buff.data.endType)
    else
        self:RemoveTriggerDicByTriggerId(self._endTriggerDic[1], buff, buff.data.endType)
    end
end

function BuffMgr:RemoveTriggerDicByTriggerId(dic, buff, triggerId)
    if Tools.isNullKey(triggerId) then
        return
    end
    local trigData = Core:GetTriggerData(triggerId)
    local mainType = trigData.mainType
    if Tools.isNullKey(mainType) then
        return
    end
    local trigBuffs = dic[mainType] or {}
    table.removebyvalue(trigBuffs, buff)
    dic[mainType] = trigBuffs
end

function BuffMgr:GetTriggerBuffs(dic, mainType)
    local trigBuffs = dic[mainType]
    if not trigBuffs then
        trigBuffs = {}
        dic[mainType] = trigBuffs
    end
    return trigBuffs
end

function BuffMgr:CheckUpdate( buff )
    --检查是不是属性变更类buff
    local BuffType = Constants.BuffType
    if buff:HasBuffEffectType(BuffType.AttributeChange) then
        self._needRefreshAttr = true
    end
    if buff:HasBuffEffectType(BuffType.Status) then
        self._needRefreshStatus = true
    end
    if buff:HasBuffEffectType(BuffType.Shield) then
        self._needRefreshShield = true
    end

    --唯一buff需要特殊处理
    if buff:HasUnique() then
        self._needRefreshUnique = true
    end

    if buff:HasBuffEffectType(BuffType.ScreenBuff) then
        self._needRefreshScreen = true
    end
end

function BuffMgr:GetBuff( uid )
    local buff
    self:WalkAllBuff(function ( v )
        if v.id == uid then
            buff = v
            return true
        end
    end)
    return buff
end


--获取增益buff的数量
function BuffMgr:GetBuffOrDebuffNum( isDebuff )
    local count = 0
    local t = checkBool(isDebuff) and Constants.BuffOrDebuff.Debuff or Constants.BuffOrDebuff.Buff
    self:WalkAllBuff(function ( v )
        if v.data.buffType == t then
            count = count + 1
        end
    end)
    return count
end

--获取增益buff的总层数
function BuffMgr:GetBuffOrDebuffLayers( isDebuff )
    local count = 0
    local t = isDebuff and Constants.BuffOrDebuff.Debuff or Constants.BuffOrDebuff.Buff
    self:WalkAllBuff(function ( v )
        if v.data.buffType == t then
            count = count + v.layNum
        end
    end)
    return count
end

function BuffMgr:HasBuffByBuffTypeID( typeID )
    local has = false
    self:WalkAllBuff(function ( v )
        if v.data.id == typeID then
            has = true
            return true
        end
    end)
    return has
end

function BuffMgr:HasBuffByBuffTypeIDAndAttackerID( typeID, AttackerID )
    local has = false
    self:WalkAllBuff(function ( v )
        if v.data.id == typeID and v.attacker and v.attacker.id == AttackerID then
            has = true
            return true
        end
    end)
    return has
end

function BuffMgr:GetBuffLayNumByBuffTypeID( typeID )
    local layNum = 0
    self:WalkAllBuff(function ( v )
        if v.data.id == typeID then
            layNum = layNum + v.layNum
        end
    end)
    return layNum
end

function BuffMgr:GetBuffNumByTypeId(typeId)
    local num = 0
    self:WalkAllBuff(function ( v )
        if v.data.id == typeId then
            num = num + 1
        end
    end)
    return num
end

function BuffMgr:GetBuffTypeNumber( main, sub, mini, buffType )
    local num = 0
    buffType = buffType or 0
    self:WalkAllBuff(function ( v )
        if self:IsBuffByType(v, main, sub, mini, buffType) then
            num = num + 1
        end
    end)
    return num
end

function BuffMgr:GetBuffTypeLayNum(main, sub, mini, buffType)
    local layNum = 0
    buffType = buffType or 0
    self:WalkAllBuff(function ( v )
        if self:IsBuffByType(v, main, sub, mini, buffType) then
            layNum = layNum + v.layNum
        end
    end)
    return layNum
end

function BuffMgr:HasBuffByType( main, sub, mini, buffType )
    buffType = buffType or 0
    mini = mini or 0
    local has = false
    self:WalkAllBuffEffects(function ( v )
        if self:IsBuffByType2(v.data.mainEffectType, v.data.subEffectType, v.data.miniEffectType, v.buff.data.buffType, main, sub, mini, buffType) then
            has = true
            return true
        end
    end)
    return has
end

function BuffMgr:IsBuffByType2( checkMain, checkSub, checkMini, checkBuffType, main, sub, mini, buffType )
    if (main == 0 or checkMain == main)
            and (sub == 0 or checkSub == sub)
            and (mini == 0 or checkMini == mini)
            and (buffType == 0 or buffType == checkBuffType)
        then
        return true
    end

    return false
end

function BuffMgr:IsBuffByType( buff, main, sub, mini, buffType )
    if (main == 0 or buff.mainEffectType == main)
            and (sub == 0 or buff.subEffectType == sub)
            and (mini == 0 or buff.miniEffectType == mini)
            and (buffType == 0 or buffType == buff.data.buffType)
        then
        return true
    end

    return false
end

--触发角色的触发器，需传入触发的环境
function BuffMgr:Trig( trigMainType, trigData, target )
    --非死亡触发器，触发器持有者死亡后不再触发
    if self.owner:IsDead() and trigMainType ~= Constants.TriggerMainType.Dead then
        return
    end
    for i, v in ipairs(self._triggerDic) do
        --死亡结算会导致这个表变空,需要判断
        if self._triggerDic[i] ~= nil then
            local trigBuffs = self:GetTriggerBuffs(self._triggerDic[i], trigMainType)
            if #trigBuffs > 0 then
                --遍历身上所有的Buff，检查效果触发和移除触发
                self:WalkAllBuff(self.TrigOneBuff, trigBuffs, self, trigMainType, trigData, target)
            end
        end


    end
    for i, v in ipairs(self._endTriggerDic) do
        --死亡结算会导致这个表变空,需要判断
        if self._endTriggerDic[i] ~= nil then
            local endTrigBuffs = self:GetTriggerBuffs(self._endTriggerDic[i], trigMainType)
            if #endTrigBuffs > 0 then
                --遍历身上所有的Buff，检查效果触发和移除触发
                self:WalkAllBuff(self.TrigEndOneBuff, endTrigBuffs, self, trigMainType, trigData, target)
            end
        end
    end

end

--- 触发满足条件的2类buff
---@param func any
---@param trigData any
---@param target any
function BuffMgr:TrigBuffType2(func, trigData, target)
    local mainType = Constants.TriggerMainType.Direct
    for i, v in ipairs(self._triggerDic) do
        --死亡结算会导致这个表变空,需要判断
        local dic = self._triggerDic[i]
        if isNotNull(dic) then
            local trigBuffs = dic[mainType]
            if not trigBuffs then
                trigBuffs = {}
                dic[mainType] = trigBuffs
            end
            local selectBuffs = {}
            for i, buff in ipairs(trigBuffs) do
                if buff.data.refresh == 2 then
                    table.insert(selectBuffs, buff)
                end
            end
            self:WalkAllBuff(function(buff)
                if buff:IsInCd(target) then
                    return
                end
                local isTrigEffect = buff:TrigEffect(mainType, trigData, target)
                if isTrigEffect then
                    buff:OnTrigged(target)
                    buff:WalkAllEffects(func)
                end
            end, selectBuffs)
        end
    end
end

function BuffMgr.TrigOneBuff(buff, self, trigMainType, trigData, target)

    if buff:IsInCd(target) then
        if BattleMgr.BATTLE_BUFF_SHOW_LOG then
            local ownerId = self.owner.id or -1
            local buffId = buff.buffID or -1
            print(BattleMgr:GetBuffTrigSpan() .. "[Buff] 检测-- cd中 ", trigMainType, string.format("角色: %04d",ownerId), string.format("Buff: %d",buffId))
        end
        return
    end
    local isTrigEffect, trigResultTypes, trigResultIDs, stackTimes, isFinal = buff:TrigEffect(trigMainType, trigData, target)
    if BattleMgr.BATTLE_BUFF_SHOW_LOG then
        if not isTrigEffect then
            local ownerId = self.owner.id or -1
            local buffId = buff.buffID or -1
            print(BattleMgr:GetBuffTrigSpan() .. "[Buff] 检测--", trigMainType, string.format("角色: %04d",ownerId), string.format("Buff: %d",buffId))
        end
    end
    if isTrigEffect then
        if BattleMgr:ForestallLoop(self.owner.id, buff, BattleMgr.nowTriggerRecordNode) == false then
            if BattleMgr.BATTLE_BUFF_SHOW_LOG then
                local ownerId = self.owner.id or -1
                local buffId = buff.buffID or -1
                print(BattleMgr:GetBuffTrigSpan() .. "[Buff] 检测-- 防止循环 ", trigMainType, string.format("角色: %04d",ownerId), string.format("Buff: %d",buffId))
            end
            return
        end
        if BattleMgr.BATTLE_BUFF_SHOW_LOG then
            local ownerId = self.owner.id or -1
            local buffId = buff.buffID or -1
            print(BattleMgr:GetBuffTrigSpan() .. "[Buff] 检测++", trigMainType, string.format("角色: %04d",ownerId), string.format("Buff: %d",buffId))
        end
        if BattleMgr.BATTLE_FILTER_SHOW_LOG then
            print(BattleMgr:GetBuffTrigSpan() .. "[筛选] 主条件 ".. trigMainType, " buffID ".. buff.buffID or -1, " 触发器拥有者 " .. self.owner.id, "  触发者(客体) " .. (target and target.id or "null"))
        end
        BattleMgr:AddBuffTrigSpanNum(1)

        local needProtect = buff:NeedTrigProtect()
        --添加到触发树
        local nowTriggerNode = BattleMgr:AddTriggerNode(self.owner.id, buff, trigData, BattleMgr.nowTriggerRecordNode, isFinal, needProtect)
        -- print("BuffMgr:Trig", table.toString(trigResultTypes, "trigResultTypes"), table.toString(trigResultIDs, "trigResultIDs"))
        buff:OnTrigged(target)

        --在触发时候刷新一下buff,不然可能出现一些眩晕结束后之类无法触发的奇怪情况
        self:AfterChangeBuff()

        --找到目标
        local t = self.owner
        local TriggerClickType = Constants.TriggerClickType
        if buff.data.triggerClickType == TriggerClickType.Target then
            t = target or self.owner
        elseif buff.data.triggerClickType == TriggerClickType.Owner then
            t = self.owner
        end

        if BattleMgr.BATTLE_FILTER_SHOW_LOG then
            if buff.data.triggerClickType == TriggerClickType.Target
            or buff.data.triggerClickType == TriggerClickType.Owner then
                print(BattleMgr:GetBuffTrigSpan().."[筛选] 主目标     目标选定规则 ".. buff.data.triggerClickType, "  获取主目标结果 ", "id:".. (t and t.id or "null"))
            else
                print(BattleMgr:GetBuffTrigSpan().."[筛选] 主目标     目标选定规则 ".. buff.data.triggerClickType, "  默认触发器拥有者为主目标 ", "id:".. (t and t.id or "null"))
            end
        end

        --触发技能或者效果
        --触发的技能和效果的等级跟本身buff的等级相同
        local skillAndBuffEffect = function (effectID, effectType, stackTime)
            local targets
            if buff.data.effectTarget == -1 then
                if isNull(trigData.skillRec) then
                    printError(string.format("buff触发时没有需要的技能数据，不能使用目标类型-1  %d", checkNumber(buff.data.id)))
                    targets = {}
                else
                    targets = trigData.skillRec.mainTargets or {}
                    if BattleMgr.BATTLE_FILTER_SHOW_LOG then
                        local ts = "ids:"
                        for i, t in ipairs(targets) do
                            ts = ts..t.id..","
                        end
                        print(BattleMgr:GetBuffTrigSpan().."[筛选] 效果目标   触发器目标类型 ".. buff.data.effectTarget, "  跟随技能目标 ", ts)
                    end
                end
            else
                targets = Core:SelectTargets(buff.data.effectTarget, self.owner, target or self.owner, BattleMgr.roles)
                if BattleMgr.BATTLE_FILTER_SHOW_LOG then
                    local ts = "ids:"
                    for i, t in ipairs(targets) do
                        ts = ts..t.id..","
                    end
                    print(BattleMgr:GetBuffTrigSpan().."[筛选] 效果目标   触发器目标类型 " .. buff.data.effectTarget, "  获取效果目标结果 ", ts)
                end
            end
            -- print("OnRoleDead BuffMgr:Trig", effectID, effectType, stackTime, buff.data.triggerClickType, target.id)
            local damageRecs = {}
            if trigData.damageRec then
                table.insert(damageRecs, trigData.damageRec)
            end
            BattleMgr:HandleSkillEffect(
            {
                attacker = self.owner,
                mainTarget = t,
                star = buff.data.star,
                lv = buff.data.lv,
                targets = targets,
                skillEffectID = effectID,
                layNum = stackTime,
                damageRecs = damageRecs,
                effectType = effectType,
                nowTriggerNode = nowTriggerNode,
                trigBuff = buff,        -- 触发器
                trigData = trigData,    -- 触发数据
            })

        end
        local switch = {
            [Constants.EffectType.SkillEffect] = skillAndBuffEffect,
            [Constants.EffectType.Buff] = skillAndBuffEffect,
            [Constants.EffectType.PassiveSkill] = function ( effectID, effectType, stackTime )

                printInfo('trig skill:%s', effectID)
                if target and target.id ~= self.owner.id and not target:CanBeSelected() then
                    --非自己切不能被选中的情况下无法触发
                    return
                end

                local skill = self.owner:GetSkill(effectID, buff.data.star, buff.data.lv)

                --被动技能不再支持ai目标选择，字段已经移到技能卡牌表
                -- if buff.data.triggerClickType == TriggerClickType.AI then
                --     t = AI:ChooseSkillTarget( self.owner, skill )
                -- end

                BattleMgr:HandleSkill( self.owner, t, skill ,nil   )
            end,
            [Constants.EffectType.SkillCard] = function ( effectID, effectType, stackTime )

                t = Core:BuffTriggerSkillSelectTarget(buff, effectID, self.owner, target)

                local skillCardData = Core:GetSkillCardData(effectID)
                local isSPSkill = skillCardData.skillType == 3

                local spSkillStar = 1
                local roles = BattleMgr.roles
                for i, role in ipairs(roles) do
                    local skillCardId = role.skillCardInfos[0].id
                    if checkNumber(skillCardId) == checkNumber(effectID) then
                        spSkillStar = checkNumber(role.ultraStar)
                    end
                end

                --处于技能作用中时，加入技能树等候
                if BattleMgr.isInSkill then
                    BattleMgr:AddTrigSkillCard(self.owner, t, effectID, isSPSkill and spSkillStar or buff.data.star , nowTriggerNode )
                else
                    --否则直接释放
                    BattleMgr:HandleSkillCard(self.owner, t, effectID, isSPSkill and spSkillStar or buff.data.star , nil , nil , nowTriggerNode)
                end
            end
        }
        
        RecordMgr:AddRecordStart(RecordMgr.TriggerRecord.New(buff.id, buff.buffID, buff.owner.id, t.id))
        local selfNode = RecordMgr:GetNowNode()
        for i,effectID in ipairs(trigResultIDs) do
            local effectType = trigResultTypes[i]
            switch[effectType](effectID, effectType, stackTimes[i])
        end

        BattleMgr:RollbackTriggerNode(nowTriggerNode.parent)
        BattleMgr:AddBuffTrigSpanNum(-1)

        RecordMgr:AddRecordEnd()
    end
end




function BuffMgr.TrigEndOneBuff(buff, self, trigMainType, trigData, target)
    local isTrigEnd = buff:TrigEnd(trigMainType, trigData, target)

    if isTrigEnd then
        if BattleMgr.BATTLE_BUFF_SHOW_LOG then
            local ownerId = self.owner.id or -1
            local buffId = buff.buffID or -1
            print("[Buff] 消失检测++", trigMainType, string.format("角色: %04d",ownerId), string.format("Buff: %d",buffId))
        end
        if buff.data.endNum > 0 then
            self:RemoveBuff(buff, buff.data.endNum)
        else
            self:RemoveBuff(buff)
        end
        self:AfterChangeBuff()
    else
        if BattleMgr.BATTLE_BUFF_SHOW_LOG then
            local ownerId = self.owner.id or -1
            local buffId = buff.buffID or -1
            print("[Buff] 消失检测--", trigMainType, string.format("角色: %04d",ownerId), string.format("Buff: %d",buffId))
        end
    end
end

function BuffMgr:ResetCountOnSkillTrigger(  )
    self:WalkAllBuff(function ( buff )
        buff:ResetCountOnSkillTrigger()
    end)
end

function BuffMgr:DoDot(  )
    -- 拥有11,4,1效果的时候，指定的伤害类型必暴击
    local critDmgTypes = {}
    self:WalkAllBuffEffects(function ( v )
        if self:IsBuffByType2(v.data.mainEffectType, v.data.subEffectType, v.data.miniEffectType, v.buff.data.buffType, 11, 4, 1, 0) then
            local params = v.data.effectNum1
            local dmgType = params[1]
            table.insert(critDmgTypes, dmgType)
        end
    end)

    local DotType = Constants.BuffType.Dot
    local HotType = Constants.BuffType.Hot
    self:WalkAllBuffEffects(function ( buffEffect )
        local buff = buffEffect.buff
        if buffEffect.data.mainEffectType == DotType and not self.owner:IsDead() then

            -- 清理目标角色身上记录的技能范围受击数据
            self.owner.roleContextData:ClearSkillRangeBeAtkData()

            local dmg, dmgTypeId = buffEffect:GetValue()
            local dmgData = Core:GetDamageData(dmgTypeId)

            -- 拥有11,4,1效果的时候，指定的伤害类型必暴击
            local dmgRec = nil
            if table.isContain(critDmgTypes, dmgData.id) then
                dmgRec = RecordMgr.DamageRecord.New(self.owner, buff.attacker)
                dmgRec.isCrit = true
            end

            local rec, node = BattleMgr:Damage(dmg * buff.layNum, dmgData, 0, self.owner, buff.attacker, buff.data.star, nil, dmgRec)
            --伤害类型如果是dot hot的，需要加一个标记
            rec.dotHotType = buff.buffID
            RecordMgr:ResetNodeData(node, rec:ToData())
            -- 每次dot伤害过后，移除一次被触发过的每技能大毅力
            self:RemoveTriggeredPerseverancePerSkill()

            -- 操作特殊寄存器
            if buffEffect:IsNeedOperateSpecialRegister() then
                buff.attacker.roleContextData:AddRegister1(rec.finalDamage * buffEffect:GetRegisterNum2())
            end

            ---@type DOTInfo
            local dotInfo = {
                damageRec = rec,
                buff = buff,
                buffEffect = buffEffect,
                attacker = buff.attacker,
                target = self.owner,
                mainType = buffEffect.data.mainEffectType,
                subType = buffEffect.data.subEffectType,
                miniType = buffEffect.data.miniEffectType,
            }
            BattleMgr:PushDOTStack(dotInfo)

            -- dot触发时的触发器
            BattleMgr:Trig(buff.attacker, Constants.TriggerMainType.Dot, {damageRec = rec, buff = buff}, self.owner)

            BattleMgr:PopDOTStack()
        end
    end)

    if self.owner:IsDead() then
        return true
    end

    self:WalkAllBuffEffects(function ( buffEffect )
        local buff = buffEffect.buff
        if buffEffect.data.mainEffectType == HotType then
            local dmg, dmgType = buffEffect:GetValue()
            local rec, node = BattleMgr:Heal(dmg * buff.layNum, dmgType, self.owner, buff.attacker, buff.data.star)
            --伤害类型如果是dot hot的，需要加一个标记
            rec.dotHotType = buff.buffID
            RecordMgr:ResetNodeData(node, rec:ToData())

            -- 操作特殊寄存器
            if buffEffect:IsNeedOperateSpecialRegister() then
                buff.attacker.roleContextData:AddRegister1(-rec.finalDamage * buffEffect:GetRegisterNum2())
            end
        end
    end)
end

--返回剩余伤害以及剩余的护盾量
function BuffMgr:ShieldAbsorb( dmg, dmgTypeVo, attacker )
    local needRemove = {}

    local ShieldType = Constants.BuffType.Shield
    local totalLostShield = 0
    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == ShieldType then
            local lostShield = 0
            dmg, lostShield = buffEffect:AbsorbDamage(dmg, dmgTypeVo)
            totalLostShield  = totalLostShield + lostShield
            self._needRefreshShield = true

            local value = buffEffect:GetValue()
            if value <= 0 then
                table.insert(needRemove, buffEffect.buff)
                -- self:RemoveBuff(buffEffect.buff)
                --触发护盾破除
                BattleMgr:Trig(self.owner, Constants.TriggerMainType.ShieldBroken, {buff = buffEffect.buff}, self.owner)
                BattleMgr:Trig(attacker, Constants.TriggerMainType.ShieldBroken2, {buff = buffEffect.buff}, self.owner)
            end

            --如果剩余伤害为0，则不需要继续吸收了
            if dmg <= 0 then
                return true
            end
        end
    end)

    self:AfterChangeBuff()

    -- 延迟移除buff（这样护盾呗打碎时，可以获取到当前值为0，最大值大于0的一条消息，以此判断护盾是自然消失还是被打碎）
    for i, buff in ipairs(needRemove) do
        self:RemoveBuff(buff)
    end
    self._needRefreshShield = false -- 已经AfterChangeBuff了，延迟移除的时候手动取消Refresh

    return dmg, self:GetShieldValue(), totalLostShield
end

function BuffMgr:GetShieldValue(  )
    local totalShieldValue = 0

    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == Constants.BuffType.Shield then
            --如果护盾剩余量为0，则移除护盾
            local value = buffEffect:GetValue()
            totalShieldValue = totalShieldValue + value
        end
    end)
    return totalShieldValue
end

function BuffMgr:GetShieldValueMax()
    local totalShieldValue = 0

    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == Constants.BuffType.Shield then
            --如果护盾剩余量为0，则移除护盾
            local value = buffEffect:GetValueMax()
            totalShieldValue = totalShieldValue + value
        end
    end)
    return totalShieldValue
end

--@dmgRec: [Game.Battle.Record.DamageRecord#DamageRecord]
function BuffMgr:DamageChange(baseDmg, finalDmg, damageTypeVo, effectLv, dmgRec, attacker )
    local DamageChangeType = Constants.BuffType.DamageChange 
    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == DamageChangeType then
            finalDmg = buffEffect:ChangeDamage(baseDmg, finalDmg, damageTypeVo, effectLv, dmgRec, attacker)
        end
    end)

    return finalDmg
end

--@dmgRec: [Game.Battle.Record.DamageRecord#DamageRecord]
function BuffMgr:HealChange(healValue, dmgRec, attacker )
    local HealChangeType = Constants.BuffType.HealChange
    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == HealChangeType then
            healValue = buffEffect:ChangeHeal(healValue, dmgRec, attacker)
        end
    end)

    return healValue
end

--- 元素克制伤害系数计算
---@param atkEle any
---@param defEle any
function BuffMgr:ElementAdvantageChange(atkEle, defEle, dmgParam, AorD)
    local addDmgParam = 0
    local mulDmgParam = 0
    local ElementAdvantageChange = Constants.BuffType.ElementAdvantageChange
    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == ElementAdvantageChange then
            if buffEffect.data.subEffectType == 1 then
                local params = buffEffect.data.effectNum1
                local atkE = checkInt(params[1])
                local defE = checkInt(params[2])
                local dmgParamChange = checkNumber(params[3])
                local aord = checkInt(params[4])    -- 指定buff拥有者是攻击方还是防守方 0都行 1攻击方 2防守方
                local aordMeet = (aord == 0) or (aord == AorD)
                local eleMeet = (atkEle == atkE) and (defEle == defE)
                if aordMeet and eleMeet then
                    if buffEffect.data.miniEffectType == 1 then
                        addDmgParam = addDmgParam + dmgParamChange
                    elseif buffEffect.data.miniEffectType == 2 then
                        -- print("[属性克制] 乘法效果 ", buffEffect.buff.data.id, mulDmgParam, dmgParamChange, mulDmgParam + dmgParamChange)
                        mulDmgParam = mulDmgParam + dmgParamChange
                    end
                end
            elseif buffEffect.data.subEffectType == 2 then
                local params = buffEffect.data.effectNum1
                local dmgParamChange = checkNumber(params[1])

                local sign = 0
                if AorD == 1 and atkEle == 5 then
                    sign = 1
                elseif AorD == 1 and atkEle == 4 then
                    sign = 1
                elseif AorD == 2 and defEle == 4 then
                    sign = -1
                elseif AorD == 1 and dmgParam > 0 then
                    sign = 1
                elseif AorD == 2 and dmgParam < 0 then
                    sign = -1
                end

                if buffEffect.data.miniEffectType == 1 then
                    if sign == 1 then
                        addDmgParam = addDmgParam + dmgParamChange
                    elseif sign == -1 then
                        addDmgParam = addDmgParam - dmgParamChange
                    end
                elseif buffEffect.data.miniEffectType == 2 then
                    -- print("[属性克制] 乘法效果 ", buffEffect.buff.data.id, mulDmgParam, dmgParamChange, mulDmgParam + dmgParamChange)
                    mulDmgParam = mulDmgParam + dmgParamChange
                    if sign == 1 then
                        mulDmgParam = mulDmgParam + dmgParamChange
                    elseif sign == -1 then
                        mulDmgParam = mulDmgParam - dmgParamChange
                    end
                end
            end
        end
    end)
    return addDmgParam, mulDmgParam
end

--收到属性攻击处理弱点球被打破的情况
function BuffMgr:ElementBreak( element )
    local Constants = Constants
    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == Constants.BuffType.Special
            and buffEffect.data.subEffectType == Constants.SpecialBuffType.WeakExpose
        then
            --处理弱点
            local isBreak = buffEffect:ElementBreak(element)
            if isBreak then
                self:RemoveBuff(buffEffect.buff)
            end

            return true
        end
    end)
end

--是否处于弱点暴露的状态
function BuffMgr:IsWeakExposed(  )
    --检查弱点暴露buff
    local Constants = Constants
    return self:HasBuffByType( Constants.BuffType.Special, Constants.SpecialBuffType.WeakExpose)
end

--检查此效果是否被抵抗
function BuffMgr:CheckIsResist( effectData, effectType )
    --效果附带无视免疫
    if effectData.isIgnore == 1 then
        return false
    end
    local ResistType = Constants.BuffType.Resist 
    local canResist = false
    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == ResistType and buffEffect:IsResist(effectData, effectType) then
            canResist = true
            return true
        end
    end)
    return canResist
end

-- 移除触发过的每技能大毅力
function BuffMgr:RemoveTriggeredPerseverancePerSkill()
    local DamageChangeType = Constants.BuffType.DamageChange 
    local PerseverancePerSkill = Constants.DamageChangeType.PerseverancePerSkill
    local PerseverancePerSkill2 = Constants.DamageChangeType.PerseverancePerSkill2
    self:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == DamageChangeType then
            if buffEffect.data.subEffectType == PerseverancePerSkill
            and checkNumber(buffEffect.perSkillPerseveranceValue) > 0 then
                buffEffect.perSkillPerseveranceValue = 0
                self:RemoveBuff(buffEffect.buff, 1)
            end
            if buffEffect.data.subEffectType == PerseverancePerSkill2
            and checkNumber(buffEffect.perSkillPerseveranceValue2) > 0 then
                buffEffect.perSkillPerseveranceValue2 = 0
                self:RemoveBuff(buffEffect.buff, 1)
            end
        end
    end)
end

function BuffMgr:LogBuffs(  )
    local globalTalentBuffWords = {}
    local word = {"打印buff ", self.owner.typeId,":\n\n"}
    self:WalkAllBuff(function ( buff )
        local t = nil
        local talentInfo = self:GetGlobalTalentInfo(buff.buffID..'_'..buff.data.star)
        if isNotNull(talentInfo) then
            local type = talentInfo.type
            globalTalentBuffWords[type] = globalTalentBuffWords[type] or {}
            t = globalTalentBuffWords[type]
            table.insert(t, "       talentId:")
            table.insert(t, talentInfo.talentId)
            table.insert(t, "  addNum:")
            table.insert(t, talentInfo.addNum)
        else
            t = word
        end
        table.insert(t, "       buffId:")
        table.insert(t, buff.buffID)
        table.insert(t, "  层数:")
        table.insert(t, buff.layNum)
        table.insert(t, "  回合:")
        table.insert(t, buff.remainRound)
        table.insert(t, "  类型:")
        table.insert(t, buff.mainEffectType)
        table.insert(t, "  ")
        table.insert(t, buff.subEffectType)
        table.insert(t, "  ")
        table.insert(t, buff.miniEffectType)
        table.insert(t, "  星级:")
        table.insert(t, buff.data.star)
        table.insert(t, "\n")
    end)
    if table.count(globalTalentBuffWords) > 0 then
        table.insert(word, "\n-------------------------全局天赋加成buff\n")
        for talentType, words in pairs(globalTalentBuffWords) do
            table.insert(word, "  类型："..talentType..'\n')
            table.link(word, words)
        end
    end
    print(table.concat(word))
end

function BuffMgr:Clear(  )
    self._buffs = {}
    self._triggerDic = {}
    self._endTriggerDic = {}

    -- while #self._buffs > 0 do
    --     self:RemoveBuff(self._buffs[1])
    -- end
    for k, v in pairs(self.specialStatusId2InfoDict) do
        self.specialStatusId2InfoDict[k] = nil
    end
end

function BuffMgr:GetGlobalTalentInfo(buffID)
    return self:GetGlobalTalentBuffMap()[buffID]
end

function BuffMgr:GetGlobalTalentBuffMap()
    if isNull(BattleViewMgr) then
        return {}
    end
    if isNull(BattleViewMgr._homelandTalentBuffMap) then
        ---@type HomelandTalentConfMgr
        local HomelandTalentConfMgr = import("Game.Homeland.Talent.HomelandTalentConfMgr")
        BattleViewMgr._homelandTalentBuffMap = HomelandTalentConfMgr:GetHomelandTalentBuffMap()
        -- print("[天赋buff]", table.dump(BattleViewMgr._homelandTalentBuffMap, nil, 2))
    end
    return BattleViewMgr._homelandTalentBuffMap
end

function BuffMgr:GetSpecialStatus(id)
    return self.specialStatusId2InfoDict[id]
end

function BuffMgr:SetSpecialStatus(id, info)
    self.specialStatusId2InfoDict[id] = info
end

function BuffMgr:ClearSpecialStatus(id)
    self.specialStatusId2InfoDict[id] = nil
end

--- 特殊buff，使用指定技能卡是否能获得SP
---@param skillCardIndex any
function BuffMgr:SkillCardCanGetSP(skillCardIndex)
    local info = self.specialStatusId2InfoDict[Constants.SpecialBuffType.SkillCardCantGetSp]
    if info == nil then
        return true
    end
    local num = info[skillCardIndex]
    if num == nil or num <= 0 then
        return true
    end
    return false
end

--- 特殊buff，改变掉牌概率
function BuffMgr:ChangePushCardProb()
    local prob = self.specialStatusId2InfoDict[Constants.SpecialBuffType.ChangePushCardProb]
    return prob
end

--- 特殊buff，针对指定技能Tag标记
---@param skillTags any
function BuffMgr:MarkForSkillTag(skillTags)
    local info = self.specialStatusId2InfoDict[Constants.SpecialBuffType.MarkForSkillTag]
    if info == nil then
        return false
    end
    for i, skillTag in ipairs(skillTags) do
        local num = info[skillTag]
        if num ~= nil and num > 0 then
            return true
        end
    end
    return false
end

function BuffMgr:AddLockAttrId( attrId )
    self.lockAttrIds[tostring(attrId)] = true
end

function BuffMgr:RemoveLockAttrId( attrId )
    self.lockAttrIds[tostring(attrId)] = nil
end

function BuffMgr:GetLockAttrIds()
    return self.lockAttrIds
end

return  BuffMgr