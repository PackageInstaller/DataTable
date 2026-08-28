--
-- Author:luqucheng
-- Date: 2019-11-27 11:07:58
--
local EffectParam = {}
--@RefType [Game.Battle.Entity.Role#Role]
EffectParam.attacker = nil
--@RefType [Game.Battle.Entity.Role#Role]
EffectParam.mainTarget = nil
EffectParam.star = nil
EffectParam.lv = nil
--@RefType [Game.Battle.Entity.Role#Role<>]
EffectParam.targets = nil
EffectParam.skillEffectID = nil
EffectParam.layNum = nil
EffectParam.combo = nil
--@RefType [Game.Battle.Record.SkillEffectRecord#SkillEffectRecord<>]
EffectParam.otherEffectRecs = nil
--@RefType [Game.Battle.Record.SkillEffectRecord#SkillEffectRecord]
EffectParam.effectRec = nil
--@RefType [Game.Battle.Record.DamageRecord#DamageRecord<>]
EffectParam.damageRecs = nil

EffectParam.effectType = nil --发动类型 1 BUFF 2 技能效果 3技能
return  EffectParam