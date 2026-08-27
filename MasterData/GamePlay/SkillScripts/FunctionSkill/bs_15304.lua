local bs_15304 = class("bs_15304", LuaSkillBase)
local base = LuaSkillBase
bs_15304.config = {
  buffId = 288,
  buffIdAtk = 110123,
  buffIdSkillIntensity = 110124
}

function bs_15304:ctor()
end

function bs_15304:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_15304_2", 1, self.OnSetHurt, nil, self.caster)
  self.damage = 0
  self.time = 0
  self.limit_hp = self.caster.maxHp * self.arglist[1] // 1000
  self.flag = true
end

function bs_15304:OnSetHurt(context)
  if self.flag == false then
    context.hurt = 0
  end
  if self.time >= self.arglist[4] or 0 < self.caster:GetBuffTier(self.config.buffId) or self.flag == false then
    return
  end
  local recordDamage = 0
  if context.hurt > self.caster.hp then
    recordDamage = self.caster.hp
  else
    recordDamage = context.hurt
  end
  self.damage = self.damage + recordDamage
  local overhurt = self.damage - self.limit_hp
  if overhurt < 0 then
    return
  end
  self.flag = false
  self.damage = 0
  self.time = self.time + 1
  context.hurt = context.hurt - overhurt
  LuaSkillCtrl:StartTimer(nil, 1, function()
    self.flag = true
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2], true)
  end)
  local atkAdd = self.caster.pow * self.arglist[3] // 1000
  local intensityAdd = self.caster.skill_intensity * self.arglist[3] // 1000
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffIdAtk, atkAdd, nil, true)
      LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffIdSkillIntensity, intensityAdd, nil, true)
    end
  end
end

function bs_15304:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15304
