--
-- Author:luqucheng
-- Date: 2019-11-14 15:20:40
--
local HealFormula = import('Game.Battle.Script.HealFormula')
local gameUtils = CS.GameUtils

local BattleMgr = {}

--治疗流程
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleHeal( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local combo = effectParams.combo
    local effectRec = effectParams.effectRec

    local dmgRecs = {}

    combo = combo or 1
    local targets = effectRec.targets
    for i,target in ipairs(targets) do
        local damgRec = RecordMgr.DamageRecord.New(target, attacker)
        -- print('Formula'..effectRec.effectData.miniEffectType)
        local formulaName = string.format("Formula%d", effectRec.effectData.miniEffectType)
        local healValue = HealFormula[formulaName](attacker, mainTarget, effectRec, damgRec, effectParams)
        --星级系数

        self:Heal(healValue, Constants.DamageType.Heal, target, attacker, effectRec.effectData.star, combo, damgRec)
        table.insert(dmgRecs, damgRec)
    end 
    return dmgRecs
end

--添加buff流程
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleBuff(effectParams)
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local combo = effectParams.combo
    local effectRec = effectParams.effectRec
    local targets = effectRec.targets
    local star = effectParams.star
    local lv = effectParams.lv
    local trigBuff = effectParams.trigBuff  -- 触发器
    local trigData = effectParams.trigData  -- 触发数据

    local param = effectRec.effectData.effectNum1

    local layNum = effectParams.layNum or 1
    layNum = math.max(1, layNum)--不能添加少于一层的buff
    local switch = {
        [1] = function ()
            --按照技能主效果跳字伤害量总和，对目标施加对应层数的某标记Num1（如果伤害为0，则不施加）
            local dmgs = 0
            local dmgRecs = self:GetNowSkillDamageRecs()
            for i,rec in ipairs(dmgRecs) do
                if rec:IsDamage() then
                    dmgs = dmgs + rec.finalDamage
                end
            end
            local layNum = math.floor(dmgs)
            if layNum > 0 then
                self:HandleSkillEffect(
                {
                    attacker = attacker,
                    mainTarget = mainTarget,
                    star = star,
                    lv = lv,
                    targets = targets,
                    skillEffectID = param[1],
                    layNum = layNum,
                    effectType = Constants.EffectType.Buff,
                })
            end
        end,
        [2] = function ()
            --按照技能主效果对单个目标的跳字伤害量，对单个目标施加对应层数的某标记Num1（如果伤害为0，则不施加）
            local dmgs = 0
            local dmgRecs = self:GetNowSkillDamageRecs()
            for j,target in ipairs(targets) do
                local dmgs = 0
                for i,rec in ipairs(dmgRecs) do
                    if rec:IsDamage() and rec.target == target then
                        dmgs = dmgs + rec.finalDamage
                    end
                end
                local layNum = math.floor(dmgs)
                if layNum > 0 then
                self:HandleSkillEffect(
                    {
                        attacker = attacker,
                        mainTarget = mainTarget,
                        star = star,
                        lv = lv,
                        targets = {target},
                        skillEffectID = param[1],
                        layNum = layNum,
                        effectType = Constants.EffectType.Buff,
                    })
                end
            end
        end,
        [3] = function ()
            --按照技能主效果的跳字治疗量总和，对目标施加对应层数的某标记Num1
            local dmgs = 0
            local dmgRecs = self:GetNowSkillDamageRecs()
            for i,rec in ipairs(dmgRecs) do
                if rec:IsHeal() then
                    dmgs = dmgs + rec.finalDamage
                end
            end
            local layNum = math.floor(-dmgs)
            if layNum > 0 then
                self:HandleSkillEffect(
                {
                    attacker = attacker,
                    mainTarget = mainTarget,
                    star = star,
                    lv = lv,
                    targets = targets,
                    skillEffectID = param[1],
                    layNum = layNum,
                    effectType = Constants.EffectType.Buff,
                })
            end
        end,
        [4] = function ()
            --按照技能主效果跳字伤害量总和，对目标施加1层的value为对应伤害的buff（如果伤害为0，则不施加）
            local dmgs = 0
            local dmgRecs = self:GetNowSkillDamageRecs()
            for i,rec in ipairs(dmgRecs) do
                if rec:IsDamage() then
                    dmgs = dmgs + rec.finalDamage
                end
            end
            local value = math.floor(dmgs)
            if value > 0 then
                self:HandleSkillEffect(
                {
                    attacker = attacker,
                    mainTarget = mainTarget,
                    star = star,
                    lv = lv,
                    targets = targets,
                    skillEffectID = param[1],
                    layNum = 1,
                    effectType = Constants.EffectType.Buff,
                    buffOverrideValue = value,
                })
            end
        end,
        [5] = function ()
            --按照技能主效果对单个目标的跳字伤害量，对目标施加1层的value为对应伤害的buff（如果伤害为0，则不施加）
            local dmgs = 0
            local dmgRecs = self:GetNowSkillDamageRecs()
            for j,target in ipairs(targets) do
                local dmgs = 0
                for i,rec in ipairs(dmgRecs) do
                    if rec:IsDamage() and rec.target == target then
                        dmgs = dmgs + rec.finalDamage
                    end
                end
                local value = math.floor(dmgs)
                if value > 0 then
                self:HandleSkillEffect(
                    {
                        attacker = attacker,
                        mainTarget = mainTarget,
                        star = star,
                        lv = lv,
                        targets = {target},
                        skillEffectID = param[1],
                        layNum = 1,
                        effectType = Constants.EffectType.Buff,
                        buffOverrideValue = value,
                    })
                end
            end
        end,
        [6] = function ()
            --按照大类=num3，二类=num4，三类=num5的DOT的跳字伤害量*Num2，在下回合开始时对自身施加1层某标记Num1（如果伤害为0或没有伤害来源，则不施加），并将伤害数值赋予该BUFF
            local dotMainType = effectRec.effectData.effectNum1[3]
            local dotSubType = effectRec.effectData.effectNum1[4]
            local dotMiniType = effectRec.effectData.effectNum1[5]

            ---@type DOTInfo
            local dotInfo = self:GetNowDOTInfo()
            if dotInfo == nil then
                printError("效果4;6;1 找不到DOT信息")
            end

            local buffData = dotInfo.buffEffect.data
            if buffData.mainEffectType == dotMainType
            and buffData.subEffectType == dotSubType
            and buffData.miniEffectType == dotMiniType then
                -- 对满足大类、二类、三类的DOT，记录延迟触发数据
                -- 4;6;1会合并同一种大类、二类、三类的DOT的伤害，并且会根据添加护盾的对象不同进行区分
                local find = false
                self:WalkDelayBuffEffectInfo(function ( v )
                    local continue = true
                    ---@type DelayBuffEffectInfo
                    local delayBuffEffectInfo = v
                    if delayBuffEffectInfo.triggerMainType == Constants.TriggerMainType.BeforeRoundStart
                    and delayBuffEffectInfo.mainType == effectRec.effectData.mainEffectType
                    and delayBuffEffectInfo.subType == effectRec.effectData.subEffectType
                    and delayBuffEffectInfo.miniType == effectRec.effectData.miniEffectType
                    and delayBuffEffectInfo.dotMainType == dotMainType
                    and delayBuffEffectInfo.dotSubType == dotSubType
                    and delayBuffEffectInfo.dotMiniType == dotMiniType
                    and delayBuffEffectInfo.addBuffTarget.id == attacker.id then
                        continue = false
                        find = true
                        delayBuffEffectInfo.dotDamageNum = delayBuffEffectInfo.dotDamageNum + dotInfo.damageRec.finalDamage
                    end
                    return continue
                end)

                if not find then
                    ---@type DelayBuffEffectInfo
                    local delayBuffEffectInfo = {
                        triggerMainType = Constants.TriggerMainType.BeforeRoundStart,
                        mainType = effectRec.effectData.mainEffectType,
                        subType = effectRec.effectData.subEffectType,
                        miniType = effectRec.effectData.miniEffectType,

                        -- 4;6;1 的延迟触发数据
                        dotMainType = dotMainType,
                        dotSubType = dotSubType,
                        dotMiniType = dotMiniType,
                        addBuffTarget = attacker,
                        addBuffAttacker = attacker,
                        dotDamageNum = dotInfo.damageRec.finalDamage,
                        addBuffId = effectRec.effectData.effectNum1[1],
                        ratio = effectRec.effectData.effectNum1[2],
                        attrId = effectRec.effectData.effectNum1[6],
                        attrPercent = effectRec.effectData.effectNum1[7],
                    }
                    self:AddDelayBuffEffectInfo(delayBuffEffectInfo)
                end
            end
        end,
        [7] = function ()
            -- 重复获得获得触发触发器的buff
            local op = param[1]
            local addBuffId = trigData.buff.buffID
            local layerNum = 1
            local owner = attacker

            if op == 0 then
                -- 复制层数
                layerNum = trigData.buff.layNum
            elseif op == 1 then
                -- 指定添加的层数
                layerNum = param[2]
            end

            self:HandleSkillEffect(
            {
                attacker = trigData.buff.attacker,  -- 继承buff的来源
                mainTarget = mainTarget,
                star = star,
                lv = lv,
                targets = {owner},
                skillEffectID = addBuffId,
                layNum = layerNum,
                effectType = Constants.EffectType.Buff,
            })
        end,
    }
    local func = switch[effectRec.effectData.subEffectType]
    assert(func, '找不到添加buff方式:'..effectRec.effectData.subEffectType)
    func()
end

--- 添加buff强化流程
---@param effectParams any
function BattleMgr:HandleBuffEx(effectParams)
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local combo = effectParams.combo
    local effectRec = effectParams.effectRec
    local targets = effectRec.targets
    local star = effectParams.star
    local lv = effectParams.lv

    local params = effectRec.effectData.effectNum1

    local layNum = effectParams.layNum or 1
    layNum = math.max(1, layNum)--不能添加少于一层的buff

    local switch = {
        [1] = function()
            -- 所有buff平均随机概率，随机出num2个buff，进行添加
            local list = {table.unpack(params)} -- 复制列表以避免修改原始列表
            local selectNum = table.remove(list, #list)
            local buffList = list

            local length = #buffList
            if selectNum > length then
                printError("选择的buff数量不能超过buff列表长度")
            end

            for i, target in ipairs(targets) do
                -- 对每一个目标都单独随机
                local buffIds = {table.unpack(buffList)}
                local randomBuffs = {}
                for i = 1, selectNum do
                    local index = Core.Random(#buffIds, 1)
                    local buffId = table.remove(buffIds, index)
                    table.insert(randomBuffs, buffId)
                end

                for i, buffId in ipairs(randomBuffs) do
                    self:HandleSkillEffect(
                    {
                        attacker = attacker,
                        mainTarget = target,
                        star = star,
                        lv = lv,
                        targets = {target},
                        skillEffectID = buffId,
                        layNum = layNum,
                        effectType = Constants.EffectType.Buff,
                    })
                end
            end
        end,
        [2] = function()
            -- 通过effectNum2指定各个buff的随机概率，随机出一个buff，进行添加
            local paramsCount = #params
            assert(paramsCount % 2 == 0, 'buff数目必须为偶数')
            local buffCount = num_floor(paramsCount / 2)
            local buffList = {}
            for i = 1, buffCount do
                table.insert(buffList, params[i])
            end

            local probList = {}
            for i = buffCount + 1, paramsCount do
                table.insert(probList, params[i])
            end
            -- print("[概率buff]", table.dump(buffList), table.dump(probList))
            -- local probList = {1,1,3,2,2,1}
            local compareList = {}
            local total = 0
            for i, prob in ipairs(probList) do
                total = total + prob
                compareList[i] = (compareList[i - 1] or 0) + prob
            end
            for i, v in ipairs(compareList) do
                compareList[i] = v / total
            end
            -- print(table.dump(compareList))
            local index = 1
            local p = Core.Random()
            for i, v in ipairs(compareList) do
                if p > v then
                    index = i + 1
                end
            end
            print(index)
            local buffCount = #buffList
            index = math.max(math.min(index, buffCount), 1)  -- 索引最小为1，且不超过buff数量
            local buffId = buffList[index]
            
            self:HandleSkillEffect(
            {
                attacker = attacker,
                mainTarget = mainTarget,
                star = star,
                lv = lv,
                targets = targets,
                skillEffectID = buffId,
                layNum = layNum,
                effectType = Constants.EffectType.Buff,
            })
        end,
        [3] = function()
            local list = {table.unpack(params)} -- 复制列表以避免修改原始列表
            local selectNum = table.remove(list, #list)
            local buffIdList = list

            local length = #buffIdList
            if selectNum > length then
                printError("选择的buff数量不能超过buff列表长度")
            end

            for i, target in ipairs(targets) do
                -- 计算目标身上未拥有的buff和已拥有的buff
                local hasBuffIds = {}
                local hasNotBuffIds = {table.unpack(buffIdList)}
                -- 目标身上的buff
                target.buffMgr:WalkAllBuff(function(buff)
                    local buffId = buff.data.id
                    if table.isContain(hasNotBuffIds, buffId) then
                        local id = table.remove(hasNotBuffIds, table.indexof(hasNotBuffIds, buffId))
                        table.insert(hasBuffIds, id)
                    end
                end)
                -- 如果selectNum小于未拥有buff的数量，则随机selectNum个未拥有buff
                -- 如果selectNum大于未拥有buff的数量，则直接添加所有未拥有的buff，然后随机remainNum个已拥有buff
                if selectNum < #hasNotBuffIds then
                    local randomBuffs = {}
                    for i = 1, selectNum do
                        local index = Core.Random(#hasNotBuffIds, 1)
                        local buffId = table.remove(hasNotBuffIds, index)
                        table.insert(randomBuffs, buffId)
                    end

                    for i, buffId in ipairs(randomBuffs) do
                        self:HandleSkillEffect(
                        {
                            attacker = attacker,
                            mainTarget = target,
                            star = star,
                            lv = lv,
                            targets = {target},
                            skillEffectID = buffId,
                            layNum = layNum,
                            effectType = Constants.EffectType.Buff,
                        })
                    end
                else
                    -- 直接添加所有未拥有的buff
                    for i, buffId in ipairs(hasNotBuffIds) do
                        self:HandleSkillEffect(
                        {
                            attacker = attacker,
                            mainTarget = target,
                            star = star,
                            lv = lv,
                            targets = {target},
                            skillEffectID = buffId,
                            layNum = layNum,
                            effectType = Constants.EffectType.Buff,
                        })
                    end

                    -- 随机remainNum个已拥有buff
                    local remainNum = selectNum - #hasNotBuffIds
                    local randomBuffs = {}
                    for i = 1, remainNum do
                        local index = Core.Random(#hasBuffIds, 1)
                        local buffId = table.remove(hasBuffIds, index)
                        table.insert(randomBuffs, buffId)
                    end

                    for i, buffId in ipairs(randomBuffs) do
                        self:HandleSkillEffect(
                        {
                            attacker = attacker,
                            mainTarget = target,
                            star = star,
                            lv = lv,
                            targets = {target},
                            skillEffectID = buffId,
                            layNum = layNum,
                            effectType = Constants.EffectType.Buff,
                        })
                    end
                end
                
                
            end
        end,
    }

    local func = switch[effectRec.effectData.subEffectType]
    assert(func, '找不到添加buff方式:'..effectRec.effectData.subEffectType)
    func()
end

--直接伤害流程
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleDirectDamage(effectParams)
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local combo = effectParams.combo
    local effectRec = effectParams.effectRec
    local isSPSkill = effectParams.isSPSkill     -- 是否是大招的效果
    local isSPSkillMainEffect = effectParams.isSPSkillMainEffect    -- 是大招的主效果还是子效果
    local triggerEffectParams = effectParams.triggerEffectParams    -- 效果触发技能附带的参数
    --直接伤害类型的第二级类型直接采用脚本形式处理
    --获取技能的处理脚本
    -- print("HandleDirectDamage", effectRec.effectData.id)
    combo = combo or 1
    local Def = Constants.AttrTypeId.Defense
    local DamageChange = Constants.AttrTypeId.DamageChange
    local dmgRecs = {}

    -- 根据三类 获取计算伤害的脚本(这里可以略过，因为目前只有一种类型 指向脚本DamageEffectBase)
    local script = Core:GetDamageHandler(effectRec.effectData.miniEffectType)
    -- assert(script, "找不到处理直接伤害的脚本:"..effectRec.effectData.miniEffectType)


    -- 根据二类 获得伤害类型(伤害倍率计算公式)
    --@RefType [Game.Setting.Vo.DamageTypeVo#DamageTypeVo]
    local damageTypeVo = Core:GetDamageData(effectRec.effectData.subEffectType)
    -- assert(damageTypeVo, "找不到当前的伤害类型:"..effectRec.effectData.subEffectType.. "  effectId:" .. effectRec.effectData.id)
    -- local dmgTypes = damageTypeVo.damageTypes

    local dmgType = damageTypeVo.damageType
    local effectLv = effectRec.effectData.effectLv

    local targets = effectRec.targets
    local absorb = attacker:GetAttr(Constants.AttrTypeId.Absorb)

    for i,target in ipairs(targets) do
        local damgRec = RecordMgr.DamageRecord.New(target, attacker)

        damgRec.isSPSkill = isSPSkill
        dmgRecs.isSPSkillMainEffect = isSPSkillMainEffect

        --计算命中
        local isHit = true

        --2022-12-14,命中取消
        -- if Core:IsDamageAlwaysHit(damageTypeVo.damageTags) then
        --     isHit = true
        -- else
        --     isHit = script:IsHit(attacker, mainTarget, effectRec, damgRec)
        -- end
        damgRec.isHit = isHit

        -- 拥有11,4,1效果的时候，指定的伤害类型必暴击
        local hasSpecialCrit = false
        target.buffMgr:WalkAllBuffEffects(function ( v )
            if target.buffMgr:IsBuffByType2(v.data.mainEffectType, v.data.subEffectType, v.data.miniEffectType, v.buff.data.buffType, 11, 4, 1, 0) then
                local params = v.data.effectNum1
                local dmgType = params[1]
                if dmgType == damageTypeVo.id then
                    hasSpecialCrit = true
                    return true
                end
            end
        end)

        --判断暴击
        local isCrit = false
        if hasSpecialCrit then
            isCrit = true
        else
            isCrit = script:IsCrit(attacker, mainTarget, effectRec, damgRec, damageTypeVo)
        end
        -- end
        damgRec.isCrit = isCrit
        damgRec.element = script:GetElementCounteType(attacker, mainTarget, effectRec, damgRec)

        local ratio = effectParams.ratio or 1

        -- 伤害前属性提升
        Core:RefreshAttrWithType2(attacker.buffMgr, attacker.attr, {damageRec = damgRec}, target)

        --计算税前伤害
        local dmg, extraRatio = script:GetDamage(attacker, mainTarget, effectRec, damgRec, effectParams, damageTypeVo)
        ratio = extraRatio * ratio
        -- print("GetDamage3", #dmgs, table.toString(dmgs))

        -- 效果触发伤害的倍率修改
        local ratioModifier
        if isNotNull(triggerEffectParams) and isNotNull(triggerEffectParams.ratioModifier) then
            ratioModifier = triggerEffectParams.ratioModifier
        end

        -- 造成伤害
        self:Damage(dmg, damageTypeVo, effectLv, target, attacker, effectRec.effectData.star, ratio, damgRec, ratioModifier)
        table.insert( dmgRecs,damgRec )

        -- 伤害后属性还原
        Core:RefreshAttr(attacker.buffMgr, attacker.attr)

        --计算吸血
        if absorb > 0 and not attacker:IsDead() and Core:DamageCanAbsorb(damageTypeVo.damageTags) then
            local absorbValue = damgRec.hpChange * absorb
            local absorbDmgRec = RecordMgr.DamageRecord.New(attacker, attacker)
            absorbDmgRec.isSecondHand = true
            self:Heal(absorbValue, Constants.DamageType.Heal, attacker, attacker, 1, 1, absorbDmgRec)
        end

        local bounceDamage = target:GetAttr(Constants.AttrTypeId.BounceDamage)
        local bouncePercent = target:GetAttr(Constants.AttrTypeId.BouncePercent)

        if bounceDamage > 0 or bouncePercent > 0 and not attacker:IsDead() and Core:DamageCanBeBounced(damageTypeVo.damageTags) then
            local dmgVo = Core:GetDamageData(Core:GetBattleParamNum(Constants.BattleParam.BounceDamageTypeId))
            local bounce = damgRec.hpChange * bouncePercent + bounceDamage
            local bounceDmgRec = RecordMgr.DamageRecord.New(attacker, target)
            bounceDmgRec.isBounce = true
            bounceDmgRec.isSecondHand = true
            self:Damage(bounce, dmgVo, 0, attacker, target, 1, 1, bounceDmgRec)
        end
    end

    return dmgRecs
end

--清除buff的效果
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleClearBuff( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec
    local dispelLv = effectRec.effectData.dispelLv

    --获取所有需要的buff
    local ClearBuffType = Constants.ClearBuffType
    local BuffOrDebuff = Constants.BuffOrDebuff
    local switch = {
        [ClearBuffType.All] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( buff )
                if buff.data.isClear == 1 and dispelLv >= buff.dispelLv then
                    table.insert(buffs, buff)
                end
            end)
            return buffs
        end,
        [ClearBuffType.Buff] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( buff )
                if buff.data.isClear == 1 and buff.data.buffType == BuffOrDebuff.Buff and dispelLv >= buff.dispelLv then
                    table.insert(buffs, buff)
                end
            end)
            return buffs
        end,
        [ClearBuffType.Debuff] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( buff )
                if buff.data.isClear == 1 and buff.data.buffType == BuffOrDebuff.Debuff and dispelLv >= buff.dispelLv then
                    table.insert(buffs, buff)
                end
            end)
            return buffs
        end,
        [ClearBuffType.ID] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( buff )
                if buff.data.id == effectRec.effectData.effectNum1[1] then
                    table.insert(buffs, buff)
                end
            end)
            return buffs
        end,
        [ClearBuffType.Type] = function ( target )
            local buffs = {}
            local mainType = effectRec.effectData.effectNum1[1]
            local subType = effectRec.effectData.effectNum1[2]
            local miniType = effectRec.effectData.effectNum1[3]
            local buffType = effectRec.effectData.effectNum1[4]

            target.buffMgr:WalkAllBuff(function ( v )
                if v.data.isClear == 1 and dispelLv >= v.dispelLv and
                (buffType == 0 or v.data.buffType == buffType) and 
                (mainType == 0 or v.mainEffectType == mainType) and 
                (subType == 0 or v.subEffectType == subType) and 
                (miniType == 0 or v.miniEffectType == miniType)
                then
                    table.insert(buffs, v)
                end
            end)
            return buffs
        end,
    }

    local getBuff = switch[effectRec.effectData.subEffectType]
    assert(getBuff, '找不到对应的清除buff类型'..effectRec.effectData.subEffectType)

    

    --根据不同的清除类型来清除这些buff
    switch = {
        [Constants.ClearBuffSelect.Number] = function ( target )
            --清除的数量代表的是层数而不是buff数
            local count = effectRec.effectData.effectNum1[#effectRec.effectData.effectNum1]
    
            local buffs = getBuff(target)
            for i,v in ipairs(buffs) do
                local lay = v.layNum
                local countBefore = count
                if count >= lay then
                    target.buffMgr:RemoveBuff(v)
                    count = count - lay
                else
                    target.buffMgr:RemoveBuff(v, count)
                    count = 0
                end

                --到底清除了多少buff需要记录
                if v.data.buffType == Constants.BuffOrDebuff.Debuff then
                    effectRec.debuffClearLayNum = effectRec.debuffClearLayNum + countBefore - count
                else
                    effectRec.buffClearLayNum = effectRec.buffClearLayNum + countBefore - count
                end

                if count <= 0 then
                    break
                end
            end
            target.buffMgr:AfterChangeBuff()
        end,
        [Constants.ClearBuffSelect.LeftNumber] = function ( target )
            local buffs = getBuff(target)
            --先获取总层数
            local totalLay = 0
            for i,v in ipairs(buffs) do
                totalLay  = totalLay + v.layNum
            end
            local clearLay = effectRec.effectData.effectNum1[#effectRec.effectData.effectNum1 - 1]
            local leftLay = effectRec.effectData.effectNum1[#effectRec.effectData.effectNum1]
            if clearLay + leftLay > totalLay then
                clearLay = totalLay - leftLay
            end

            for i,v in ipairs(buffs) do
                local lay = v.layNum
                local countBefore = clearLay
                if clearLay >= lay then
                    target.buffMgr:RemoveBuff(v)
                    clearLay = clearLay - lay
                else
                    target.buffMgr:RemoveBuff(v, clearLay)
                    clearLay = 0
                end

                --到底清除了多少buff需要记录
                if v.data.buffType == Constants.BuffOrDebuff.Debuff then
                    effectRec.debuffClearLayNum = effectRec.debuffClearLayNum + countBefore - clearLay
                else
                    effectRec.buffClearLayNum = effectRec.buffClearLayNum + countBefore - clearLay
                end

                if clearLay <= 0 then
                    break
                end
            end
            target.buffMgr:AfterChangeBuff()
        end
    }
    local func = switch[effectRec.effectData.miniEffectType]
    assert(func, '找不到对应的清除buff选择方式'..effectRec.effectData.miniEffectType)
    for i,v in ipairs(effectRec.targets) do
        func(v)
    end
end

--偷取buff
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleStealBuff( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec
    local dispelLv = effectRec.effectData.dispelLv

    local StealBuffType = Constants.StealBuffType
    local BuffOrDebuff = Constants.BuffOrDebuff
    local Shield = Constants.BuffType.Shield
    local switch = {
        [StealBuffType.All] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( v )
                if v.data.isStolen == 1
                and v.mainEffectType ~= Shield then
                    table.insert(buffs, v)
                end
            end)
            return buffs
        end,
        [StealBuffType.Buff] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( v )
                if v.data.isStolen == 1
                and v.data.buffType == BuffOrDebuff.Buff
                and dispelLv >= v.dispelLv
                and v.data.isClear == 1
                and v.mainEffectType ~= Shield then
                    table.insert(buffs, v)
                end
            end)
            return buffs
        end,
        [StealBuffType.Debuff] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( v )
                if v.data.isStolen == 1
                and v.data.buffType == BuffOrDebuff.Debuff
                and dispelLv >= v.dispelLv
                and v.data.isClear == 1 then
                    table.insert(buffs, v)
                end
            end)
            return buffs
        end,
        [StealBuffType.EffectType] = function ( target )
            local mainType = effectRec.effectData.effectNum1[1]
            local subType = effectRec.effectData.effectNum1[2]
            local miniType = effectRec.effectData.effectNum1[3]
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( v )
                if v.data.isStolen == 1
                and dispelLv >= v.dispelLv
                and v.data.isClear == 1
                and v.mainEffectType == mainType
                and v.subEffectType == subType
                and v.miniEffectType == miniType
                then
                    table.insert(buffs, v)
                end
            end)
            return buffs
        end,
        [StealBuffType.ID] = function ( target )
            local targetBuffId = effectRec.effectData.effectNum1[1]
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( v )
                if v.data.isStolen == 1
                and dispelLv >= v.dispelLv
                and v.data.isClear == 1
                and v.buffID == targetBuffId
                then
                    table.insert(buffs, v)
                end
            end)
            return buffs
        end,
    }

    local getBuff = switch[effectRec.effectData.subEffectType]
    assert(getBuff, '找不到对应的偷取buff类型'..effectRec.effectData.subEffectType)

    switch = {
        [Constants.StealBuffSelect.Number] = function ( attacker, target )
            local count = effectRec.effectData.effectNum1[1]
            local buffs = getBuff(target)
            for i,v in ipairs(buffs) do
                local lay = v.layNum
                local stealLay = 0
                if count >= lay then
                    --不能清除的buff就保留
                    target.buffMgr:RemoveBuff(v)
                    count = count - lay
                    stealLay = lay
                else
                    --不能清除的buff就保留
                    target.buffMgr:RemoveBuff(v, count)
                    stealLay = count
                    count = 0
                end

                -- 记录override的原始值
                local originOverrideValue = effectParams.buffOverrideValue

                --给自己加buff
                -- 流血buff需要拷贝伤害参数
                if attacker.buffMgr:IsBuffByType(v, 2,2,0,0) then
                    effectParams.buffOverrideValue = v.effects[1].value
                end
                local buff = attacker.buffMgr:AddBuff(attacker, v.data, stealLay, effectParams)

                -- 恢复override的原始值
                effectParams.buffOverrideValue = originOverrideValue

                --到底清除了多少buff需要记录
                if v.data.buffType == Constants.BuffOrDebuff.Debuff then
                    effectRec.debuffClearLayNum = effectRec.debuffClearLayNum + stealLay
                else
                    effectRec.buffClearLayNum = effectRec.buffClearLayNum + stealLay
                end
 
                if count <= 0 then
                    break
                end
            end
            --刷新buff，分开处理效率较高
            target.buffMgr:AfterChangeBuff()
            attacker.buffMgr:AfterChangeBuff()
        end,
        [Constants.StealBuffSelect.NumberAll] = function ( attacker, target )
            local buffs = getBuff(target)
            for i,v in ipairs(buffs) do
                local lay = v.layNum
                local remainRound = v.remainRound
                target.buffMgr:RemoveBuff(v)
                
                -- 记录override的原始值
                local originOverrideValue = effectParams.buffOverrideValue

                --给自己加buff
                -- 流血buff需要拷贝伤害参数
                if attacker.buffMgr:IsBuffByType(v, 2,2,0,0) then
                    effectParams.buffOverrideValue = v.effects[1].value
                end
                local buff, node = attacker.buffMgr:AddBuff(target, v.data, nil, effectParams)   -- buff的施加者是被偷取的那个人
                buff.remainRound = remainRound      -- 继承偷取的回合数
                if node then
                    node.data.rr = remainRound
                end

                -- 恢复override的原始值
                effectParams.buffOverrideValue = originOverrideValue

                --到底清除了多少buff需要记录
                if v.data.buffType == Constants.BuffOrDebuff.Debuff then
                    effectRec.debuffClearLayNum = effectRec.debuffClearLayNum + lay
                else
                    effectRec.buffClearLayNum = effectRec.buffClearLayNum + lay
                end
            end
            --刷新buff，分开处理效率较高
            target.buffMgr:AfterChangeBuff()
            attacker.buffMgr:AfterChangeBuff()
        end,
        [Constants.StealBuffSelect.Special1] = function ( attacker, target )
            local remainCount = effectRec.effectData.effectNum1[1]
            local buffs = getBuff(target)
            for i,v in ipairs(buffs) do
                local lay = v.layNum
                local buffData = v.data
                local remainRound = v.remainRound

                local sameIdBuff = nil
                attacker.buffMgr:WalkAllBuff(function ( buff )
                    if buff.data.id == buffData.id then
                        sameIdBuff = buff
                        return true
                    end
                end)
                
                local stealLayNum = lay     -- 默认是全偷走

                if sameIdBuff then
                    -- 独立
                    if buffData.sameBuffStackingType == Constants.BuffLayType.Independence then
                    -- 覆盖
                    elseif buffData.sameBuffStackingType == Constants.BuffLayType.Cover then
                        goto continue
                    -- 叠加
                    elseif buffData.sameBuffStackingType == Constants.BuffLayType.Stack then
                        local isMaxLayer = sameIdBuff:IsMaxLayer()
                        if isMaxLayer then
                            goto continue
                        else
                            stealLayNum = sameIdBuff.data.stackingMax - sameIdBuff.layNum
                        end
                    -- 互斥
                    elseif buffData.sameBuffStackingType == Constants.BuffLayType.Reject then
                        goto continue
                    end
                end

                -- 从目标身上移除层数
                target.buffMgr:RemoveBuff(v, stealLayNum)

                -- 记录override的原始值
                local originOverrideValue = effectParams.buffOverrideValue

                -- 给自己增加层数，保留原来的buff释放者
                -- 流血buff需要拷贝伤害参数
                if attacker.buffMgr:IsBuffByType(v, 2,2,0,0) then
                    effectParams.buffOverrideValue = v.effects[1].value
                end

                local buff, node = attacker.buffMgr:AddBuff(v.attacker, v.data, stealLayNum, effectParams)
                buff.remainRound = remainRound      -- 继承偷取的回合数
                if node then
                    node.data.rr = remainRound
                end

                -- 恢复override的原始值
                effectParams.buffOverrideValue = originOverrideValue

                --到底清除了多少buff需要记录
                if v.data.buffType == Constants.BuffOrDebuff.Debuff then
                    effectRec.debuffClearLayNum = effectRec.debuffClearLayNum + stealLayNum
                else
                    effectRec.buffClearLayNum = effectRec.buffClearLayNum + stealLayNum
                end

                remainCount = remainCount - 1
                if remainCount <= 0 then
                    break
                end
                ::continue::
            end
            --刷新buff，分开处理效率较高
            target.buffMgr:AfterChangeBuff()
            attacker.buffMgr:AfterChangeBuff()
        end,
    }

    local func = switch[effectRec.effectData.miniEffectType]
    assert(func, '找不到对应的偷取buff选择方式'..effectRec.effectData.miniEffectType)
    for i,v in ipairs(effectRec.targets) do
        func(attacker, v)
    end
end

--SP改变
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleSpChange( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    local subEffectType = effectRec.effectData.subEffectType

    if subEffectType == 1 then
        --@RefType [Game.Battle.Entity.Role#Role<>]
        local targets = effectRec.targets
        local changeValue = effectRec.effectData.effectNum1[1]
        for i,target in ipairs(targets) do
            local before = target:GetUltraPoint()
            target:SetUltraPoint(before + changeValue, Constants.AddSPType.SkillEffect)

            --从大招点满到不够，需要移除大招卡
            if before >= target.maxUltraPoint and changeValue < 0 then
                --@RefType [Game.Battle.Entity.Controller#Controller]
                --只有玩家的才需要被移除卡牌
                local cardMgr = target:GetCardMgr()
                if cardMgr then
                    local recs = cardMgr:RemoveRoleCard(target.id, 0)
                    RecordMgr:AddRecords(recs)
                end
            end
        end   
    elseif subEffectType == 2 then
        local targets = effectRec.targets
        local changeValue = effectRec.effectData.effectNum1[1]
        for i,target in ipairs(targets) do
            local before = target.maxUltraPoint
            local newValue = before + changeValue
            target:ChangeUltraPointMax(newValue)

            --从大招点满到不够，需要移除大招卡
            if before >= target.maxUltraPoint and changeValue > 0 then
                --@RefType [Game.Battle.Entity.Controller#Controller]
                --只有玩家的才需要被移除卡牌
                local cardMgr = target:GetCardMgr()
                if cardMgr then
                    local recs = cardMgr:RemoveRoleCard(target.id, 0)
                    RecordMgr:AddRecords(recs)
                end
            end
        end   
    else
        printError("未知的SP改变类型" .. subEffectType)
    end
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleCardStarChange( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local delta = effectRec.effectData.effectNum1[1]
    local SkillCard = import('Game.Battle.SkillCard.SkillCard')

    local subType = effectRec.effectData.subEffectType
    
    local recs = {}
    for i,target in ipairs(targets) do
        --@RefType [Game.Battle.SkillCard.SkillCardMgr#SkillCardMgr]
        local cardMgr = target:GetCardMgr()
        if cardMgr then
            local cards = {}
            -- print(table.toString(self:GetPlayer(target.camp),"player"))
            -- print(table.toString(cardMgr,"cardMgr"))

            -- 找到符合条件的卡牌
            local cards = cardMgr:FindCardsByFunc(function (card)
                local result = false
                if subType == 1 then
                    -- 找到目标角色的非sp卡
                    local afterStar = card.star + delta
                    afterStar = math.range(afterStar, 1, 3)
                    result = card.roleId == target.id and not card.isUltra and (afterStar ~= card.star)
                elseif subType == 2 then
                    -- 找到目标角色的非sp卡，且限制星级
                    local fromStar = checkInt(effectRec.effectData.effectNum1[2])
                    if card.star == fromStar or fromStar == 0 then
                        local afterStar = card.star + delta
                        afterStar = math.range(afterStar, 1, 3)
                        result = card.roleId == target.id and not card.isUltra and (afterStar ~= card.star)
                    end
                elseif subType == 3 then
                    -- 找到指定id的卡牌
                    local afterStar = card.star + delta
                    afterStar = math.range(afterStar, 1, 3)
                    local curCardId = cardMgr:GetSkillCardId(card) or 0
                    local cardId = checkInt(effectRec.effectData.effectNum1[3])
                    result = curCardId == cardId and  (afterStar ~= card.star)
                elseif subType == 4 then
                    -- 找到非sp卡，且限制星级，不限定角色
                    local fromStar = checkInt(effectRec.effectData.effectNum1[2])
                    if card.star == fromStar or fromStar == 0 then
                        local afterStar = card.star + delta
                        afterStar = math.range(afterStar, 1, 3)
                        result = not card.isUltra and (afterStar ~= card.star)
                    end
                end
                return result
            end)
            
            -- 排序
            if subType == 2
            or subType == 4 then
                -- 随机
                Core:Shuffle(cards)
            elseif subType == 3 then
                table.inPlaceBubbleSort(cards, function(a, b)
                    if delta > 0 then
                        return a.star < b.star
                    else
                        return a.star > b.star
                    end
                end)
            end

            -- 数量限制
            local changeNum = 100
            if subType == 2
            or subType == 4 then
                changeNum = effectRec.effectData.effectNum1[3] or 1
            elseif subType == 3 then
                changeNum = effectRec.effectData.effectNum1[2] or 1
            end
        
            -- 改变星级
            for i,card in ipairs(cards) do
                if card and changeNum > 0 then
                    local oldStar = card.star
                    card.star = math.range(card.star + delta, 1, 3)
                    local pos = cardMgr:GetCardPos(card)
                    if isNull(pos) then
                        -- 卡牌已经移除
                        print("升星过程中一张卡牌被移除了或合成了")
                    else
                        local rec = cardMgr:ChangeCard(pos, card)
                        table.insert(recs, rec)
    
                        if oldStar ~= card.star then
                            self:Trig(attacker, Constants.TriggerMainType.GiveCardChangeEffect, {isCardUpgrade = oldStar < card.star}, target)
                        end
                        changeNum = changeNum - 1
                    end
                end
            end
        
            --所有变化调用成功后调用合成
            local rs = cardMgr:UnitCard()
            --合成之后的大招点数变化
            cardMgr:AddUltraPoint(rs)
            table.link(recs, rs)
        end

        if subType == 1 then
            --修改当前牌库的牌
            local queueRecs = self:ChangeSkillCardQueue(function (skillCardItem)
                if skillCardItem.roleId == target.id and skillCardItem.skillIndex ~= 0 then
                    local oldStar = skillCardItem.star
                    local newStar = math.range(skillCardItem.star + delta, 1, 3)
                    skillCardItem.star = newStar
                    return oldStar ~= newStar, skillCardItem
                end
                return false, skillCardItem
            end)
            table.link(recs, queueRecs)
        end
    end
    RecordMgr:AddRecords(recs)
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleChangeBuffDuration( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1
    local switch = {
        -- BUFFID，延长的持续回合数
        [1] = function ( )
            local checkMax = param[3] ~= 1  -- 检查最大回合数限制
            for i,target in ipairs(targets) do
                --找到对应的buff
                target.buffMgr:WalkAllBuff(function ( buff )
                    if buff.buffID == param[1] then
                        target.buffMgr:ChangeBuffDuration(buff, buff.remainRound + param[2], checkMax)
                    end
                end)
                target.buffMgr:AfterChangeBuff()
            end
        end,
        -- 延长某个类型BUFF的持续回合数（优先选择条件符合param8的buff）
        [2] = function (  )
            for i,target in ipairs(targets) do
                --找到对应的buff
                local buffs = {}
                target.buffMgr:WalkAllBuff(function ( buff )
                    if target.buffMgr:IsBuffByType(buff, param[1], param[2], param[3], param[4]) then
                        table.insert(buffs, buff)
                    end
                end)
                local changeCount = param[6]    -- 数量限制
                if changeCount < #buffs then
                    local sortOrder = param[8]
                    table.sort(buffs, function(a, b)
                        if sortOrder == 1 then
                            -- 优先选择剩余回合数高的buff
                            return a.data.round > b.data.round
                        elseif sortOrder == 2 then
                            -- 优先选择剩余回合数低的buff
                            return a.data.round < b.data.round
                        elseif sortOrder == 3 then
                            -- 随机
                            return false
                        else
                            return false
                        end
                    end)
                end
                local checkMax = param[7] ~= 1  -- 检查最大回合数限制
                for i, buff in ipairs(buffs) do
                    if i <= changeCount then
                        target.buffMgr:ChangeBuffDuration(buff, buff.remainRound + param[5], checkMax)
                    end
                end
                target.buffMgr:AfterChangeBuff()
            end
        end,
    }

    local func = switch[effectRec.effectData.subEffectType]
    assert(func, '找不到buff回合数修改方式:'..effectRec.effectData.subEffectType)
    func()
    
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleSummon( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1


    local camp = attacker.camp

    local getSelectPos = function (  )
        --找个剩余站位
        --最大站位数量
        local selectPos = nil
        local maxNum = camp == Constants.Camp.One and 4 or self:GetWaveMaxNum()
        

        local rs = self:GetAliveRoles(camp)
        if #rs >= maxNum then
            --超过最大数量则不可召唤
            return
        end
        for i=1,maxNum do
            local has = false
            for j,v in ipairs(rs) do
                if v.standPosition == i then
                    has = true
                    break
                end
            end
            if not has then
                selectPos = i
                break
            end
        end
        return selectPos
    end

    local summon = function (hpPercent, sp, selectPos, moudleData )
       
        if not moudleData then
            printError('召唤的模板数据不存在')
            return
        end

        if not selectPos then
            --找不到可以放置的位置（应该是不可能的，说明出问题了）
            -- printError('找不到可以放置的位置')
            return
        end
        -- print("HandleSummon pos:"..selectPos)
        self.summonIndex = self.summonIndex or 100
        --召唤池内下标为num1的召唤兽，召唤时最大生命值百分比为num2，能量为num3点
        local Role = import('Game.Battle.Entity.Role')
        local role = Role.New()
        table.insert( self.roles, role )
        role:InitWithData(moudleData, camp, selectPos, Constants.RoleType.Monster)
    
        --id, 血量，能量
        role.id = role.id * 1000 + self.summonIndex
        role:ForceSetNowHp(role:GetAttr(Constants.AttrTypeId.Hp) * (hpPercent or 1))
        role.ultraPoint = (sp or 0)
        role.isSummonCreep = true
        self.summonIndex  = self.summonIndex + 1
    
        RecordMgr:AddRecord(RecordMgr.CreateRoleRecord.New(role))

        role:OnEnter()
    end
    
    local switch = {
        [1] = function ( )
            local moudleData = nil
            if self.initData and self.initData.callTeam and self.initData.callTeam[self.nowWave] then
                moudleData = self.initData.callTeam[self.nowWave][param[1]]
            end
            for i=1,param[4] do
                summon(param[2], param[3], getSelectPos(), moudleData)
            end
        end,
        [2] = function (  )
            --权重随机
            for i=1,param[3] do
                local r = {}
                local index = 4
                while param[index] ~= nil do
                    table.insert(r, param[index])
                    index = index + 1
                end
                local selectedIndex = Core:GetRandomIndexByWeight(r)
                local moudleData = nil
                if self.initData and self.initData.callTeam and self.initData.callTeam[self.nowWave] then
                    moudleData = self.initData.callTeam[self.nowWave][selectedIndex]
                end
                -- print("selectedIndex", selectedIndex, table.toString(moudleData, "moudleData"))
                summon(param[1], param[2], getSelectPos(), moudleData)
            end
        end,
        [3] = function (  )
            local moudleData = nil
            if self.initData and self.initData.callTeam and self.initData.callTeam[self.nowWave] then
                moudleData = self.initData.callTeam[self.nowWave][param[1]]
            end
            for i=1,param[4] do
                summon(param[2] * (attacker:GetNowHp() / attacker:GetAttr(Constants.AttrTypeId.Hp) ) , param[3], getSelectPos(), moudleData)
            end
        end
    }

    local func = switch[effectRec.effectData.miniEffectType]
    assert(func, '找不到召唤方式:'..effectRec.effectData.miniEffectType)
    func()
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleCopyBuff( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    local BuffOrDebuff = Constants.BuffOrDebuff
    local StealBuffType = Constants.StealBuffType
    local Shield = Constants.BuffType.Shield
    local switch = {
        [StealBuffType.All] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( v )
                if v.data.isStolen == 1
                and v.mainEffectType ~= Shield then
                    table.insert(buffs, v)
                end
            end)
            return buffs
        end,
        [StealBuffType.Buff] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( v )
                if v.data.isStolen == 1
                and v.data.buffType == BuffOrDebuff.Buff
                and v.mainEffectType ~= Shield then
                    table.insert(buffs, v)
                end
            end)
            return buffs
        end,
        [StealBuffType.Debuff] = function ( target )
            local buffs = {}
            target.buffMgr:WalkAllBuff(function ( v )
                if v.data.isStolen == 1 and v.data.buffType == BuffOrDebuff.Debuff then
                    table.insert(buffs, v)
                end
            end)
            return buffs
        end,
    }
    local getBuff = switch[effectRec.effectData.subEffectType]
    assert(getBuff, '找不到对应的偷取buff类型'..effectRec.effectData.subEffectType)

    switch = {
        [1] = function ( )
            local targetType = effectRec.effectData.effectNum1[2]
            local addBuffTargets = Core:SelectTargets(targetType, attacker, mainTarget, self.roles)

            for p,copyTarget in ipairs(effectRec.targets) do
                local buffs = getBuff(copyTarget)
                local count = effectRec.effectData.effectNum1[1]
                for i,v in ipairs(buffs) do
                    local lay = v.layNum
                    local stealLay = 0
                    if count >= lay then
                        count = count - lay
                        stealLay = lay
                    else
                        stealLay = count
                        count = 0
                    end

                    -- 记录override的原始值
                    local originOverrideValue = effectParams.buffOverrideValue

                    --给自己加buff
                    -- 流血buff需要拷贝伤害参数
                    if attacker.buffMgr:IsBuffByType(v, 2,2,0,0) then
                        effectParams.buffOverrideValue = v.effects[1].value
                    end
                    for j,addTarget in ipairs(addBuffTargets) do
                        --保留原来的buff释放者
                        local buff = addTarget.buffMgr:AddBuff(v.attacker, v.data, stealLay, effectParams)
                    end

                    -- 恢复override的原始值
                    effectParams.buffOverrideValue = originOverrideValue
     
                    if count <= 0 then
                        break
                    end
                end
            end
            
            --刷新buff数据
            for j,v in ipairs(addBuffTargets) do
                v.buffMgr:AfterChangeBuff()
            end
        end,
        [2] = function()
            local copyCount = effectRec.effectData.effectNum1[1]
            local targetType = effectRec.effectData.effectNum1[2]
            local addBuffTargets = Core:SelectTargets(targetType, attacker, mainTarget, self.roles)

            for p,copyTarget in ipairs(effectRec.targets) do
                local buffs = getBuff(copyTarget)
                --给目标加buff
                for j,addTarget in ipairs(addBuffTargets) do
                    local remainCount = copyCount  -- 从每个人身上都复制这么多个buff
                    for i,v in ipairs(buffs) do
                        local buffData = v.data
                        local remainRound = v.remainRound

                        local sameIdBuff = nil
                        addTarget.buffMgr:WalkAllBuff(function ( buff )
                            if buff.data.id == buffData.id then
                                sameIdBuff = buff
                                return true
                            end
                        end)
                    
                        if sameIdBuff then
                            -- 独立
                            if buffData.sameBuffStackingType == Constants.BuffLayType.Independence then
                            -- 覆盖
                            elseif buffData.sameBuffStackingType == Constants.BuffLayType.Cover then
                                goto continue
                            -- 叠加
                            elseif buffData.sameBuffStackingType == Constants.BuffLayType.Stack then
                                local isMaxLayer = sameIdBuff:IsMaxLayer()
                                if isMaxLayer then
                                    goto continue
                                end
                            -- 互斥
                            elseif buffData.sameBuffStackingType == Constants.BuffLayType.Reject then
                                goto continue
                            end
                        end

                        -- 记录override的原始值
                        local originOverrideValue = effectParams.buffOverrideValue

                        --保留原来的buff释放者
                        -- 流血buff需要拷贝伤害参数
                        if attacker.buffMgr:IsBuffByType(v, 2,2,0,0) then
                            effectParams.buffOverrideValue = v.effects[1].value
                        end
                        local buff, node = addTarget.buffMgr:AddBuff(v.attacker, v.data, v.layNum, effectParams)
                        buff.remainRound = remainRound      -- 继承偷取的回合数
                        if node then
                            node.data.rr = remainRound
                        end

                        -- 恢复override的原始值
                        effectParams.buffOverrideValue = originOverrideValue

                        remainCount = remainCount - 1
                        if remainCount <= 0 then
                            break
                        end
                        ::continue::
                    end
                end
            end
            
            --刷新buff数据
            for j,v in ipairs(addBuffTargets) do
                v.buffMgr:AfterChangeBuff()
            end
        end,
    }

    local func = switch[effectRec.effectData.miniEffectType]
    assert(func, '找不到对应的清除buff选择方式'..effectRec.effectData.miniEffectType)
    func()
end

--血量消耗
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleHPChange( effectParams )

    local attacker = effectParams.attacker
    local combo = effectParams.combo
    local effectRec = effectParams.effectRec
    --获取技能的处理脚本
    -- print("HandleDirectDamage", effectRec.effectData.id)
    combo = combo or 1


    local script = Core:GetDamageHandler(effectRec.effectData.miniEffectType)

    local subType = effectRec.effectData.subEffectType

    local targets = effectRec.targets
    for i,target in ipairs(targets) do
        if not target:IsDead() then
            local dmgRec = RecordMgr.DamageRecord.New(target, attacker)

            local damage = 0
            if subType == 1 then
                damage = script:GetDamage(attacker, target, effectRec, dmgRec)
                damage = math.floor( damage )
                
                if BattleInfo:IsPVP() then
                    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting4100, "PVPBuffVo")
                    ---@type PVPBuffVo
                    local vo = setting:Get(self.initData.pvpSettingId)
                    if not isNull(vo) then
                        print(string.format("PVPBuff修改前HP变化:%f,修改后:%f",damage, damage * vo.globalBlood))
                        damage = damage * vo.globalBlood
                    end
                end
            elseif subType == 2 then
                local param = effectRec.effectData.effectNum1
                for i,v in ipairs(param) do
                    param[i] = param[i] - (RandomShift or 23)
                end
                local percent = param[1]
                local needSaveRegister = param[2] == 1  -- 是否需要存入寄存器
                for i,v in ipairs(param) do
                    param[i] = param[i] + (RandomShift or 23)
                end
                local hpMax = target:GetAttr(Constants.AttrTypeId.Hp)
                local targetHp = hpMax * percent
                local hpNow = target:GetAttr(Constants.AttrTypeId.NowHp)
                if hpNow > targetHp then
                    damage = hpNow - targetHp
                    if needSaveRegister then
                        local roleContextData = attacker.roleContextData
                        roleContextData:AddRegister1(damage)
                    end
                end
            elseif subType == 3 then
                local param = effectRec.effectData.effectNum1
                for i,v in ipairs(param) do
                    param[i] = param[i] - (RandomShift or 23)
                end
                local percent = param[1]
                local needSaveRegister = param[2] == 1  -- 是否需要存入寄存器
                for i,v in ipairs(param) do
                    param[i] = param[i] + (RandomShift or 23)
                end
                local hpMax = target:GetAttr(Constants.AttrTypeId.Hp)
                local targetHp = hpMax * percent
                local hpNow = target:GetAttr(Constants.AttrTypeId.NowHp)
                if hpNow > targetHp then
                    damage = hpNow - targetHp
                    if needSaveRegister then
                        local roleContextData = attacker.roleContextData
                        roleContextData:AddRegister1(damage)
                    end
                else
                    damage = hpNow - targetHp
                end
            else
                printError(string.format("找不到血量变更类型 %d", subType))
            end
            
            
            --星级系数
            dmgRec.damage = damage
            dmgRec.damageType = Constants.DamageType.HPChange
            dmgRec.finalDamage = dmgRec.damage
    
            local hpChange = target:ChangeNowHp(-dmgRec.finalDamage, attacker)
            dmgRec.hpChange = -hpChange
            dmgRec.nowHp = target:GetNowHp()

            -- 战斗统计
            local sstDamage = math.modf(dmgRec.hpChange + dmgRec.shieldAbsorb)
            if attacker.camp == Constants.Camp.One and BattleInfo:IsPVE() then
                self.selfTotalDamage  = self.selfTotalDamage + sstDamage
            end
        
            local attackerId = attacker.id
            if attacker.isSummonCreep and attacker.callerId then
                -- 如果攻击者是特殊召唤物，并且有召唤来源，那么这个召唤物的伤害统计归属于召唤者
                attackerId = attacker.callerId
            end
            self.statistics[attackerId] = self.statistics[attackerId] or {}
            self.statistics[attackerId].damage = self.statistics[attackerId].damage or 0
            self.statistics[attackerId].damage = self.statistics[attackerId].damage + sstDamage
        
            local targetId = target.id
            self.statistics[targetId] = self.statistics[targetId] or {}
            self.statistics[targetId].bear = self.statistics[targetId].bear or 0
            self.statistics[targetId].bear = self.statistics[targetId].bear + sstDamage

            local node = RecordMgr:AddRecord(dmgRec)

            self:Trig(target, Constants.TriggerMainType.HPReduceEffectEnd, {damageRec = dmgRec}, attacker)
        end
    end    
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleChangeElement( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1

    local switch = {
        [1] = function ( )
            for i,target in ipairs(targets) do
                target:ChangeElement(param[1])
            end
        end,
        [2] = function (  )
            for i,target in ipairs(targets) do
                target:ChangeElement(attacker.elementType)
            end
        end
    }

    local func = switch[effectRec.effectData.miniEffectType]
    assert(func, '找不到元素属性改变方式:'..effectRec.effectData.miniEffectType)
    func()
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandlePushCard( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1

    -- 不能给召唤物补牌，需要替换成随机友方阵营的非召唤物角色
    local realTargets = {}
    for i,target in ipairs(targets) do
        if target.isSummonCreep then
            if #targets > 1 then
                -- 群体技能时，直接排除召唤物
            else
                -- 单体技能时，随机友方阵营的非召唤物角色作为目标
                local allies = self:GetAliveRolesWithoutSpecialSummon(target.camp)
                if #allies > 0 then
                    table.insert(realTargets, allies[Core.Random(#allies, 1)])
                end
            end
        else
            table.insert(realTargets, target)
        end
    end
    
    for i,target in ipairs(realTargets) do
        --获取技能index
        local skillIndex = param[1]
        local star = param[2]
        if param[1] == 0 then
            skillIndex = Core.Random(2, 1)
        end
        if param[2] == 0 then
            star = Core.Random(3, 1)
        end
        local cardMgr = target:GetCardMgr()
        if cardMgr then
            local recs = cardMgr:EffectPushCard(target.id, skillIndex, star, param[3])
            RecordMgr:AddRecords(recs)
        end
    end
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleSpGive( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local changeValue = effectRec.effectData.effectNum1[1]

    local totalChangeSp = 0
    for i,target in ipairs(targets) do
        local before = target:GetUltraPoint()
        target:SetUltraPoint(before - changeValue, Constants.AddSPType.SkillEffect)
        totalChangeSp  = totalChangeSp + target:GetUltraPoint() - before
        --从大招点满到不够，需要移除大招卡
        if before >= target.maxUltraPoint and changeValue > 0 then
            --@RefType [Game.Battle.Entity.Controller#Controller]
            --只有玩家的才需要被移除卡牌
            local cardMgr = target:GetCardMgr()
            if cardMgr then
                local recs = cardMgr:RemoveRoleCard(target.id, 0)
                RecordMgr:AddRecords(recs)
            end
        end
    end
    local before = attacker:GetUltraPoint()
    attacker:SetUltraPoint(before - totalChangeSp, Constants.AddSPType.SkillEffect)
    if before >= attacker.maxUltraPoint and totalChangeSp > 0 then
        --@RefType [Game.Battle.Entity.Controller#Controller]
        --只有玩家的才需要被移除卡牌
        local cardMgr = attacker:GetCardMgr()
        if cardMgr then
            local recs = cardMgr:RemoveRoleCard(attacker.id, 0)
            RecordMgr:AddRecords(recs)
        end
    end
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleChangeBuffLayer( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1
    local switch = {
        [1] = function ( )
            for i,target in ipairs(targets) do
                --找到对应的buff
                target.buffMgr:WalkAllBuff(function ( buff )
                    if buff.buffID == param[1] then
                        target.buffMgr:SetBuffLayer(buff, param[2])
                    end
                end)
                target.buffMgr:AfterChangeBuff()
            end
        end,
        [2] = function (  )
            for i,target in ipairs(targets) do
                --找到对应的buff
                local num = 0
                target.buffMgr:WalkAllBuff(function ( buff )
                    if buff.buffID == param[1] then
                        target.buffMgr:SetBuffLayer(buff, math.floor(param[2] * self.totalTurnCount) )
                    end
                end)
                target.buffMgr:AfterChangeBuff()
            end
        end,
        [3] = function (  )
            --只有pve才生效，根据存活怪物数量改变buff层数
            local layNum = 0
            if BattleInfo:IsPVE() then
                local rs = self:GetAliveRoles(Constants.Camp.Two)
                local aliveNum = #rs or 0
                layNum = math.floor(aliveNum * param[2])
            end
            for i,target in ipairs(targets) do
                --找到对应的buff
                local num = 0
                target.buffMgr:WalkAllBuff(function ( buff )
                    if buff.buffID == param[1] then
                        target.buffMgr:SetBuffLayer(buff, layNum)
                    end
                end)
                target.buffMgr:AfterChangeBuff()
            end
        end,
        [4] = function (  )
            local layNum = attacker.buffMgr:GetBuffLayNumByBuffTypeID(param[2])
            if layNum <= 0 then
                return
            end
            for i,target in ipairs(targets) do
                --找到对应的buff
                local num = 0
                target.buffMgr:WalkAllBuff(function ( buff )
                    if buff.buffID == param[1] then
                        target.buffMgr:SetBuffLayer(buff, layNum)
                    end
                end)
                target.buffMgr:AfterChangeBuff()
            end
        end,
        [5] = function (  )
            for i,target in ipairs(targets) do
                --找到对应的buff
                target.buffMgr:WalkAllBuff(function ( buff )
                    if buff.buffID == param[1] then
                        target.buffMgr:AddBuffLayer(buff, param[2], param[3])
                    end
                end)
                target.buffMgr:AfterChangeBuff()
            end
        end,
        [6] = function (  )
            local who = param[1]
            local op = param[2]
            local num = param[3]
            local fIndex = param[4] or 1    -- 倒数第几个buff

            local role = who == 0 and attacker or mainTarget
            local buff = role.buffMgr:GetLastBuff(fIndex)
            if role and buff then
                if op == 0 then
                    role.buffMgr:SetBuffLayer(buff, num, nil)
                elseif op == 1 then
                    role.buffMgr:AddBuffLayer(buff, num, nil)
                elseif op == 2 then
                    role.buffMgr:AddBuffLayer(buff, -num, nil)
                end
            end
        end,
        -- 将目标身上BUFFid=NUM1的层数调整为当前施加方存活人数，如果目标身上没有BUFF，则无效。
        [7] = function ( )
            local roles = self:GetAliveRoles( attacker.camp )
            local roleNum = table.count(roles)

            for i,target in ipairs(targets) do
                --找到对应的buff
                target.buffMgr:WalkAllBuff(function ( buff )
                    if buff.buffID == param[1] then
                        target.buffMgr:SetBuffLayer(buff, roleNum)
                    end
                end)
                target.buffMgr:AfterChangeBuff()
            end
        end,
    }

    local func = switch[effectRec.effectData.miniEffectType]
    assert(func, '找不到buff层数改变方式:'..effectRec.effectData.miniEffectType)
    func()
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleDeath( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1
    for i,target in ipairs(targets) do
        --找到对应的buff
        if not target:IsDead() then
            target:ForceSetNowHp(0, attacker)
            self:OnRoleDead(target)
            RecordMgr:AddRecord(RecordMgr.RoleDeadRecord.New(target.id))
        end
    end
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleRemoveRole( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec


    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1
    for i,target in ipairs(targets) do
        --找到对应的buff
        self:RemoveRole(target)
    end
end

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleSpecialSummon( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec
    local param = effectRec.effectData.effectNum1

    local camp = effectRec.effectData.subEffectType == 1 and attacker.camp or self:GetOppoCamp(attacker.camp)
    if not attacker.rawData.summons or not attacker.rawData.summons[param[1]]  then
        return
    end
    
    local moudleData = attacker.rawData.summons[param[1]]

    local afterCreate = nil
    if effectRec.effectData.subEffectType == 1
    and effectRec.effectData.miniEffectType == 2 then
        afterCreate = function ( role )
            local attr = role.attr
            local baseValues = attr.baseValues

            local num2 = param[2]
            local num3 = param[3]
            local num4 = param[4]

            local attackerATK = attacker:GetAttr(Constants.AttrTypeId.Attack)
            local attackerCritical = attacker:GetAttr(Constants.AttrTypeId.Critical)
            local attackerCritDamage = attacker:GetAttr(Constants.AttrTypeId.CritDamage)

            baseValues[tostring(Constants.AttrTypeId.Attack)] = num2 * attackerATK * (1 + num3 * attackerCritical * 100 + num4 * attackerCritDamage * 100)

            for i = 5, (#param - 1), 2 do
                local attrId = param[i]
                local num = param[i + 1]
                baseValues[tostring(attrId)] = num * attacker:GetAttr(attrId)
            end
            
            attr:RefreshNowValues()
            role:ForceSetNowHp(role:GetAttr(Constants.AttrTypeId.Hp))   -- 刷新当前血量，默认满血
        end
    end

    --召唤
    self:SpecialSummon(camp, moudleData, afterCreate, attacker.id)
end


--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleRemoveCard( effectParams )
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec

    --@RefType [Game.Battle.Entity.Role#Role<>]
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1

    local calcLayer = function (cards, layerType)
        if layerType == 1 then
            --按照丢弃张数施加
            return #cards
        elseif layerType == 2 then
            --按照总星级
            local starCount = 0
            for i,card in ipairs(cards) do
                starCount = starCount + card.star
            end
            return starCount
        end
        return 1
    end

    local switch = {
        [1] = function ()
            for i,target in ipairs(targets) do
                --找到对应的buff
                if not target:IsDead() then
                    local cardMgr = target:GetCardMgr()
                    if cardMgr then
                        --判断需要移除哪些牌
                        local reqCardNum = param[1]
                        local reqSkillIndex = param[2]
                        local reqStar = param[3]
                        local layerType = param[4]
 
                        local cards = cardMgr:FindCardsByFunc(function (card, pos)
                            return target.id == card.roleId and (reqSkillIndex == 0 or card.skillIndex == reqSkillIndex) and  (1 << (card.star - 1)) & reqStar ~= 0 and not card.isUltra
                        end)
                       
                        if reqCardNum < #cards then
                            --牌数量大于需求量则需要随机一下
                            Core:Shuffle(cards)
                            while reqCardNum < #cards do
                                table.remove(cards)
                            end
                        end

                        local layer = calcLayer(cards, layerType)
                        local recs = cardMgr:RemoveCards(cards)
                        RecordMgr:AddRecords(recs)
                        for i=5,#param do
                            local buffId = param[i]
                            for j=1,layer do
                                attacker.buffMgr:AddBuff(attacker, Core:GetBuffData(buffId, 1, 1), 1, effectParams)
                            end
                        end
                    end
                end
            end
        end,
        [2] = function ()
            local cardMgr = attacker:GetCardMgr()
            if cardMgr then
                --判断需要移除哪些牌
                local reqCardNum = param[1]
                local reqSkillLabel = param[2]
                local reqStar = param[3]
                local layerType = param[4]

                local cards = cardMgr:FindCardsByFunc(function (card, pos)
                    local skillCardData = cardMgr:GetCardSkillByPos(pos)
                    return (reqSkillLabel == 0 or skillCardData.label == reqSkillLabel) and (1 << (card.star - 1)) & reqStar ~= 0 and not card.isUltra
                end)
                if reqCardNum < #cards then
                    --牌数量大于需求量则需要随机一下
                    Core:Shuffle(cards)
                    while reqCardNum < #cards do
                        table.remove(cards)
                    end
                end

                local layer = calcLayer(cards, layerType)
                local recs = cardMgr:RemoveCards(cards)
                RecordMgr:AddRecords(recs)
                for i=5,#param do
                    local buffId = param[i]
                    for j=1,layer do
                        attacker.buffMgr:AddBuff(attacker, Core:GetBuffData(buffId, 1, 1), 1, effectParams)
                    end
                end
            end
        end,
        [3] = function ()
            local cardMgr = attacker:GetCardMgr()
            if cardMgr then
                --判断需要移除哪些牌
                local reqCardNum = param[1]
                local reqSkillIndex = param[2]
                local reqStar = param[3]
                local layerType = param[4]

                local cards = cardMgr:FindCardsByFunc(function (card, pos)
                    return attacker.id == card.roleId and (reqSkillIndex == 0 or card.skillIndex == reqSkillIndex) and  (1 << (card.star - 1)) & reqStar ~= 0 and not card.isUltra
                end)

                if reqCardNum < #cards then
                    --牌数量大于需求量则需要随机一下
                    Core:Shuffle(cards)
                    while reqCardNum < #cards do
                        table.remove(cards)
                    end
                end

                if layerType == nil then
                    -- 只移除牌，不施加buff
                    local recs = cardMgr:RemoveCards(cards)
                    RecordMgr:AddRecords(recs)
                else
                    local hasSkillA = false
                    local hasSkillB = false
                    for i, card in ipairs(cards) do
                        if card.skillIndex == 1 then
                            hasSkillA = true
                        elseif card.skillIndex == 2 then
                            hasSkillB = true
                        end
                    end

                    local layer = calcLayer(cards, layerType)
                    local recs = cardMgr:RemoveCards(cards)
                    RecordMgr:AddRecords(recs)

                    if hasSkillA then
                        local buffId = param[5]
                        for j=1,layer do
                            attacker.buffMgr:AddBuff(attacker, Core:GetBuffData(buffId, 1, 1), 1, effectParams)
                        end
                    end
                    if hasSkillB then
                        local buffId = param[6]
                        for j=1,layer do
                            attacker.buffMgr:AddBuff(attacker, Core:GetBuffData(buffId, 1, 1), 1, effectParams)
                        end
                    end
                end
            end
        end,
    }
    local func = switch[effectRec.effectData.subEffectType]
    assert(func, '找不到移除卡牌方式:'..effectRec.effectData.subEffectType)
    func()
end

--- 触发技能
--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BattleMgr:HandleTriggerSkill(effectParams)
    local attacker = effectParams.attacker  -- buff触发时的owner
    local mainTarget = effectParams.mainTarget
    local effectId = effectParams.skillEffectID
    local star = effectParams.star
    local nowTriggerNode = effectParams.nowTriggerNode
    local effectRec = effectParams.effectRec
    local effecParam = effectRec.effectData.effectNum1
    
    local switch = {
        [1] = function()
            -- 触发buff拥有者当前正释放的技能
            local buff = self:GetNowTriggerBuff()
            if isNull(buff) then
                printError("技能效果22;1;1 必须由buff触发")
                return
            end
            local currentSkillRec = self:GetNowSkillRecord()
            if isNull(currentSkillRec) then
                print("没有正释放的技能，不能触发")
                return
            end

            local skill = currentSkillRec.skill
            local skillCardId = skill.skillCardId
            if isNull(skillCardId) then
                print("正释放的技能没有skillCardId")
                return
            end

            local t = Core:BuffTriggerSkillSelectTarget(buff, skillCardId, attacker, mainTarget)
            
            -- 效果触发技能的相关参数
            local triggerEffectParams = {
                mainEffectType = effectRec.effectData.mainEffectType,
                subEffectType = effectRec.effectData.mainEffectType,
                miniEffectType = effectRec.effectData.miniEffectType,
                ratioModifier = effecParam[1],
            }
            
            local star = skill.star
            --处于技能作用中时，加入技能树等候
            if self.isInSkill then
                self:AddTrigSkillCard(attacker, t, skillCardId, star , nowTriggerNode, triggerEffectParams )
            else
                --否则直接释放
                self:HandleSkillCard(attacker, t, skillCardId, star , nil , nil , nowTriggerNode, triggerEffectParams)
            end
        end,
        [2] = function()
            -- 触发buff拥有者当前正释放的技能
            local buff = self:GetNowTriggerBuff()
            if isNull(buff) then
                printError("技能效果22;1;2 必须由buff触发")
                return
            end

            local skillIndex = effecParam[1]
            local star = effecParam[2]

            -- 如果是大招，使用养成的等级
            if skillIndex == 0 then
                star = attacker.ultraStar or 1
            end
            
            local skillCardId = attacker:GetSkillCardIdByIndex(skillIndex)
            local triggerEffectParams = nil

            local t = Core:BuffTriggerSkillSelectTarget(buff, skillCardId, attacker, mainTarget)

            --处于技能作用中时，加入技能树等候
            if self.isInSkill then
                self:AddTrigSkillCard(attacker, t, skillCardId, star , nowTriggerNode, triggerEffectParams )
            else
                --否则直接释放
                self:HandleSkillCard(attacker, t, skillCardId, star , nil , nil , nowTriggerNode, triggerEffectParams)
            end
        end,
        [3] = function()
            local buff = self:GetNowTriggerBuff()
            if isNull(buff) then
                printError("技能效果22;1;3 必须由buff触发")
                return
            end

            local cardMgr = attacker:GetCardMgr()
            if cardMgr then
                -- 指定的星级参数
                local star = effecParam[1]
 
                -- 查找指定星级的卡牌
                local cards = cardMgr:FindCardsByFunc(function (card, pos)
                    return card.star == star
                end)

                if #cards == 0 then
                    return
                end

                -- 依次触发卡牌技能
                for i, card in ipairs(cards) do
                    local skillIndex = card.skillIndex

                    local roleId = card.roleId
                    local role = Core:FindRole(roleId)
                    local skillCardId = role:GetSkillCardIdByIndex(skillIndex)

                    local skillCardVo = Core:GetSkillCardData(skillCardId)

                    -- 特殊卡牌的处理
                    if skillCardVo.cardBehavior == Constants.CardBehavior.Swallow then
                        -- 不用吞噬
                    elseif skillCardVo.cardBehavior == Constants.CardBehavior.Search then
                        -- 忽略发现效果
                    elseif skillCardVo.cardBehavior == Constants.CardBehavior.Choose then
                        -- 随机选择一个
                        local skillIndexList = skillCardVo.cardBehaviorParam
                        local count = #skillIndexList
                        local randomIndex = Core.Random(count, 1)
                        skillIndex = skillIndexList[randomIndex]
                        skillCardId = attacker:GetSkillCardIdByIndex(skillIndex)
                    end

                    local t = Core:BuffTriggerSkillSelectTarget(buff, skillCardId, role, mainTarget)

                    local triggerEffectParams = nil

                    --处于技能作用中时，加入技能树等候
                    if self.isInSkill then
                        self:AddTrigSkillCard(role, t, skillCardId, star , nowTriggerNode, triggerEffectParams )
                    else
                        --否则直接释放
                        self:HandleSkillCard(role, t, skillCardId, star , nil , nil , nowTriggerNode, triggerEffectParams)
                    end
                end
                -- 从牌库中移除卡牌
                local recs = cardMgr:RemoveCards(cards, true)
                RecordMgr:AddRecords(recs)
            end
        end,
    }

    local func = switch[effectRec.effectData.miniEffectType]
    assert(func, '触发技能效果 没有三类 '..effectRec.effectData.miniEffectType)
    func()
end

--- 护盾消耗
---@param effectParams any
function BattleMgr:HandleShieldChange(effectParams)
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1

    local switch = {
        [1] = function(target)
            local script = Core:GetDamageHandler(effectRec.effectData.miniEffectType)
            local dmgRec = RecordMgr.DamageRecord.New(target, attacker)
            local damage = script:GetDamage(attacker, target, effectRec, dmgRec)
            damage = math.floor( damage )
            local damageTypeVo = Core:GetDamageData(1)
            local finalDmg, remainShield, lostShield = target.buffMgr:ShieldAbsorb(damage, damageTypeVo, attacker)
        end
    }

    local targets = effectRec.targets
    for i,target in ipairs(targets) do
        if not target:IsDead() then
            local func = switch[effectRec.effectData.subEffectType]
            assert(func, '护盾消耗 没有二类 '..effectRec.effectData.subEffectType)
            func(target)
        end
    end
end

--- 操作自身特殊寄存器
---@param effectParams any
function BattleMgr:HandleOperateSpecialRegister(effectParams)
    local attacker = effectParams.attacker
    local mainTarget = effectParams.mainTarget
    local effectRec = effectParams.effectRec
    local targets = effectRec.targets
    local param = effectRec.effectData.effectNum1

    local trigBuff = effectParams.trigBuff  -- 触发器
    local trigData = effectParams.trigData  -- 触发数据

    local switch = {
        -- 当前存数+Num1
        [1] = function(attacker)
            local roleContextData = attacker.roleContextData
            roleContextData:AddRegister1(param[1])
        end,
        -- 当前存数*Num1
        [2] = function(attacker)
            local roleContextData = attacker.roleContextData
            roleContextData:MultiRegister1(param[1])
        end,
        -- 当前存数+技能主效果施加的伤害效果×Num1
        [3] = function(attacker)
            local dmgs = 0
            local dmgRecs = self:GetNowSkillDamageRecs()
            for i,rec in ipairs(dmgRecs) do
                if rec:IsDamage() then
                    dmgs = dmgs + rec.finalDamage
                end
            end
            local roleContextData = attacker.roleContextData
            roleContextData:AddRegister1(dmgs * param[1])
        end,
        -- 当前存数+技能主效果施加的治疗效果×Num1
        [4] = function(attacker)
            local dmgs = 0
            local dmgRecs = self:GetNowSkillDamageRecs()
            for i,rec in ipairs(dmgRecs) do
                if rec:IsHeal() then
                    dmgs = dmgs + rec.finalDamage
                end
            end
            local roleContextData = attacker.roleContextData
            roleContextData:AddRegister1(-dmgs * param[1])
        end,
        -- 当前存数+触发器传入的伤害量×Num1
        [5] = function(attacker)
            if isNull(trigBuff) or isNull(trigData) then
                printError("技能效果22;1;5 必须由buff触发")
                return
            end
            local TriggerMainType = Constants.TriggerMainType
            local triggerId = trigBuff.data.effectTrigger
            local trigTypeData = Core:GetTriggerData(triggerId)
            local mainType = trigTypeData.mainType

            if (mainType == TriggerMainType.Attack 
            or mainType == TriggerMainType.BeAttack) then
                local dmgRec = trigData.damageRec
                if dmgRec:IsDamage() then
                    local roleContextData = attacker.roleContextData
                    roleContextData:AddRegister1(dmgRec.finalDamage * param[1])
                end
            elseif (mainType == TriggerMainType.OtherAttack
            or mainType == TriggerMainType.OtherAttack2
            or mainType == TriggerMainType.OtherBeAttack
            or mainType == TriggerMainType.OtherBeAttack2) then
                local dmgs = 0
                local dmgRecs = trigData.damageRecs
                for i,rec in ipairs(dmgRecs) do
                    if rec:IsDamage() then
                        dmgs = dmgs + rec.finalDamage
                    end
                end
                local roleContextData = attacker.roleContextData
                roleContextData:AddRegister1(dmgs * param[1])
            else
                printError("效果24;5;1 只能用于触发器10,20,54,58,57,61")
            end
        end,
        -- 当前存数+sp最高友方sp点数
        [6] = function(attacker)
            local maxSPValue = 0
            local roles = self:GetAliveRoles( attacker.camp )
            for i, role in ipairs(roles) do
                if role.id ~= attacker.id then
                    local sp = role:GetUltraPoint()
                    maxSPValue = math.max(maxSPValue, sp)
                end
            end
            local roleContextData = attacker.roleContextData
            roleContextData:AddRegister1(maxSPValue)
        end,
        -- 当前存数+友方sp点数总和
        [7] = function(attacker)
            local totalSPValue = 0
            local roles = self:GetAliveRoles( attacker.camp )
            for i, role in ipairs(roles) do
                local sp = role:GetUltraPoint()
                totalSPValue = totalSPValue + sp
            end
            local roleContextData = attacker.roleContextData
            roleContextData:AddRegister1(totalSPValue)
        end,
    }

    local func = switch[effectRec.effectData.subEffectType]
    assert(func, '操作特殊寄存器 没有二类 '..effectRec.effectData.subEffectType)
    func(attacker)
end

return  BattleMgr