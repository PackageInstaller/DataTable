--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2020-01-10 15:05:15
]]
local SkillData = {}
SkillData.skillId = nil
SkillData.lv = nil
SkillData.star = nil
SkillData.comboType = nil--连携位置（目前是4个位置，分别是A B C D，对应填写1 2 3 4与系统描述一致，当该招数为大招时，则填写为0）
SkillData.skillClass = nil--技能分类(1主动 2被动）
SkillData.skillType = nil--技能类型（1普攻2高级技能3大招4强化技）
SkillData.skillStarMax = nil
SkillData.skillCondition = nil
SkillData.castConditionPara = nil
SkillData.clickType = nil--技能点选规则（1己方 2敌方 3全体）
SkillData.triggerRule = nil
SkillData.damageTarget = nil--伤害效果目标
SkillData.damageEffect = nil--伤害效果ID
SkillData.isCounterAttack = nil--是否触发反击（1触发,0不触发）
SkillData.isContinuousAttack = nil--是否连击（1触发,0不触发）
SkillData.effectCondition1 = nil
SkillData.effectTarget1 = nil
SkillData.effect1 = nil
SkillData.effectCondition2 = nil
SkillData.effectTarget2 = nil
SkillData.effect2 = nil
SkillData.effectCondition3 = nil
SkillData.effectTarget3 = nil
SkillData.effect3 = nil
SkillData.label = nil--标签（1、buff 2、进攻3、debuff 4、恢复）
SkillData.starEffect1 = nil--附加效果对于星级的要求
SkillData.starEffect2 = nil
SkillData.starEffect3 = nil
SkillData.extraCondition = nil--额外条件类型（此字段直接填写枚举的ID）
SkillData.castCondition = nil--消耗条件（此字段直接填写枚举的ID）
SkillData.cd = nil
SkillData.mp = nil
SkillData.disAtkNum = nil--解体槽伤害值
SkillData.powerNum = nil--战斗强化点消耗
SkillData.effectConditionPara1 = nil
SkillData.effectConditionPara2 = nil
SkillData.effectConditionPara3 = nil
SkillData.extraConditionPara = nil
SkillData.castConditionPara = nil
SkillData.stackTime1 = nil
SkillData.stackTime2 = nil
SkillData.stackTime3 = nil
SkillData.comboTargetSelectScript = nil --多段目标选择脚本
SkillData.comboTargetSelectParams = nil --多段目标选择参数

return SkillData