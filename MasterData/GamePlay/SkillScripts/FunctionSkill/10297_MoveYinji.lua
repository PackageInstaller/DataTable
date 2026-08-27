local bs_10297 = class("bs_10297", LuaSkillBase)
local base = LuaSkillBase
bs_10297.config = {buffId_shixue = 257}

function bs_10297:ctor()
end

function bs_10297:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10297_1", 1, self.OnBeforePlaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_10297_2", 2, self.OnSelfAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self.moveText = 0
end

function bs_10297:OnBeforePlaySkill(role, context)
  if role == self.caster and role ~= nil and role.hp > 0 and self.moveText == 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_shixue, self.arglist[1], nil, true)
    self.moveText = 0
  end
end

function bs_10297:OnSelfAfterMove()
  if self.caster ~= nil and self.caster.hp > 0 then
    self.moveText = 1
  end
end

function bs_10297:OnRoleSplash(role, grid)
  if role == self.caster and self.caster ~= nil and self.caster.hp > 0 then
    self.moveText = 1
  end
end

function bs_10297:OnRolePhaseMoveStart(role, luaskill)
  if role == self.caster and self.caster ~= nil and self.caster.hp > 0 then
    self.moveText = 1
  end
end

function bs_10297:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10297
