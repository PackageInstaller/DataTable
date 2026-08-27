local bs_10131 = class("bs_10131", LuaSkillBase)
local base = LuaSkillBase
bs_10131.config = {buffId = 1009}

function bs_10131:ctor()
end

function bs_10131:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10131_1", 1, self.OnAfterHurt, self.caster)
end

function bs_10131:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet then
    local debuffNum = 0
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if 0 < buffs.Count then
      for i = 0, buffs.Count - 1 do
        if buffs[i].buffType == 2 then
          debuffNum = debuffNum + 1
        end
      end
      if 30 < debuffNum then
        debuffNum = 30
      end
      self:PlayChipEffect()
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1] * debuffNum, nil, true)
    else
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    end
  end
end

function bs_10131:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10131
