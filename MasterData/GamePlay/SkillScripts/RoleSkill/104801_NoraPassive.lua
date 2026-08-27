local bs_104801 = class("bs_104801", LuaSkillBase)
local base = LuaSkillBase
bs_104801.config = {
  buffId_down = 104801,
  buffId_Atk1 = 104802,
  buffId_Atk2 = 104803,
  buffId_Atk3 = 104804,
  buffId_Luk = 104808,
  buffId_stun = 7,
  audioId_caijin = 104808,
  weaponLv = 0,
  buffId_Atk11 = 104812,
  buffId_Atk12 = 104813,
  buffId_Atk13 = 104814,
  effectId_skillStart02 = 104813
}

function bs_104801:ctor()
end

function bs_104801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_104801_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_104801_2", 1, self.OnBuffDie)
  if self.config.weaponLv > 2 then
    self:AddLuaTrigger(eSkillLuaTrigger.OnUltSkillPlayed, self.OnUltSkillPlayed)
  end
end

function bs_104801:OnAfterBattleStart()
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  LuaSkillCtrl:StartTimer(nil, 1, function()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Atk1, 3, self.arglist[2], true)
  end)
  if 1 < self.config.weaponLv then
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role ~= nil and role.hp > 0 and role ~= self.caster then
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_Atk11, 3, self.arglist[9])
        end
      end
    end
  end
end

function bs_104801:OnBuffDie(buff, target, removeType)
  if target ~= self.caster then
    if buff.dataId == self.config.buffId_Atk11 then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_Atk12, 2, self.arglist[9], true)
    end
    if buff.dataId == self.config.buffId_Atk12 then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_Atk13, 1, self.arglist[9], true)
    end
    return
  end
  if buff.dataId == self.config.buffId_Atk1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Atk2, 2, self.arglist[2], true)
  end
  if buff.dataId == self.config.buffId_Atk2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Atk3, 1, self.arglist[2], true)
  end
  if buff.dataId == self.config.buffId_Atk3 then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_caijin)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_down, 1, nil, true)
    LuaSkillCtrl:CallRoleAction(self.caster, 1037, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, 1041, 1)
    self:jisi()
  end
  if buff.dataId == self.config.buffId_Luk then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_caijin)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_down, 1, nil, true)
    LuaSkillCtrl:CallRoleAction(self.caster, 1037, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, 1041, 1)
    self:jisi()
  end
end

function bs_104801:jisi()
  if self.config.weaponLv > 2 then
    self.Active_rate = self.arglist[11]
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[10], function()
      local random = LuaSkillCtrl:CallRange(1, 1000)
      if random <= self.Active_rate then
        self:Activation()
      else
        self.Active_rate = self.Active_rate + self.arglist[11]
        if self.Active_rate > self.arglist[12] then
          self.Active_rate = self.arglist[12]
        end
      end
    end, nil, -1)
  end
end

function bs_104801:OnUltSkillPlayed(role)
  local skills = LuaSkillCtrl:GetAllUltSkills()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local skill = skills[j]
        if skill.funcHeroId == self.caster.roleDataId then
          if self.timer ~= nil then
            self.timer:Stop()
            self.timer = nil
          end
          return
        end
      end
    end
  end
end

function bs_104801:Activation()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  LuaSkillCtrl:CallRoleAction(self.caster, 1042, 1)
  LuaSkillCtrl:CallRoleAction(self.caster, 102, 1)
  LuaSkillCtrl:CallRoleAction(self.caster, 1040, 3)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillStart02, self)
  LuaSkillCtrl:DispelBuffByMaker(self.caster, self.caster, self.config.buffId_down, 1, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Atk1, 3, self.arglist[2], true)
  if 1 < self.config.weaponLv then
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp and role ~= self.caster then
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_Atk11, 3, self.arglist[9])
        end
      end
    end
  end
end

function bs_104801:OnCasterDie()
  self:BreakLieDown()
  base.OnCasterDie(self)
end

function bs_104801:BreakLieDown()
  LuaSkillCtrl:CallRoleAction(self.caster, 1042, 1)
end

return bs_104801
