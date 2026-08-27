local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1022012 = class("bs_1022012", base)
bs_1022012.config = {buffId_critical = 22401, buffId_storage = 22501}

function bs_1022012:ctor()
end

function bs_1022012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1022012_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_1022012_3", 1, self.OnAfterHurt, self.caster)
end

function bs_1022012:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_critical, 1)
end

function bs_1022012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack then
    if not isCrit then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_storage, 1, nil, true)
    end
    if isCrit and self.caster:GetBuffTier(self.config.buffId_storage) > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_storage, 0, true)
    end
  end
end

function bs_1022012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1022012
