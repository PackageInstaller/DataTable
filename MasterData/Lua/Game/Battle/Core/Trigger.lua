--
-- Author:luqucheng
-- Date: 2019-10-28 17:10:54
--
local Core = import('Game.Battle.Core.Core')
local ParseUtils = CS.ParseUtils

local Trigger = {}



--[[
    @desc: 
    author:luqucheng
    time:2019-10-31 14:38:56
    --@triggerID:触发器Id
	--@trigMainType:触发类型
	--@owner:触发器拥有者
	--@target:触发目标
	--@trigData:触发时的附带参数
	--@conditionDatas: 触发器条件参数
    @return:
]]
function Trigger.CheckTrigger( triggerID, trigMainType, owner, target, trigData, conditionDatas, trigger  )
    --优先判断不需要触发和肯定会触发的情况，就不需要去读配置了

    if triggerID == 0 then
        return false
    elseif triggerID == 1 then
        return true
    end
    --获得触发器配置
    local data = Trigger.GetTriggerData(triggerID)

    --判断主条件是否相同，不同直接返回
    if data.mainType ~= trigMainType then
        return false
    end

    --判断各个子条件
    --所有子条件是且的关系，并且条件的结果与期望是否为真的效果都匹配，即算触发成功
    local success = Trigger.CheckCondition(data.condition[1], conditionDatas[1], owner, target, trigData, trigger) == (data.conditionIsTrue[1] == 1)
                and Trigger.CheckCondition(data.condition[2], conditionDatas[2], owner, target, trigData, trigger) == (data.conditionIsTrue[2] == 1)
                and Trigger.CheckCondition(data.condition[3], conditionDatas[3], owner, target, trigData, trigger) == (data.conditionIsTrue[3] == 1)
                and Trigger.CheckCondition(data.condition[4], conditionDatas[4], owner, target, trigData, trigger) == (data.conditionIsTrue[4] == 1)
                and Trigger.CheckCondition(data.condition[5], conditionDatas[5], owner, target, trigData, trigger) == (data.conditionIsTrue[5] == 1)
    
    if success then
        ConditionMgr:UpdateConditionData(Constants.GameOverCondition.TriggerSuccessTimes, triggerID)
    end
    return success, data.isFinal
end

--[[
    @desc: 
    author:luqucheng
    time:2019-12-30 19:42:46
    --@conditionID:
	--@conditionData:
	--@owner:[Game.Battle.Entity.Role#Role]
	--@target:[Game.Battle.Entity.Role#Role]
	--@trigData: 
    @return:
]]
function Trigger.CheckCondition( conditionID, conditionData, owner, target, trigData, trigger )
    local tst = Constants.TriggerSubType
    local switch = {
        [tst.Direct] = function (  )
            return false
        end,
        [tst.Probability] = function (  )
            local rate = Core.Random()
            return rate <= conditionData[1]
        end,
        [tst.ProbabilityEnhanceByBuff] = function (  )
            if trigData.trigger == nil then
                printError("触发器子条件135 没有找到触发器buff")
            end
            local layNum = trigData.trigger.layNum
            local rate = Core.Random()
            return rate <= conditionData[1] * layNum
        end,
        [tst.OwnAttributeValue] = function (  )
            return owner:GetAttr(conditionData[1]) > conditionData[2]
        end,
        [tst.TargetHpPercent] = function (  )
            return (target:GetAttr(Constants.AttrTypeId.NowHp) / target:GetAttr(Constants.AttrTypeId.Hp)) > conditionData[1]
        end,
        [tst.OwnHpPercent] = function (  )
            return (owner:GetAttr(Constants.AttrTypeId.NowHp) / owner:GetAttr(Constants.AttrTypeId.Hp)) > conditionData[1]
        end,
        [tst.OwnBuffNumber] = function (  )
            return owner.buffMgr:GetBuffOrDebuffNum(false) > conditionData[1]
        end,
        [tst.OwnDebuffNumber] = function (  )
            return owner.buffMgr:GetBuffOrDebuffNum(true) > conditionData[1]
        end,
        [tst.TargetBuffNumber] = function (  )
            return target.buffMgr:GetBuffOrDebuffNum(false) > conditionData[1]
        end,
        [tst.TargetDebuffNumber] = function (  )
            return target.buffMgr:GetBuffOrDebuffNum(true) > conditionData[1]
        end,
        [tst.TargetBuffTypeNumber] = function (  )
            return target.buffMgr:GetBuffTypeNumber(conditionData[1], conditionData[2], conditionData[3], conditionData[4]) > conditionData[5]
        end,
        [tst.OwnerBuffTypeNumber] = function (  )
            return owner.buffMgr:GetBuffTypeNumber(conditionData[1], conditionData[2], conditionData[3], conditionData[4]) > conditionData[5]
        end,
        [tst.UltraPointNumber] = function (  )
            return target:GetUltraPoint() > conditionData[1]
        end,
        [tst.OwnBuffID] = function (  )
            local lay = conditionData[2] or 0
            return owner.buffMgr:GetBuffLayNumByBuffTypeID(conditionData[1]) > lay
        end,
        [tst.BuffTurnOver] = function (  )
            return trigData.isTurnOver
        end,
        [tst.CheckBuffType] = function (  )
            return trigData.buff.data.buffType == conditionData[1]
        end,
        [tst.IsBuffID] = function (  )
            return trigData.buff.data.id == conditionData[1]
        end,
        [tst.SkillInCD] = function (  )
            return owner:IsSkillInCD(conditionData[1])
        end,
        [tst.TargetDead] = function (  )
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            if #trigData.skillRec.mainTargets > 1 then
                -- 如果技能是aoe，只要有目标死了就算触发成功
                for i, tar in ipairs(trigData.skillRec.mainTargets) do
                    if tar and tar:IsDead() then
                        return true
                    end
                end
                return false
            else
                return target and target:IsDead()
            end
        end,
        [tst.IsHit] = function (  )
            if not trigData.damageRec then
                printError('触发时需要的伤害数据不存在:'..conditionID)
                return false
            end
            return trigData.damageRec.isHit
        end,
        [tst.IsMiss] = function (  )
            if not trigData.damageRec then
                printError('触发时需要的伤害数据不存在:'..conditionID)
                return false
            end
            return not trigData.damageRec.isHit
        end,
        [tst.IsCrit] = function (  )
            if not trigData.damageRec then
                -- printError('触发时需要的伤害数据不存在:'..conditionID)
                return trigData.isCrit
            end
            return trigData.damageRec.isCrit
        end,
        [tst.EnemyAliveNumber] = function (  )
            local rs = BattleMgr:GetAliveRoles(BattleMgr:GetOppoCamp(owner.camp))
            return #rs > conditionData[1]
        end,
        [tst.FriendAliveNumber] = function (  )
            local rs = BattleMgr:GetAliveRoles(owner.camp)
            return #rs > conditionData[1]
        end,
        [tst.BuffAddRound] = function (  )
            return (trigData.trigger.data.round - trigData.trigger.remainRound) * 2 > conditionData[1]
        end,
        [tst.IsSkillId] = function (  )
            --@RefType[Game.Battle.Record.SkillRecord#SkillRecord]
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            local skillRec = trigData.skillRec
            return skillRec.skill.skillId == conditionData[1]
        end,
        [tst.IsInputSkill] = function (  )
            if trigData.skillCard then
                return trigData.skillCard.isInputSkill == true
            end
            if trigData.skillRec then
                return trigData.skillRec.isInputSkill == true
            end
            return false
        end,
        [tst.IsFriend] = function (  )
            return not Core:IsEnemy(owner.camp, target.camp)
        end,
        [tst.IsEnemy] = function (  )
            return Core:IsEnemy(owner.camp, target.camp)
        end,
        [tst.IsSelf] = function (  )
            return owner.id == target.id
        end,
        [tst.IsBuffType] = function (  )
            return (conditionData[1] == 0 or trigData.buff.mainEffectType == conditionData[1])
            and (conditionData[2] == 0 or trigData.buff.subEffectType == conditionData[2])
            and (conditionData[3] == 0 or trigData.buff.miniEffectType == conditionData[3])
        end,
        [tst.WeakRemain] = function (  )
            --@RefType[Game.Battle.Entity.Role#Role]
            local role = trigData.trigger.owner
            return (role.weakMaxCount - role.weakCount) > conditionData[1] 
        end,
        [tst.OwnUltraPointNumber] = function (  )
            return owner:GetUltraPoint() > conditionData[1]
        end,
        [tst.IsUltra] = function (  )
            --@RefType[Game.Battle.Record.SkillRecord#SkillRecord]
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            local skillRec = trigData.skillRec
            return skillRec.skill:IsUltra()
        end,
        [tst.TargetBuffLayNum] = function (  )
            local lay = conditionData[2] or 0
            return target.buffMgr:GetBuffLayNumByBuffTypeID(conditionData[1]) > lay
        end,
        [tst.SkillLabel] = function (  )
            --@RefType[Game.Battle.Record.SkillRecord#SkillRecord]
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            local skillRec = trigData.skillRec
            return skillRec.skill.label == conditionData[1]
        end,
        [tst.RoundOddOrEven] = function (  )
            local n = BattleMgr.totalTurnCount % 2
            if conditionData[1] == 1 then
                return n == 1
            else
                return n == 0
            end
        end,
        [tst.IsAoe] = function (  )
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            return #trigData.skillRec.mainTargets > conditionData[1]
        end,
        [tst.CheckBuffIsThisTrigger] = function (  )
            if not trigger or not trigData.buff then
                return false
            end
            return trigger.id == trigData.buff.id
        end,
        [tst.SkillStar] = function (  )
            --@RefType[Game.Battle.Record.SkillRecord#SkillRecord]
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            local skillRec = trigData.skillRec
            return (1 << (skillRec.skill.star - 1)) & conditionData[1] ~= 0
        end,
        [tst.IsAttackerElementAdvantage] = function (  )
            if not target then
                return false
            end
            local rate = Core:GetElementCounteDamage(owner.elementType, target.elementType)
            return rate > 1
        end,
        [tst.IsTargetElementAdvantage] = function (  )
            if not target then
                return false
            end
            local rate = Core:GetElementCounteDamage(owner.elementType, target.elementType)
            return rate < 1
        end,
        [tst.TargetCareer] = function (  )
            if not target then
                return false
            end
            return target.career == conditionData[1]
        end,
        [tst.MaxHpCompare] = function (  )
            if not target then
                return false
            end
            return (target:GetAttr(Constants.AttrTypeId.Hp) / owner:GetAttr(Constants.AttrTypeId.Hp)) > (1 + conditionData[1])
        end,
        [tst.IsCardUpgrade] = function (  )
            return trigData.isCardUpgrade
        end,
        [tst.SelfCareer] = function (  )
            return owner.career == conditionData[1]
        end,
        [tst.SelfElement] = function (  )
            return owner.elementType == conditionData[1]
        end,
        [tst.IsHugeHit] = function (  )
            if not trigData.damageRec then
                printError('触发时需要的伤害数据不存在:'..conditionID)
                return false
            end
            if trigData.damageRec.hpChange <= 0 then
                return false
            end
            
            return (trigData.damageRec.hpChange / trigData.damageRec.target:GetAttr(Constants.AttrTypeId.Hp)) > conditionData[1]
        end,
        [tst.SkillHitCount] = function (  )
            --@RefType[Game.Battle.Record.SkillRecord#SkillRecord]
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            return #trigData.skillRec.skill.hitRatio > conditionData[1]
        end,
        [tst.NoAoeMark] = function (  )
            --@RefType[Game.Battle.Record.SkillRecord#SkillRecord]
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            return not trigData.skillRec.skill.isAoe
        end,
        [tst.HasMyAngry] = function (  )
            local Special = Constants.BuffType.Special
            local Angry = Constants.SpecialBuffType.Angry
            local has = false
            target.buffMgr:WalkAllBuffEffects(function (buffEffect)
                local buff = buffEffect.buff
                if buffEffect.data.mainEffectType == Special and buffEffect.data.subEffectType == Angry and buff.attacker and buff.attacker.id == owner.id then
                    has = true
                    return true
                end
            end)
      
            return has
        end,
        [tst.IsOwnerSkillMainTarget] = function (  )
            --@RefType[Game.Battle.Record.SkillRecord#SkillRecord]
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            for i,role in ipairs(trigData.skillRec.mainTargets) do
                if role.id == owner.id then
                    return true
                end
            end
            return false
        end,
        [tst.TargetMonsterClass] = function (  )
            if not target or not conditionData  then
                return false
            end

            return conditionData[1] == math.min(target.monsterClass, 2)
        end,
        [tst.SkillTags] = function (  )
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            for i, v in ipairs(trigData.skillRec.skill.skillTags) do
                if v == conditionData[1] then
                    return true
                end
            end
           return false
        end,
        [tst.RoundCount] = function (  )
            if not conditionData  then
                return false
            end

            return conditionData[1] == BattleMgr.totalTurnCount
        end,
        [tst.IsTargetSpecialSummon] = function (  )
            if not target then
                return false
            end
            return target.roleType == Constants.RoleType.SpecialSummon
        end,
        [tst.PseudoRandom] = function (  )
            local envData = Core:GetTriggerEnvData(Constants.TriggerSubType.PseudoRandom)
            local key = Core:GetPseudoRandomKey(trigData)

            local pseudoRandomId = envData[key]
            if pseudoRandomId == nil then
                pseudoRandomId = Core:RegisteredPseudoRandom({
                    pseudoRandomFunc = Bind(Core, Core.DefaultPseudoRandom),  

                    originRate = conditionData[2],          -- 初始概率
                    increaseRate = conditionData[3],        -- 概率增量
                    regressionRate = conditionData[4],      -- 回归值
                })
                envData[key] = pseudoRandomId
            end

            return Core:PseudoRandom(pseudoRandomId)
        end,
        [tst.TargetElement] = function (  )
            if not target or not conditionData  then
                return false
            end
            return target.elementType == conditionData[1]
        end,
        [tst.IsSkillCardId] = function ()
            if trigData.skillCard then
                return trigData.skillCard.skillCardData.id == conditionData[1]
            end
            if trigData.skillRec then
                return trigData.skillRec.skill.skillCardId == conditionData[1]
            end
            return false
        end,
        [tst.IsBuffStar] = function (  )
            return trigData.buff.data.star == conditionData[1]
        end,
        [tst.IsBuffStarEqual] = function (  )
            return trigData.buff.data.star == trigData.trigger.data.star
        end,
        [tst.TargetCatType] = function (  )
            if not target or not conditionData  then
                return false
            end
            return target.catType == conditionData[1]
        end,
        [tst.SelfCatType] = function (  )
            return owner.catType == conditionData[1]
        end,
        [tst.HasRoleId] = function (  )
            local rs = Core:GetCampTargets(owner, BattleMgr.roles, conditionData[2])
            for i,v in ipairs(rs) do
                if v.typeId == conditionData[1] then
                    return true
                end
            end
            return false
        end,
        [tst.HasCharacterId] = function (  )
            local rs = Core:GetCampTargets(owner, BattleMgr.roles, conditionData[2])
            for i,v in ipairs(rs) do
                if v.characterId == conditionData[1] then
                    return true
                end
            end
            return false
        end,
        [tst.HasRace] = function (  )
            local rs = Core:GetCampTargets(owner, BattleMgr.roles, conditionData[2])
            for i,v in ipairs(rs) do
                if v.race == conditionData[1] then
                    return true
                end
            end
            return false
        end,
        [tst.HasCatType] = function (  )
            local rs = Core:GetCampTargets(owner, BattleMgr.roles, conditionData[2])
            for i,v in ipairs(rs) do
                if v.catType == conditionData[1] then
                    return true
                end
            end
            return false
        end,
        [tst.HasElement] = function (  )
            local rs = Core:GetCampTargets(owner, BattleMgr.roles, conditionData[2])
            for i,v in ipairs(rs) do
                if v.elementType == conditionData[1] then
                    return true
                end
            end
            return false
        end,
        [tst.EveryRace] = function (  )
            local rs = Core:GetCampTargets(owner, BattleMgr.roles, conditionData[2])
            for i,v in ipairs(rs) do
                if v.race ~= conditionData[1] then
                    return false
                end
            end
            return true
        end,
        [tst.EveryCatType] = function (  )
            local rs = Core:GetCampTargets(owner, BattleMgr.roles, conditionData[2])
            for i,v in ipairs(rs) do
                if v.catType ~= conditionData[1] then
                    return false
                end
            end
            return true
        end,
        [tst.EveryElement] = function (  )
            local rs = Core:GetCampTargets(owner, BattleMgr.roles, conditionData[2])
            for i,v in ipairs(rs) do
                if v.elementType ~= conditionData[1] then
                    return false
                end
            end
            return true
        end,
        [tst.TargetRace] = function (  )
            if not target or not conditionData  then
                return false
            end
            return target.race == conditionData[1]
        end,
        [tst.SelfRace] = function (  )
            return owner.race == conditionData[1]
        end,
        [tst.DamageType] = function (  )
            if not trigData.damageRec then
                -- 伤害数据不存在时，尝试使用技能数据的主效果进行判断
                if not trigData.skillRec then
                    printError('触发时需要的伤害数据和技能数据均不存在:'..conditionID)
                    return false
                else
                    local skill = trigData.skillRec.skill
                    local isSPSkill = skill.skillType == 3
                    -- print("技能 ", table.dump(skill, nil, 3))
                    local effectType = skill.damageEffectType
                    if effectType == 2 then
                        local effectData = Core:GetSkillEffectData(skill.damageEffect, skill.star, skill.lv, isSPSkill, isSPSkill)
                        local isDamageEffect = effectData.mainEffectType == Constants.SkillEffectMainType.DirectDamage
                        if isDamageEffect then
                            local damageTypeVo = Core:GetDamageData(effectData.subEffectType)
                            return damageTypeVo.id == conditionData[1]
                        else
                            return false
                        end
                    else
                        return false
                    end
                end
            else
                return trigData.damageRec.damageType == conditionData[1]
            end
        end,
        [tst.CompareHpPercent] = function (  )
            if isNull(owner) or isNull(target) then
                printError('触发时没有目标:'..conditionID)
                return false
            end
            local ownerHpPercent = (owner:GetAttr(Constants.AttrTypeId.NowHp) / owner:GetAttr(Constants.AttrTypeId.Hp))
            local targetHpPercent = (target:GetAttr(Constants.AttrTypeId.NowHp) / target:GetAttr(Constants.AttrTypeId.Hp))
            return ownerHpPercent > targetHpPercent
        end,
        [tst.IsSPSkill] = function (  )
            if not trigData.damageRec then
                printError('触发时需要的伤害数据不存在:'..conditionID)
                return false
            end
            return trigData.damageRec.isSPSkill or false
        end,
        [tst.IsSPSkillMainEffect] = function (  )
            if not trigData.damageRec then
                printError('触发时需要的伤害数据不存在:'..conditionID)
                return false
            end
            return trigData.damageRec.IsSPSkillMainEffect or false
        end,
        [tst.BuffIdTotalLayerNum] = function (  )
            local buffId = conditionData[1] or 0
            local targetLayerNum = conditionData[2] or 0
            local campType = conditionData[3] or 0
            local rs = Core:GetCampTargets(owner, BattleMgr.roles, campType)
            local totalLayerNum = 0
            for i,v in ipairs(rs) do
                totalLayerNum = totalLayerNum + v.buffMgr:GetBuffLayNumByBuffTypeID(buffId)
            end
            return totalLayerNum > targetLayerNum
        end,
        [tst.BuffTypeTotalLayerNum] = function (  )
            local mainType = conditionData[1] or 0
            local subType = conditionData[2] or 0
            local miniType = conditionData[3] or 0
            local BufforDebuff = conditionData[4] or 0
            local targetLayerNum = conditionData[5] or 0
            local selectType = conditionData[6] or 0

            local rs
            if selectType == 3 then
                -- 选择拥有者
                rs = {owner}
            elseif selectType == 4 then
                -- 选择目标
                rs = {target}
            else
                -- 按阵营选择
                rs = Core:GetCampTargets(owner, BattleMgr.roles, selectType)
            end
            
            local totalLayerNum = 0
            for i,v in ipairs(rs) do
                totalLayerNum = totalLayerNum + v.buffMgr:GetBuffTypeLayNum(mainType, subType, miniType, BufforDebuff)
            end
            return totalLayerNum > targetLayerNum
        end,
        [tst.SPChangeSourceType] = function (  )
            if isNull(trigData.spChangeSourceType) then
                printError('触发时需要的sp点数改变数据不存在:'..conditionID)
                return false
            end
            local type = conditionData[1] or 1
            return trigData.spChangeSourceType == type
        end,
        [tst.IsSPIncrease] = function (  )
            if isNull(trigData.changePoint) then
                printError('触发时需要的sp点数改变数据不存在:'..conditionID)
                return false
            end
            return trigData.changePoint > 0
        end,
        [tst.SkillEffectSourceType] = function (  )
            if isNull(trigData.damageRec) then
                printError('触发时需要的伤害数据不存在:'..conditionID)
                return false
            end
            local HitFromType = Constants.HitFromType
            conditionData = checkTable(conditionData)
            local type = conditionData[1] or 0
            if type == 0 then
                -- 仅主效果
                return trigData.damageRec.hitFromType == HitFromType.SkillMainEffect
            elseif type == 1 then
                -- 仅子效果
                return trigData.damageRec.hitFromType == HitFromType.SkillSubEffect
            elseif type == 2 then
                -- 主效果和子效果
                return trigData.damageRec.hitFromType == HitFromType.SkillMainEffect 
                    or trigData.damageRec.hitFromType == HitFromType.SkillSubEffect
            elseif type == 3 then
                -- 主效果和子效果和伤害链接效果
                return trigData.damageRec.hitFromType == HitFromType.SkillMainEffect 
                    or trigData.damageRec.hitFromType == HitFromType.SkillSubEffect
                    or trigData.damageRec.hitFromType == HitFromType.DamageLink
            elseif type == 4 then
                -- 仅伤害链接效果
                return trigData.damageRec.hitFromType == HitFromType.DamageLink
            end
            return false
        end,
        -- 指定系统id生效
        [tst.IsSystemId] = function()
            local targetSystemId = conditionData[1] or 0
            local currentSystemId = BattleInfo.initData.systemId or 0
            return currentSystemId == targetSystemId
        end,
        -- 角色星级
        [tst.RoleStar] = function()
            local targetStar = conditionData[1]
            local operator = conditionData[2]
            if owner.isPlayer then
                local ownerStar = owner.rawData.star
                if operator == 0 then
                    return ownerStar == targetStar
                elseif operator == 1 then
                    return ownerStar >= targetStar
                elseif operator == 2 then
                    return ownerStar <= targetStar
                end
                return false
            else
                return false
            end
        end,
        -- 角色卡牌id
        [tst.CardId] = function()
            local cardId = conditionData[1]
            return cardId == owner.rawData.typeId
        end,
        -- 携带者携带的任意Num6个 大类=Num1，二类=Num2，三类=Num3，增减益=Num4（填0表示增减益都算入）的buff层数≥Num5层数时触发
        [tst.AnyBuffLayerNum] = function()
            local num1 = conditionData[1]
            local num2 = conditionData[2]
            local num3 = conditionData[3]
            local num4 = conditionData[4]
            local num5 = conditionData[5]
            local num6 = conditionData[6]

            local count = 0
            owner.buffMgr:WalkAllBuff(function ( v )
                if owner.buffMgr:IsBuffByType(v, num1, num2, num3, num4)
                and v.layNum >= num5 then
                    count = count + 1
                end
            end)

            return count >= num6
        end,
        -- 若携带者某项属性大于等于进入战斗时初始值则触发（num1：属性ID）
        [tst.AttrChange] = function()
            local num1 = conditionData[1]
            local base = owner:GetBaseAttr(num1)
            local now = owner:GetAttr(num1)
            return (now - base) >= 0
        end,
        -- 主体对方阵营携带的减益效果总层数大于Num1生效
        [tst.OppoCampDebuffLayerNum] = function (  )
            local num1 = conditionData[1]
            local totalNum = 0
            local camp = BattleMgr:GetOppoCamp(owner.camp)
            local roles = BattleMgr:GetAliveRoles(camp)
            for i, role in ipairs(roles) do
                local num = role.buffMgr:GetBuffOrDebuffLayers(true)
                totalNum = totalNum + num
                if totalNum > num1 then
                    return true
                end
            end
            return false
        end,
        -- 主体方阵营携带的增益效果总层数大于Num1生效
        [tst.OwnerCampBuffLayerNum] = function (  )
            local num1 = conditionData[1]
            local totalNum = 0
            local camp = owner.camp
            local roles = BattleMgr:GetAliveRoles(camp)
            for i, role in ipairs(roles) do
                local num = role.buffMgr:GetBuffOrDebuffLayers(false)
                totalNum = totalNum + num
                if totalNum > num1 then
                    return true
                end
            end
            return false
        end,
        -- 若携带者某项属性大于进入战斗时初始值则触发（num1：属性ID，num2：大于小于）
        [tst.AttrChange1] = function()
            local num1 = conditionData[1]
            local num2 = conditionData[2]
            local base = owner:GetBaseAttr(num1)
            local now = owner:GetAttr(num1)
            if num2 == 1 then
                return (now - base) > 0
            elseif num2 == 2 then
                return (now - base) < 0
            end
            return false
        end,
        -- 同id的buff是否可以叠加
        [tst.IsSameIdBuffCanStack] = function()
            return trigData.buff.data.sameBuffStackingType == Constants.BuffLayType.Stack
        end,
        -- 指定阵营，指定角色，指定id的buff是否存在
        [tst.CampRoleHasBuff] = function()
            local camp = conditionData[1]
            local roleId = conditionData[2]
            local buffId = conditionData[3]
            local camp = camp == 0 and owner.camp or BattleMgr:GetOppoCamp(owner.camp)
            local roles = BattleMgr:GetAliveRoles(camp)
            for i, role in ipairs(roles) do
                if role.typeId == roleId then
                    return role.buffMgr:HasBuffByBuffTypeID(buffId)
                end
            end
            return false
        end,
        -- buff拥有者身上是否存在相同id的buff，且达到最大层数
        [tst.HasSameMaxLayerBuff] = function()
            local hasAndMax = false
            local targetId = trigData.buff.data.id
            owner.buffMgr:WalkAllBuff(function ( v )
                if v.data.id == targetId
                and v:IsMaxLayer() then
                    hasAndMax = true
                    return true
                end
            end)
            return hasAndMax
        end,
        -- 判断携带者相邻目标和携带者自身，身上id=Num1的buff总个数>Num2个
        [tst.NeighborBuffNum] = function()
            local camp = owner.camp
            local pos = owner.standPosition
            local num1 = conditionData[1]
            local num2 = conditionData[2]
            local neighbors = {owner}
            local role1 = BattleMgr:FindRoleByCampAndPos(camp, pos - 1)
            if role1 then
                table.insert(neighbors, role1)
            end
            local role2 = BattleMgr:FindRoleByCampAndPos(camp, pos + 1)
            if role2 then
                table.insert(neighbors, role2)
            end
            local totalNum = 0
            for i, role in ipairs(neighbors) do
                local num = role.buffMgr:GetBuffNumByTypeId(num1)
                totalNum = totalNum + num
                if totalNum > num2 then
                    return true
                end
            end
            return false
        end,
        -- 根据层数按概率触发，触发时的概率=Num1+目标身上buffid=Num2层数×num1
        [tst.ProbEnhanceByTargetBuff] = function()
            local num1 = conditionData[1]
            local num2 = conditionData[2]

            local layerNum = target.buffMgr:GetBuffLayNumByBuffTypeID(num2)
            
            local rate = Core.Random()
            return rate <= (num1 + layerNum * num1)
        end,
        -- 牌库中存在携带者的Num1星技能牌
        [tst.HasCardByStar] = function()
            local num1 = conditionData[1]
            local cardMgr = owner:GetCardMgr()
            local cards = cardMgr:FindCardsByFunc(function (card, pos)
                return owner.id == card.roleId and card.star == num1 and not card.isUltra
            end)
            return #cards > 0
        end,
        --- 技能攻击者是buff拥有者的敌方
        [tst.SkillAttackerIsEnemy] = function (  )
            --@RefType[Game.Battle.Record.SkillRecord#SkillRecord]
            if not trigData.skillRec then
                printError('触发时需要的技能数据不存在:'..conditionID)
                return false
            end
            local skillRec = trigData.skillRec
            if skillRec.attacker then
                return Core:IsEnemy(owner.camp, skillRec.attacker.camp)
            end
            return false
        end,
    }
    local func = switch[conditionID]
    if not func then
        printError('找不到对应的子条件:'..conditionID)
        return false
    end
    -- assert(func, '找不到对应的子条件:'..conditionID)
    return func()
end


--获取触发器的数据
function Trigger.GetTriggerData( mainID )
    return Core:GetTriggerData(mainID)
    -- if not TriggerDatas then
    --     TriggerDatas = tableFile
    -- end

    -- return TriggerDatas:GetByPrimaryKey(mainID)
end


return  Trigger