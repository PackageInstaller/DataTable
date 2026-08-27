local bs_7012 = class("bs_7012", LuaSkillBase)
local base = LuaSkillBase
bs_7012.config = {}

function bs_7012:ctor()
end

function bs_7012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.damTimer = LuaSkillCtrl:StartTimer(nil, 15, self.CallBack, self, -1)
  self:AddBuffDieTrigger("bs_7012_1", 1, self.OnBuffDie, self.caster)
end

function bs_7012:OnBuffDie(buff, target, removeType)
  if buff.dataId == 183 and self.caster:GetBuffTier(183) <= 0 and self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

function bs_7012:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  if self.caster == nil then
    if self.damTimer ~= nil then
      self.damTimer:Stop()
      self.damTimer = nil
    end
    return
  end
  local num = self.caster:GetBuffTier(183)
  local attack_int = 0
  local pass_target1
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetList ~= nil and 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      if role.belongNum ~= self.caster.belongNum and role.belongNum ~= eBattleRoleBelong.neutral and (attack_int < role.pow or attack_int < role.skill_intensity) then
        pass_target1 = role
        if role.pow >= role.skill_intensity then
          attack_int = role.pow
        else
          attack_int = role.skill_intensity
        end
      end
    end
  end
  local hurt = self.caster.maxHp * 4 // 1000
  local hurt1 = attack_int * 100 // 1000
  if hurt > hurt1 then
    hurt = hurt1
  end
  local realhurt = hurt * num
  LuaSkillCtrl:RemoveLife(realhurt, self, self.caster, true, nil, true, true, eHurtType.PhysicsDmg)
end

function bs_7012:OnCasterDie()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_7012
