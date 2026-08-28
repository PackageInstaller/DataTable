--
-- Author:luqucheng
-- Date: 2019-10-24 14:36:48
--
local SkillRecord = {}
SkillRecord = Class("SkillRecord")
--@RefType [Game.Battle.Record.DamageRecord#DamageRecord<>]
SkillRecord.damageRecs = nil
--@RefType [Game.Battle.Record.SkillEffectRecord#SkillEffectRecord<>]
SkillRecord.otherEffectRecs = nil
SkillRecord.skillCardParams = nil

function SkillRecord:__init(attacker, mainTarget, skill, isInputSkill)
    -- print(table.toString(attacker, "attacker"))
    self.attacker = attacker
    self.mainTarget = mainTarget
    --@RefType [Game.Battle.Core.Skill#Skill]
    self.skill = skill
    -- --@RefType [Game.Battle.Record.SkillEffectRecord#SkillEffectRecord]
    -- self.mainEffect = nil
    self.otherEffectRecs = {}

    self.mainTargets = {}

    self.hitTargets = {}

    self.damageRecs = {}

    self.noActionSkill = skill.skillType == 4 or skill.skillClass == Constants.SkillClass.Passive--不需要动作的技能

    self.isInputSkill = isInputSkill

end

function SkillRecord:AddDamageRec(rec, isMain)
    table.insert(self.damageRecs, rec)
end

function SkillRecord:AddDamageRecs(recs)
    if recs then
        table.link(self.damageRecs, recs)
    end
end

function SkillRecord:AddEffectRec(rec)
    table.insert(self.otherEffectRecs, rec)
end

function SkillRecord:AddEffectRecs(recs)
    if recs then
        table.link(self.otherEffectRecs, recs)
    end
end

function SkillRecord:SetSkillCardParams(params)
    self.skillCardParams = params
end

function SkillRecord:ToData()
    self.attackerID = self.attacker and self.attacker.id or nil
    self.ownerID = self.mainTarget and self.mainTarget.id or nil
    self.skillID = self.skill and self.skill.skillId or nil
    local targetIds = {}
    for i,v in ipairs(self.mainTargets) do
        table.insert( targetIds,v.id )
    end
    local hitsTargetIds = {}
    for i,ts in ipairs(self.hitTargets) do
        local oneHitTargets = {}
        for j,v in ipairs(ts) do
            table.insert( oneHitTargets,v.id )
        end
        table.insert(hitsTargetIds, oneHitTargets)
    end
    return {
        r = Constants.RecordType.Skill,--战报类型
        a = self.attacker.id,--攻击者id
        t = self.mainTarget.id,--受击者id
        s = self.skill.skillId,--技能id
        ss = self.skill.star,
        sl = self.skill.lv,
        na = self.noActionSkill,
        mts = targetIds,
        -- oe = table.link({}, self.otherEffectRecs),
        idx = self.skill.action,
        hts = hitsTargetIds,
        ip = self.isInputSkill
        -- skillCD = self.skill.nowCD,--技能剩余cd
    }
end


return SkillRecord