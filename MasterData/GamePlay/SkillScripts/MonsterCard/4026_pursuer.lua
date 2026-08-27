local bs_4026 = class("bs_4026", LuaSkillBase)
local base = LuaSkillBase
bs_4026.config = {effectId = 207400, HurtConfigID = 2}

function bs_4026:ctor()
end

function bs_4026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4025_2", 1, self.OnAfterPlaySkill)
end

function bs_4026:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, nil, true)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local target = targetList[i].targetRole
        if target ~= nil then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[2]
          }, true)
          skillResult:EndResult()
        end
      end
    end
  end
end

function bs_4026:LuaDispose()
  base.LuaDispose(self)
end

function bs_4026:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4026
