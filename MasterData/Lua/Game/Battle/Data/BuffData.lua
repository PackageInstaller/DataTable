--[[
    author:luqucheng
    time:2020-09-28 17:03:20
]]
---@class Game.Battle.Data.BuffData
local BuffData = {}

BuffData.id = nil
BuffData.lv = nil
BuffData.star = nil
-- BuffData.mainEffectType = nil
-- BuffData.subEffectType = nil
-- BuffData.miniEffectType = nil
BuffData.buffType = nil--1增益，2减益
BuffData.buffClass = nil
BuffData.effectTarget = nil--触发指向的目标
BuffData.effectTrigger = nil--该BUFF触发其他BUFF（填写触发表内的ID）
BuffData.effectId = nil--附加的技能或者效果id
BuffData.endType = nil
BuffData.stackingType = nil--叠加方式（1覆盖叠加  2独立)
BuffData.sameBuffStackingType = nil
BuffData.isClear = nil--是否能被清除
BuffData.isStolen = nil--是否能被偷取
BuffData.isIgnore = nil--是否无视免疫
BuffData.buffConditionPara = nil
BuffData.buffEndPara = nil
BuffData.effectNum1 = nil
BuffData.round = nil
BuffData.isUnique = nil--是否唯一
BuffData.isUniqueAll = nil--是否本阵营唯一
BuffData.stackingMax = nil
BuffData.effects = nil --效果
BuffData.endNum = nil --触发结束触发器后的变化方式
BuffData.removeWhenOwnerDead = nil
BuffData.buffTags = nil --BUFF标签（1、装备效果；2、人物被动；3、共鸣被动）
BuffData.refresh = nil --是否随动（0不随动，1随动，2仅伤害时生效）
-- BuffData.addBuffScript = nil--添加buff时候的脚本
-- BuffData.multiType = nil--综合类型ID，由mainEffectType subEffectType miniEffectType buffType组合而出
BuffData.showIds = nil
BuffData.stackTime = nil
BuffData.triggerCdType = nil--触发间隔类型（间隔的数值X在技能升级表内配置）：1、X回合内能触发一次；2、单次技能卡期间（或单次受到技能卡期间）能触发X次
BuffData.triggerCdNum  = nil--触发间隔数值
BuffData.effectRate = nil--效果命中率
BuffData.triggerEffectTypes = nil--附加类型（1 BUFF 2 技能 3技能效果）

return  BuffData