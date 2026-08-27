local bs_7013 = class("bs_7013", LuaSkillBase)
local base = LuaSkillBase
bs_7013.config = {}

function bs_7013:ctor()
end

function bs_7013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.damTimer = LuaSkillCtrl:StartTimer(nil, 15, self.CallBack, self, -1)
  self:AddBuffDieTrigger("bs_7013_1", 1, self.OnBuffDie, self.caster, nil, 105)
end

function bs_7013:OnBuffDie(buff, target, removeType)
  if buff.dataId == 195 and self.caster:GetBuffTier(195) <= 0 and self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

function bs_7013:CallBack()
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
  local num = self.caster:GetBuffTier(195)
  local attack_int = 0
  local pass_target1
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList ~= nil and 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
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
  local hurt = self.caster.maxHp * 2 // 1000
  local hurt1 = attack_int * 100 // 1000
  if hurt > hurt1 then
    hurt = hurt1
  end
  local realhurt = hurt * num
  LuaSkillCtrl:RemoveLife(realhurt, self, self.caster, true, nil, true, true, eHurtType.PhysicsDmg)
end

function bs_7013:OnCasterDie()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_7013
