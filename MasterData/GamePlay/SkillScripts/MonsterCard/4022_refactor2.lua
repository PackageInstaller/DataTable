local bs_4022 = class("bs_4022", LuaSkillBase)
local base = LuaSkillBase
bs_4022.config = {buffId = 40221, heal_resultId = 6}

function bs_4022:ctor()
end

function bs_4022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_4022:OnRoleSplash(role)
  if role.belongNum == self.caster.belongNum and role == self.caster then
    self:Dobuff()
  end
end

function bs_4022:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == self.caster.belongNum and role == self.caster then
    self:Dobuff()
  end
end

function bs_4022:Dobuff()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
  local heal = self.caster.pow * self.arglist[3] // 1000 + self.caster.skill_intensity * self.arglist[3] // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {heal}, true)
  skillResult:EndResult()
end

function bs_4022:LuaDispose()
  base.LuaDispose(self)
end

function bs_4022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4022
