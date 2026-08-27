local bs_30037 = class("bs_30037", LuaSkillBase)
local base = LuaSkillBase
bs_30037.config = {buffId = 1200}

function bs_30037:ctor()
end

function bs_30037:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_30037_1", 1, self.OnAfterHurt, self.caster)
end

function bs_30037:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet then
    local debuffNum = 0
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if buffs ~= nil and 0 < buffs.Count then
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
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, debuffNum, nil, true)
    else
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    end
  end
end

function bs_30037:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30037
