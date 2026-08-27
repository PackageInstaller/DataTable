local bs_4028 = class("bs_4028", LuaSkillBase)
local base = LuaSkillBase
bs_4028.config = {HurtConfig = 2}

function bs_4028:ctor()
end

function bs_4028:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4018_2", 1, self.OnAfterPlaySkill)
end

function bs_4028:OnAfterPlaySkill(skill, role)
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  if role == self.caster and skill.isNormalSkill then
    local hpLose = self.caster._curHp * self.arglist[1] // 1000
    if hpLose == 1 then
      hpLose = 0
    end
    LuaSkillCtrl:RemoveLife(hpLose, self, self.caster, true, nil, false, false, eHurtType.RealDmg, true)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
      self.arglist[2]
    }, true)
    skillResult:EndResult()
  end
end

function bs_4028:LuaDispose()
  base.LuaDispose(self)
end

function bs_4028:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4028
