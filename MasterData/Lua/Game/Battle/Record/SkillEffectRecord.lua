--
-- Author:luqucheng
-- Date: 2019-10-24 14:38:08
--
local SkillEffectRecord = {}
SkillEffectRecord = Class("SkillEffectRecord")

function SkillEffectRecord:__init(effectData, attacker, targets)
    --@RefType [Game.Battle.Data.EffectData#EffectData]
    self.effectData = effectData
    --@RefType [Game.Battle.Entity.Role#Role<>]
    self.targets = targets
    --@RefType [Game.Battle.Entity.Role#Role]
    self.attacker = attacker

    --本次效果清除debuff的层数
    self.debuffClearLayNum = 0
    
    --本次效果清除buff的层数
    self.buffClearLayNum = 0
end


function SkillEffectRecord:ToData()
    local targetIds = {}
    local damages = {}
    for i,v in ipairs(self.targets) do
        table.insert( targetIds,v.id )
    end
    -- for i,v in ipairs(self.damageRecords) do
    --     table.insert( damages, v:ToData() )
    -- end
    return 
    {
        r = Constants.RecordType.Effect,
        e = self.effectData.id,--效果类型
        a = self.attacker.id,--攻击者id
        si = self.effectData.showId,--表现id
        ts = targetIds,
        -- damages = damages,
    }
end

return  SkillEffectRecord