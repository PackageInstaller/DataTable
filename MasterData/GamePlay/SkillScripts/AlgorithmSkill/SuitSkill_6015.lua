local bs_6015 = class("bs_6015", LuaSkillBase)
local base = LuaSkillBase
bs_6015.config = {buff_reduce = 601501}
local CalcArg = {
  500,
  400,
  300,
  200,
  100
}

function bs_6015:ctor()
end

function bs_6015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_6015_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddSetHurtTrigger("bs_6015_3", 1, self.OnSetHurt, nil, self.caster)
  self.maxnum = self.caster.maxHp
  self.numji = 0
end

function bs_6015:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  for i = 1, 5 do
    if self.caster.hp < self.caster.maxHp * CalcArg[i] // 1000 and i >= self.caster:GetBuffTier(self.config.buff_reduce) then
      if i == 1 then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_reduce, 2)
      else
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_reduce, 1)
      end
    end
  end
end

function bs_6015:OnSetHurt(context)
  for i = 1, 5 do
    if self.caster.hp >= self.caster.maxHp * CalcArg[i] // 1000 and i < self.caster:GetBuffTier(self.config.buff_reduce) then
      if i == 5 then
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_reduce, 2, true)
      else
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_reduce, 1, true)
      end
    end
  end
end

function bs_6015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6015
