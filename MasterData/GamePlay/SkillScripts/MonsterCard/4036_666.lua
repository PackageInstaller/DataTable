local bs_4036 = class("bs_4036", LuaSkillBase)
local base = LuaSkillBase
bs_4036.config = {
  effectId_hit = 208014,
  effectId_role = 208013,
  hurtResultId = 25,
  selectId = 10001
}

function bs_4036:ctor()
end

function bs_4036:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4036_2", 1, self.OnAfterPlaySkill)
end

function bs_4036:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isUltSkill then
    if self.effectAtk ~= nil then
      self.effectAtk:Die()
      self.effectAtk = nil
    end
    if self.Atk ~= nil then
      self.Atk:Stop()
      self.Atk = nil
    end
    if self.Atk_end ~= nil then
      self.Atk_end:Stop()
      self.Atk_end = nil
    end
    self.effectAtk = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_role, self)
    local num = self.arglist[1] // 5 - 1
    self.Atk = LuaSkillCtrl:StartTimer(nil, 5, function()
      local range = 2 - self.caster.attackRange
      local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, range)
      if targetList.Count > 0 then
        for i = 0, targetList.Count - 1 do
          local role = targetList[i].targetRole
          if role.belongNum ~= self.caster.belongNum and LuaSkillCtrl:IsAbleAttackTarget(self.caster, role, 2) then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
            LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtResultId, {
              self.arglist[2]
            })
            skillResult:EndResult()
            LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self)
          end
        end
      end
    end, self, num, 4)
    self.Atk_end = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
      if self.effectAtk ~= nil then
        self.effectAtk:Die()
        self.effectAtk = nil
      end
      if self.Atk ~= nil then
        self.Atk:Stop()
        self.Atk = nil
      end
    end, self)
  end
end

function bs_4036:LuaDispose()
  base.LuaDispose(self)
  if self.effectAtk ~= nil then
    self.effectAtk:Die()
    self.effectAtk = nil
  end
  if self.Atk ~= nil then
    self.Atk:Stop()
    self.Atk = nil
  end
  if self.Atk_end ~= nil then
    self.Atk_end:Stop()
    self.Atk_end = nil
  end
end

function bs_4036:OnCasterDie()
  base.OnCasterDie(self)
  if self.effectAtk ~= nil then
    self.effectAtk:Die()
    self.effectAtk = nil
  end
  if self.Atk ~= nil then
    self.Atk:Stop()
    self.Atk = nil
  end
  if self.Atk_end ~= nil then
    self.Atk_end:Stop()
    self.Atk_end = nil
  end
end

return bs_4036
