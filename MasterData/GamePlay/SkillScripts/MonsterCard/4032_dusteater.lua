local bs_4032 = class("bs_4032", LuaSkillBase)
local base = LuaSkillBase
bs_4032.config = {
  buffId = 3019,
  effectId_AOE1 = 212301,
  effectId_hit = 212304,
  HurtConfigID = 2
}

function bs_4032:ctor()
end

function bs_4032:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_4032:OnRoleSplash(role)
  if role.belongNum == self.caster.belongNum and role == self.caster then
    self:Dodamage()
  end
end

function bs_4032:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == self.caster.belongNum and role == self.caster then
    self:Dodamage()
  end
end

function bs_4032:Dodamage()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_AOE1, self, nil, nil, nil, true)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local target = targetList[i].targetRole
      if target ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.arglist[1]
        }, true)
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.arglist[2])
      end
    end
  end
end

function bs_4032:LuaDispose()
  base.LuaDispose(self)
end

function bs_4032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4032
