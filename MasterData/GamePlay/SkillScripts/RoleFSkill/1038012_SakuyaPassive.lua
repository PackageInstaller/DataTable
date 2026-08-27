local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1038012 = class("bs_1038012", base)
bs_1038012.config = {buffId_195 = 19501, effectId_pass_ex = 10800}

function bs_1038012:ctor()
end

function bs_1038012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1038012_3", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
  self.ex_target = nil
  self.ex_effect = nil
end

function bs_1038012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isMiss and target.hp > 0 and self.ex_target ~= target then
    if self.ex_effect ~= nil then
      self.ex_effect:Die()
      self.ex_effect = nil
    end
    self.ex_target = target
    self.ex_effect = LuaSkillCtrl:CallEffect(target, self.config.effectId_pass_ex, self)
  end
  if target == self.ex_target and target.hp <= 0 and self.ex_effect ~= nil then
    self.ex_effect:Die()
    self.ex_effect = nil
  end
  if target == self.ex_target and isTriggerSet == false then
    if sender ~= self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_195, 1, self.arglist[2])
    end
    if sender == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] * 2 then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_195, 1, self.arglist[2])
    end
  end
end

function bs_1038012:OnCasterDie()
  if self.ex_effect ~= nil then
    self.ex_effect:Die()
    self.ex_effect = nil
  end
  base.OnCasterDie(self)
end

function bs_1038012:LuaDispose()
  base.LuaDispose(self)
  self.ex_target = nil
  self.ex_effect = nil
end

return bs_1038012
