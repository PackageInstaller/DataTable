local bs_209401 = class("bs_209401", LuaSkillBase)
local base = LuaSkillBase
bs_209401.config = {buffId_Boss = 3017}

function bs_209401:ctor()
end

function bs_209401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_209401_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_209401_2", 1, self.OnAfterHurt, nil, self.caster)
  self.hpRate = nil
  self.maxHP = self.caster.maxHp
end

function bs_209401:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and 0 < hurt then
    self.hpRate = self.caster._curHp * 1000 // self.maxHP
    if self.hpRate <= 500 then
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnOdetteHalfHp, target, self.caster, self.cskill)
    end
  end
end

function bs_209401:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
end

function bs_209401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_209401
