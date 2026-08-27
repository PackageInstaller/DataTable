local bs_4000 = class("bs_4000", LuaSkillBase)
local base = LuaSkillBase
bs_4000.config = {
  buffId = 40001,
  effectId_AOE1 = 212301,
  effectId_hit = 212304,
  HurtConfigID = 2
}

function bs_4000:ctor()
end

function bs_4000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_4000:OnRoleSplash(role)
  if role.belongNum == self.caster.belongNum and role == self.caster then
    self:Dodamage()
  end
end

function bs_4000:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == self.caster.belongNum and role == self.caster then
    self:Dodamage()
  end
end

function bs_4000:Dodamage()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_AOE1, self, nil, nil, nil, true)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local target = targetList[i].targetRole
      if target ~= nil then
        local num = target:GetBuffTier(self.config.buffId)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.arglist[1] + num * self.arglist[2]
        }, true)
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self, nil, nil, nil, true)
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.arglist[3])
      end
    end
  end
end

function bs_4000:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_4000:LuaDispose()
  base.LuaDispose(self)
end

return bs_4000
