local bs_105702 = class("bs_105702", LuaSkillBase)
local base = LuaSkillBase
bs_105702.config = {
  buffId = 105702,
  effectid = 105705,
  effectid_1 = 105704,
  actionId = 1002,
  action_speed = 1,
  actionId_start_time = 25,
  skilltime = 46
}

function bs_105702:ctor()
end

function bs_105702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105702:PlaySkill(data)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectid, self, nil)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.skilltime
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
end

function bs_105702:OnAttackTrigger(data)
  local target_pow, target_skill_intensity, target
  local targets_pow = LuaSkillCtrl:CallTargetSelect(self, 59, 10)
  if targets_pow.Count > 0 then
    for i = 0, targets_pow.Count - 1 do
      if targets_pow[i].targetRole:GetBuffTier(self.config.buffId) == 0 and targets_pow[i].targetRole ~= self.caster then
        local skills = targets_pow[i].targetRole:GetBattleSkillList()
        if skills.Count > 0 then
          for j = 0, skills.Count - 1 do
            if skills[j].isNormalSkill then
              target_pow = targets_pow[i].targetRole
              break
            end
          end
        end
        if target_pow ~= nil then
          break
        end
      end
    end
    if target_pow == nil then
      target_pow = targets_pow[0].targetRole
    end
  end
  local targets_skill_intensity = LuaSkillCtrl:CallTargetSelect(self, 64, 10)
  if targets_skill_intensity.Count > 0 then
    for i = 0, targets_skill_intensity.Count - 1 do
      if targets_skill_intensity[i].targetRole:GetBuffTier(self.config.buffId) == 0 and targets_skill_intensity[i].targetRole ~= self.caster then
        local skills = targets_skill_intensity[i].targetRole:GetBattleSkillList()
        if skills.Count > 0 then
          for j = 0, skills.Count - 1 do
            if skills[j].isNormalSkill then
              target_skill_intensity = targets_skill_intensity[i].targetRole
              break
            end
          end
        end
        if target_skill_intensity ~= nil then
          break
        end
      end
    end
    if target_skill_intensity == nil then
      target_skill_intensity = targets_skill_intensity[0].targetRole
    end
  end
  if target_pow.pow >= target_skill_intensity.skill_intensity then
    target = target_pow
  else
    target = target_skill_intensity
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectid_1, self, nil)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil)
  end, nil)
end

function bs_105702:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105702
