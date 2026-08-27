local bs_108801 = class("bs_108801", LuaSkillBase)
local base = LuaSkillBase
bs_108801.config = {
  buff_dodge = 108801,
  buffId_att = 108802,
  buffId_atk_life_steal = 108803,
  effectId_wind = 108805,
  effectId_wind_self = 108806,
  effectId_atk = 108807,
  effectId_hit = 108808,
  HurtConfigID = 17
}

function bs_108801:ctor()
end

function bs_108801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.dodge_num = 0
  self:AddAfterHurtTrigger("bs_108801_1", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108801_2", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_108801_4", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId_att)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_108801_3", 1, self.OnAfterHeal)
  self.dodge_pool = 0
  self.dodge_origin = self.arglist[3]
  self.caster.recordTable.atk2 = false
end

function bs_108801:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss == true and target == self.caster then
    self.caster.recordTable.dodge_num = self.caster.recordTable.dodge_num + 2
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_att, 2, self.arglist[6])
    if self.caster.recordTable.dodge_num >= self.arglist[7] then
      self:dodamege()
      self.caster.recordTable.dodge_num = self.caster.recordTable.dodge_num - self.arglist[7]
    end
  elseif isMiss == true then
    self.caster.recordTable.dodge_num = self.caster.recordTable.dodge_num + 1
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_att, 1, self.arglist[6])
    if self.caster.recordTable.dodge_num >= self.arglist[7] then
      self:dodamege()
      self.caster.recordTable.dodge_num = self.caster.recordTable.dodge_num - self.arglist[7]
    end
  end
  if 0 < hurt and target == self.caster then
    self:AddEffect()
  end
end

function bs_108801:OnAfterHeal()
  self:AddEffect()
end

function bs_108801:AddEffect()
  local hprate = self.caster._curHp * 1000 // self.caster.maxHp
  if hprate <= self.arglist[2] then
    hprate = self.arglist[2]
  end
  self.caster:AddRoleProperty(eHeroAttr.dodge, -self.dodge_pool, eHeroAttrType.Origin)
  self.dodge_pool = self.dodge_origin * ((1000 - hprate) / (1000 - self.arglist[2])) * 1000 // 1000
  self.caster:AddRoleProperty(eHeroAttr.dodge, self.dodge_pool, eHeroAttrType.Origin)
end

function bs_108801:OnAfterAddBuff(buff, target)
  local num = target:GetBuffTier(self.config.buffId_att)
  if num >= self.arglist[9] then
    if self.caster.recordTable.atk2 == false then
      self.caster.recordTable.atk2 = true
      self.testbuffer = LuaSkillCtrl:StartTimer(nil, 1, function()
        self:AfterBuffRemove()
      end, nil, -1, 0)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_atk_life_steal, 1)
    if self.effecter == nil then
      self.effecter = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_wind_self, self, nil, nil, nil, true)
    end
  end
end

function bs_108801:AfterBuffRemove()
  local num = self.caster:GetBuffTier(self.config.buffId_att)
  if num < self.arglist[9] then
    self.caster.recordTable.atk2 = false
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_atk_life_steal, 1)
    if self.effecter ~= nil then
      self.effecter:Die()
      self.effecter = nil
    end
    if self.testbuffer ~= nil then
      self.testbuffer:Stop()
      self.testbuffer = nil
    end
  end
end

function bs_108801:dodamege()
  local tar
  local targets = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
  for i = 0, targets.Count - 1 do
    local role = targets[i].targetRole
    if not LuaSkillCtrl:IsObstacle(role) then
      tar = role
      break
    end
  end
  if tar == nil then
    return
  end
  local tarGrid = LuaSkillCtrl:GetGridWithRole(tar)
  LuaSkillCtrl:CallEffect(tar, self.config.effectId_atk, self, nil, nil, nil, true)
  self:LoopAtk(tarGrid)
end

function bs_108801:LoopAtk(tarGrid)
  LuaSkillCtrl:StartTimer(nil, 8, function()
    local targetlist = LuaSkillCtrl:FindRolesAroundGrid(tarGrid, 2)
    if targetlist ~= nil and targetlist.Count > 0 then
      for i = targetlist.Count - 1, 0, -1 do
        local role = targetlist[i]
        if role.belongNum ~= eBattleRoleBelong.player then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[8]
          }, true)
          skillResult:EndResult()
          LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self, nil, nil, nil, true)
        end
      end
    end
  end, nil, 2, 4)
end

function bs_108801:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp then
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buff_dodge, 1)
        LuaSkillCtrl:CallEffect(targetList[i], self.config.effectId_wind, self, nil, nil, nil, true)
      end
    end
  end
end

function bs_108801:OnCasterDie()
  base.OnCasterDie(self)
  if self.testbuffer ~= nil then
    self.testbuffer:Stop()
    self.testbuffer = nil
  end
end

function bs_108801:LuaDispose()
  base.LuaDispose(self)
  if self.testbuffer ~= nil then
    self.testbuffer:Stop()
    self.testbuffer = nil
  end
end

return bs_108801
