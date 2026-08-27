local bs_80002 = class("bs_80002", LuaSkillBase)
local base = LuaSkillBase
bs_80002.config = {}

function bs_80002:ctor()
end

function bs_80002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_80002:PlaySkill(data)
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
  LuaSkillCtrl:CallRoleAction(self.caster, 1001, atkSpeedRatio)
end

return bs_80002
