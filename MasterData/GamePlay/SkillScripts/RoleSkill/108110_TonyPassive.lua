local bs_108110 = class("bs_108110", LuaSkillBase)
local base = LuaSkillBase
bs_108110.config = {buffId = 108105}

function bs_108110:ctor()
end

function bs_108110:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_108110:OnRoleSplash(role)
  if role == self.caster then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[2], true)
  end
end

function bs_108110:OnRolePhaseMoveStart(role, luaskill)
  if role == self.caster then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[2], true)
  end
end

function bs_108110:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108110
