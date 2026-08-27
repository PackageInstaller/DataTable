local bs_206707 = class("bs_206707", LuaSkillBase)
local base = LuaSkillBase
bs_206707.config = {
  buffId_superArmor = 2067011,
  buffId_curse = 2067012,
  effectId_curse = 2067011,
  buffId_curseLabel1 = 2067013,
  buffId_curseLabel2 = 2067014,
  buffId_curseLabel3 = 2067015,
  timeDuration = 15
}

function bs_206707:ctor()
end

function bs_206707:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_206707_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_206701_2", 99, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 206700)
  self.caster.recordTable.curse = self.arglist[1]
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_206707:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CountDown), nil, 119, 15)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_superArmor, 1, nil)
  self.caster:AddRoleProperty(eHeroAttr.cd_reduce, 1000, eHeroAttrType.Extra)
end

function bs_206707:CountDown()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  if self.timeValue <= 0 then
    LuaSkillCtrl:ForceEndBattle(false)
  end
end

function bs_206707:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack == true and isMiss == false then
    if target == nil or target.hp <= 0 then
      return
    end
    local frontTarget = self.caster.recordTable.frontTarget
    if frontTarget ~= nil and frontTarget ~= target then
      local falseGodEnermy = eBattleRoleBelong.player
      if self.caster.belongNum == eBattleRoleBelong.player then
        falseGodEnermy = eBattleRoleBelong.enemy
      end
      local targetList = LuaSkillCtrl:GetSelectTeamRoles(falseGodEnermy)
      if 0 < targetList.Count then
        for i = 0, targetList.Count - 1 do
          frontTarget = targetList[i]
          LuaSkillCtrl:DispelBuff(frontTarget, self.config.buffId_curse, 0, true)
          LuaSkillCtrl:DispelBuff(frontTarget, self.config.buffId_curseLabel1, 0, true)
          LuaSkillCtrl:DispelBuff(frontTarget, self.config.buffId_curseLabel3, 0, true)
        end
      end
    end
    self.caster.recordTable.frontTarget = target
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curse, 1)
    self:CurseLabel(target)
    if self.caster.recordTable.RootCurseUp ~= nil then
      local extraCurse = LuaSkillCtrl:CallRange(1, 1000)
      if extraCurse <= self.caster.recordTable.RootCurseUp then
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curse, 1)
        self:CurseLabel(target)
      end
    end
  end
end

function bs_206707:CurseLabel(target)
  local labelTier = target:GetBuffTier(self.config.buffId_curse)
  if labelTier <= 6 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_curseLabel3, 0, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curseLabel1, 1)
  else
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_curseLabel1, 0, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curseLabel3, 1)
  end
end

function bs_206707:OnCasterDie()
end

return bs_206707
