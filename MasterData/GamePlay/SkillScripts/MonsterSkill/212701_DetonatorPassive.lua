local bs_212701 = class("bs_212701", LuaSkillBase)
local base = LuaSkillBase
bs_212701.config = {
  buffId = 107101,
  HurtConfigID = 3,
  effectId = 212701,
  buffId1 = 179,
  buffId2 = 1033,
  buffId3 = 198,
  buffId4 = 88
}

function bs_212701:ctor()
end

function bs_212701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_212701", 1, self.OnAfterBattleStart)
end

function bs_212701:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId4, 1, nil, true)
  self.LoopDamage = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.OnLoopDamage), nil, -1, 0)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
end

function bs_212701:OnLoopDamage()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  LuaSkillCtrl:StartTimer(nil, 6, function()
    local skill_intensity = 0
    local targetlist1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if 0 < targetlist1.Count then
      for i = 0, targetlist1.Count - 1 do
        if skill_intensity <= targetlist1[i].skill_intensity then
          skill_intensity = targetlist1[i].skill_intensity
        end
      end
    end
    if LuaSkillCtrl.IsInBrotatoBattle then
      local targetList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 5, false)
      if 0 < targetList.Count then
        for i = targetList.Count - 1, 0, -1 do
          local target = targetList[i]
          if target.belongNum == 2 then
            local num = target:GetBuffTier(self.config.buffId)
            local damage = (self.arglist[2] + num * self.arglist[3]) * skill_intensity // 1000
            LuaSkillCtrl:RemoveLife(damage, self, target, true, nil, true, false, eHurtType.RealDmg)
          end
        end
      end
    else
      local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
      if 0 < targetList.Count then
        for i = targetList.Count - 1, 0, -1 do
          local num = targetList[i]:GetBuffTier(self.config.buffId)
          local damage = (self.arglist[2] + num * self.arglist[3]) * skill_intensity // 1000
          LuaSkillCtrl:RemoveLife(damage, self, targetList[i], true, nil, true, false, eHurtType.RealDmg)
        end
      end
    end
  end, nil, 0, 0)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
end

function bs_212701:OnCasterDie()
  base.OnCasterDie(self)
  if self.LoopDamage ~= nil then
    self.LoopDamage:Stop()
    self.LoopDamage = nil
  end
end

return bs_212701
