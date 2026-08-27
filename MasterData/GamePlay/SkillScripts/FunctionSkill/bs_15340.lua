local bs_15340 = class("bs_15340", LuaSkillBase)
local base = LuaSkillBase
bs_15340.config = {buffId_miniFire = 110150, time = 1}

function bs_15340:ctor()
end

function bs_15340:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15340_1", 1, self.OnAfterHurt, self.caster)
end

function bs_15340:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and self.caster ~= target and not isMiss and (skill.skillTag == eSkillTag.normalSkill or skill.skillTag == eSkillTag.ultSkill) and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    if self.caster.recordTable.miniFireBuff == nil then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_miniFire, self.config.time, 120)
    else
      LuaSkillCtrl:CallBuff(self, target, self.caster.recordTable.miniFireBuff, self.config.time, 120)
    end
  end
end

function bs_15340:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15340
