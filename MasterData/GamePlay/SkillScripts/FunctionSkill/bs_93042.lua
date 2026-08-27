local bs_93042 = class("bs_93042", LuaSkillBase)
local base = LuaSkillBase
bs_93042.config = {}

function bs_93042:ctor()
end

function bs_93042:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_93042_1", 1, self.OnAfterHurt, nil, self.caster, nil, self.caster.belongNum, nil, nil, nil, nil, false)
end

function bs_93042:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.caster == target and isMiss and not isTriggerSet then
    if sender.recordTable.bs_93042 == nil then
      sender.recordTable.bs_93042 = 0
    end
    sender.recordTable.bs_93042 = sender.recordTable.bs_93042 + 1
    if sender.recordTable.bs_93042 >= self.arglist[1] then
      sender.recordTable.bs_93042 = 0
      local buffs = LuaSkillCtrl:GetRoleBuffs(sender)
      if buffs == nil or 1 > buffs.Count then
        return
      end
      for i = 0, buffs.Count - 1 do
        if buffs[i].buffType == eBuffType.Debeneficial then
          local buffId = buffs[i].dataId
          local buffDuration = buffs[i].totalTime
          local buffSkill = buffs[i].battleSkill
          LuaSkillCtrl:CallBuffWithOriginSkill(buffSkill, sender, buffId, 1, buffDuration, true, self.caster)
        end
      end
    end
  end
end

function bs_93042:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93042
