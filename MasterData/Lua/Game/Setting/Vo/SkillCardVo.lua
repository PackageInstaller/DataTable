local SettingRefBase = require('Game.Setting.SettingRefBase')

---@class SkillCardVo
local SkillCardVo = {}
SkillCardVo = Class("SkillCardVo", SettingRefBase)

local ParseUtils = CS.ParseUtils
local base = SettingRefBase

function SkillCardVo:Init()
    self.id = nil
    self.icon = nil --技能图标
    self.orginSkills = nil --默认技能
    self.overSkills = nil --覆盖技能
    self.overCondition = nil --覆盖条件
    self.overConditionParam = nil --覆盖条件参数
    self.cardBehavior = nil --出牌行为
    self.cardBehaviorParam = nil --出牌行为参数
    self.targetAI = nil --目标点选倾向（AI用）
    self.isAoe = nil --技能的目标类型（1、单体；2、群体）
    self.deckTargetAI = nil --牌库点选的参数（AI用）
    self.skillType = nil --技能类型（1普攻2高级技能3大招4通用的第三方技能，比如合卡技）
    self.label = nil --技能标签（1、buff；2、进攻；3、DEBUFF；4、恢复；5、进攻且buff；6、进攻且debuff；7、召唤兽）
    self.autoLabel = nil    -- ai选择目标时，使用的策略
    self.skillLvMax = nil --技能卡的最大等级(后端读取，大招升级用)
    self.clickType = nil --技能点选规则（1、友方；2、敌方；3、全体；4、自身）
    self.isEveryone = nil --是否无需点选（0、需点选；1、不需点选）
    self.ignoreTaunt = nil --无视嘲讽
    self.usefulnessAI = nil --ai效能公式
    self.usefulnessNumAI = nil --效能公式参数

    self.cdAI = nil --单轮次ai可以自动释放次数

    self.skillName = nil -- 技能名称
    self.skillDesc_1 = nil -- 技能描述1
    self.skillDesc_2 = nil -- 技能描述2
    self.skillDesc_3 = nil -- 技能描述3
    self.skillDesc_4 = nil -- 技能描述4
    self.skillDesc_5 = nil -- 技能描述5
    self.skillDesc_6 = nil -- 技能描述6
    
    self.specialDesc_1 = nil --SP技能战中描述1星
    self.specialDesc_2 = nil --SP技能战中描述2星
    self.specialDesc_3 = nil --SP技能战中描述3星
    self.specialDesc_4 = nil --SP技能战中描述4星
    self.specialDesc_5 = nil --SP技能战中描述5星
    self.specialDesc_6 = nil --SP技能战中描述6星
    
    self.abstractLabel = nil -- 技能概述标签
    self.showLabel = nil
    self.isPowerful = nil
end

function SkillCardVo:__init()
    self:Init()
end

---FillVo
---@param row TableML.TableFileRow
function SkillCardVo:FillVo(row)
    base.FillVo(self, row)
    local _parseLocalizeText = ParseLocalizeText
    local format = string.format

    self.id = parse_number(row, "id", 0)
    self.icon = parse_number(row, "icon", 0)
    self.skillLvMax = parse_number(row, "skillLvMax", 1)
    self.orginSkills = {}
    self.overSkills = {}
    for i=1,self.skillLvMax do
        local originId = parse_number(row, "skillId"..i, 0)
        if not Tools.isNullKey(originId) then
            table.insert(self.orginSkills, originId)
        end

        local overIds = Tools.splitToNum(parse_string(row, "overSkill"..i, 0), ';')
        if not Tools.isNullKey(overIds) then
            table.insert(self.overSkills, overIds)
        end

        --- skillDesc_1  = skillDesc1
        local skillDesc_i = _parseLocalizeText(row, format("specialDesc%s", i), '')
        
        local strArray = string.split(skillDesc_i, '&')     -- 技能描述 & 特殊伤害类型描述
        --- specialDesc_1  = specialDesc1
        self[format("specialDesc_%s", i)] = strArray[1]
        if table.count(strArray) == 2 then
            self[format("damageTypeDesc_%s", i)] = strArray[2]
        end
        
        self[format("skillDesc_%s", i)] = _parseLocalizeText(row, format("skillDesc%s", i), '')
    end

    self.overCondition = Tools.splitToNum(parse_string(row, "overCondition", 0), ';')
    self.overConditionParam = Tools.splitToNum(parse_string(row, "overConditionPara", 0), '=', ';', ',')

    self.cardBehavior = parse_number(row, "cardBehavior", 0)
    self.cardBehaviorParam = Tools.splitToNum(parse_string(row, "cardBehaviorPara", 0), ';')
    --出牌行为触发器
    self.cardTrigger = parse_number(row, "cardTrigger", 0)
    self.triggerEffect = parse_number(row, "triggerEffect", 0)
    self.triggerPara = Tools.splitToNum(parse_string(row, "triggerPara", 0), ';')

    -- self.targetAI = parse_number(row, "targetAI", 0)
    self.isAoe = parse_number(row, "isAoe", 1)
    self.deckTargetAI = parse_number(row, "deckTargetAI", 0)
    self.skillType = parse_number(row, "skillType", 1)
    self.label = parse_number(row, "label", 0)
    self.autoLabel = parse_number(row, "autoLabel", 0)
    
    self.clickType = parse_number(row, "clickType", 2)
    self.isEveryone = parse_number(row, "isEveryone", 0) == 1
    self.ignoreTaunt = parse_number(row, "ignoreTaunt", 0) == 1

    self.cdAI = parse_number(row, "cdAI", 1)
    self.usefulnessAI = parse_number(row, "usefulnessAI", 1)
    self.usefulnessNumAI = Tools.splitToNum(parse_string(row, "usefulnessNumAI", 0), ';')
    
    self.skillName = _parseLocalizeText(row, "skillName")
    -- self.skillDesc_1 = _parseLocalizeText(row, "skillDesc1", '')
    -- self.skillDesc_2 = _parseLocalizeText(row, "skillDesc2", '')
    -- self.skillDesc_3 = _parseLocalizeText(row, "skillDesc3", '')
    -- self.skillDesc_4 = _parseLocalizeText(row, "skillDesc4", '')
    -- self.specialDesc_1 = _parseLocalizeText(row, "specialDesc1", '')
    -- self.specialDesc_2 = _parseLocalizeText(row, "specialDesc2", '')
    -- self.specialDesc_3 = _parseLocalizeText(row, "specialDesc3", '')
    -- self.specialDesc_4 =_parseLocalizeText(row, "specialDesc4", '')
    self.descOther = _parseLocalizeText(row, "descOther", '')

    self.skillIconPath = {}
    local skillPathInConfig = string.format("%s.png", ParseUtils.ParsePathName(row, "icon", "")) 
    table.insert(self.skillIconPath, skillPathInConfig)

    -- self.abstractLabel = Tools.splitToNum(parse_string(row, "abstractLabel", ""), ';')
    self.abstractLabel = parse_strings(parse_string(row, "abstractLabel", ""), ";")
    self.showLabel = parse_strings(parse_string(row, "showLabel", ""), ";")
    self.isPowerful = parse_number(row, "isPowerful", 0)

    -- 被吞噬时，延迟到吞噬牌技能释放结束时触发的效果
    self.delayTriggerTarget = parse_number(row, "delayTriggerTarget", 0)
    self.delayTriggerType = parse_number(row, "delayTriggerType", 0)
    self.delayTriggerEffectId = parse_number(row, "delayTriggereffectId", 0)
end

function SkillCardVo:IsUltra(  )
    return self.skillType == Constants.SkillType.Final
end

--是否可以释放，需要砍断是否在cd以及是否满足释放条件
function SkillCardVo:CanDischarge(owner)
    -- local isCD = self:IsInCD()
    -- --消耗
    -- local switch = {
    --     [Constants.SkillCostType.Mp] = function ( params )
    --         return self.owner:GetNowMp() >= params[1]
    --     end,
    --     [Constants.SkillCostType.BuffLay] = function ( params )
            
    --     end
    -- }
    --使用额外条件
    -- return not isCD
    --消耗是否足够
    local SkillLabel = Constants.SkillLabel
    local ability = owner.buffMgr.statusAbility
    if self:IsUltra() then
        --是大招的情况下，需要消耗能量点
        if (owner.ultraPoint < owner.maxUltraPoint) and owner.spPointType == 1 then
            return false
        end

        --是否禁止释放大招
        if not ability.canUseSPSkill then
            return false
        end
    end
    --小招是否会被禁止
    if self.label == SkillLabel.Buff and not ability.canUseBuffSkill then
        return false
    end
    if self.label == SkillLabel.Attack and not ability.canUseAttackSkill then
        return false
    end
    if self.label == SkillLabel.Debuff and not ability.canUseDebuffSkill then
        return false
    end
    if self.label == SkillLabel.Heal and not ability.canUseHealSkill then
        return false
    end
    return true
end


function SkillCardVo:__delete()
    self.id = nil
    self.icon = nil --技能图标
    self.orginSkills = nil --默认技能
    self.overSkills = nil --覆盖技能
    self.overCondition = nil --覆盖条件
    self.overConditionParam = nil --覆盖条件参数
    self.cardBehavior = nil --出牌行为
    self.cardBehaviorParam = nil --出牌行为参数
    self.targetAI = nil --目标点选倾向（AI用）
    self.isAoe = nil --技能的目标类型（1、单体；2、群体）
    self.deckTargetAI = nil --牌库点选的参数（AI用）
    self.skillType = nil --技能类型（1普攻2高级技能3大招4通用的第三方技能，比如合卡技）
    self.label = nil --技能标签（1、buff；2、进攻；3、DEBUFF；4、恢复；5、进攻且buff；6、进攻且debuff；7、召唤兽）
    self.skillLvMax = nil --技能卡的最大等级(后端读取，大招升级用)
    self.clickType = nil --技能点选规则（1、友方；2、敌方；3、全体；4、自身）
    self.isEveryone = nil --是否无需点选（0、需点选；1、不需点选）
    self.isPowerful = nil
end

return SkillCardVo