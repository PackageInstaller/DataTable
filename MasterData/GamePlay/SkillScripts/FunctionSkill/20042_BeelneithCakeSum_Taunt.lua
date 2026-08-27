local bs_20042 = class("bs_20042", LuaSkillBase)
local base = LuaSkillBase
bs_20042.config = {taunt_buff = 273, deBuffId = 1163}

function bs_20042:ctor()
end

function bs_20042:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_20042_1", 99, self.OnSetHurt, nil, self.caster)
end

function bs_20042:OnSetHurt(context)
  if context.sender.uid == self.caster.uid then
    context.hurt = self.caster.hp
  elseif context.sender.uid == self.caster.recordTable.caster.uid then
    context.hurt = self.caster.hp
    LuaSkillCtrl:CallBuff(self, self.caster.recordTable.caster, self.config.deBuffId, 1, nil, true)
  else
    context.hurt = 0
  end
end

function bs_20042:PlaySkill(data)
  LuaSkillCtrl:CallBuff(self, self.caster.recordTable.caster, self.config.taunt_buff, 1, 75, true)
  LuaSkillCtrl:StartTimer(self, 75, function()
    LuaSkillCtrl:RemoveLife(self.caster.hp, self, self.caster, true, nil, false, true)
  end)
end

function bs_20042:OnCasterDie()
  local effect = self.caster.recordTable.cakeEffect
  if effect ~= nil then
    effect:Die()
    effect = nil
    self.caster.recordTable.cakeEffect = nil
  end
  local beelneith = self.caster.recordTable.caster
  if beelneith ~= nil and beelneith.hp > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster.recordTable.caster, 198, 1, nil, true)
  end
  base.OnCasterDie(self)
end

return bs_20042
