local bs_107003 = class("bs_107003", LuaSkillBase)
local base = LuaSkillBase
bs_107003.config = {
  hurt_id = 3,
  hurtConfig_ex = 5,
  hurt_id_crit = 13,
  hurtConfig_ex_crit = 17,
  time_buff_rune_red = 9,
  buff_count = 107004,
  buff_rune_red = 107002,
  buff_rune_blue_count = 107005,
  buff_rune_red_count = 107003,
  buff_lock = 107006,
  buff_Ex_LV = 107007,
  buff_Ult_LV = 107008,
  effect_grid = 107010,
  effect_ult = 107009,
  effect_Ex_1 = 107017,
  effect_Ex_2 = 107018,
  audioIdStart = 107006,
  audioIdMovie = 107007,
  audioIdEnd = 107008
}

function bs_107003:ctor()
end

function bs_107003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnPlaylunaExSkill, self.OnPlaylunaExSkill, self)
  self:AddAfterPlaySkillTrigger("bs_107003_1", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
  self:AddOnRoleDieTrigger("bs_107001_3", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107003_4", 1, self.OnAfterBattleStart)
  self.caster.recordTable.crit_trigger = false
  self.caster.recordTable.bless = false
  self.secondult = true
  self.Ex_LV = 0
  self.Ult_LV = 0
  self.extimes = 0
end

function bs_107003:OnAfterBattleStart()
  if self.caster.recordTable.bless then
    local UltMp
    self.firstUltMpcost = ConfigData.game_config.ultMpCost * (1000 - self.caster.recordTable.Ultcost_des) // 1000
    self.firstUlttimer = LuaSkillCtrl:StartTimer(nil, 5, function()
      if self.caster:IsAbandonUltSkill() then
        self.isUltCanSpeicalPlay = false
        return
      end
      UltMp = LuaSkillCtrl:GetUltHMp()
      if not LuaSkillCtrl.IsInVerify then
        LuaSkillCtrl.cUltSkillCtrl:UpdateUIForce()
      end
      if UltMp >= self.firstUltMpcost and self.secondult then
        self.isUltCanSpeicalPlay = true
      else
        self.isUltCanSpeicalPlay = false
      end
    end, nil, -1, 5)
  end
end

function bs_107003:CustomCostPlayerUltMp()
  if self.caster.recordTable.bless and self.secondult and self.isUltCanSpeicalPlay then
    LuaSkillCtrl:CallAddPlayerHmp(-self.firstUltMpcost)
    self.isUltCanSpeicalPlay = false
    if self.firstUlttimer ~= nil then
      self.firstUlttimer:Stop()
      self.firstUlttimer = nil
    end
  else
    LuaSkillCtrl:CallAddPlayerHmp(-ConfigData.game_config.ultMpCost)
  end
  if not LuaSkillCtrl.IsInVerify then
    LuaSkillCtrl.cUltSkillCtrl:UpdateUIForce()
  end
end

function bs_107003:CustomRecoverPlayerUltMpForOnceTake()
  if self.caster.recordTable.bless and self.secondult and self.isUltCanSpeicalPlay then
    LuaSkillCtrl:CallAddPlayerHmp(self.firstUltMpcost)
    self.isUltCanSpeicalPlay = true
  else
    LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost)
  end
  if not LuaSkillCtrl.IsInVerify then
    LuaSkillCtrl.cUltSkillCtrl:UpdateUIForce()
  end
end

function bs_107003:PlaySkill(data)
  self:CallCasterWait(10)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  local skill_times = 0
  local target_last
  LuaSkillCtrl:StartTimer(nil, self.arglist[3] // self.arglist[1], function()
    local targetlist_enemy = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
    if targetlist_enemy ~= nil and targetlist_enemy.Count > 0 then
      local target = targetlist_enemy[0].targetRole
      if target ~= nil and 0 < target.hp then
        if skill_times == 0 or target ~= target_last then
          local bufftime = self.arglist[3] // self.arglist[1] * (self.arglist[1] - skill_times)
          if target ~= target_last and target_last ~= nil then
            LuaSkillCtrl:DispelBuff(target_last, self.config.buff_lock, 1, false)
          end
          LuaSkillCtrl:CallBuff(self, target, self.config.buff_lock, 1, bufftime, true)
          skill_times = skill_times + 1
        end
        target_last = target
        self:Moonlight(target)
      end
    end
  end, self, self.arglist[1] - 1, self.arglist[3] // self.arglist[1])
end

function bs_107003:OnPlaylunaExSkill()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
  if targetlist ~= nil and targetlist.Count > 0 then
    local target_ex = targetlist[0].targetRole
    if target_ex ~= nil then
      if self.Ex_LV > self.caster.recordTable.damge_Ex_upgrade_times // 2 + 1 then
        LuaSkillCtrl:CallEffect(target_ex, self.config.effect_Ex_2, self, self.SkillEventFunc, nil, 1)
      else
        LuaSkillCtrl:CallEffect(target_ex, self.config.effect_Ex_1, self, self.SkillEventFunc, nil, 1)
      end
    end
  end
end

function bs_107003:Moonlight(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:CallBuff(self, target, self.config.buff_count, 1, 999, true)
  local buffnum = target:GetBuffTier(self.config.buff_count)
  if buffnum >= self.arglist[4] then
    LuaSkillCtrl:DispelBuff(target, self.config.buff_count, buffnum, false)
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_rune_red_count, 1, self.caster.recordTable.time_rune_red, false)
  end
  local dam_Ult = self.arglist[2] + self.Ult_LV * self.arglist[5]
  local hurt_id = self.config.hurt_id
  if self.caster.recordTable.crit_trigger and target:GetBuffTier(self.config.buff_rune_red_count) > 0 then
    hurt_id = self.config.hurt_id_crit
  end
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, hurt_id, {dam_Ult}, false)
  LuaSkillCtrl:CallEffect(target, self.config.effect_ult, self)
end

function bs_107003:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local buffnum = target.targetRole:GetBuffTier(self.config.buff_rune_red_count)
    local dambase = self.caster.recordTable.damge_Ex + self.Ex_LV * self.caster.recordTable.damge_Ex_upgrade
    if self.caster.recordTable.damgeplus_Ex ~= nil then
      dambase = dambase * (1000 + buffnum * self.caster.recordTable.damgeplus_Ex) // 1000
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole)
    local hurt_id = self.config.hurtConfig_ex
    if self.caster.recordTable.crit_trigger and target.targetRole:GetBuffTier(self.config.buff_rune_red_count) > 0 then
      hurt_id = self.config.hurtConfig_ex_crit
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_rune_blue_count, self.caster.recordTable.cost_rune_blue, false)
    local bufftier = target.targetRole:GetBuffTier(self.config.buff_rune_red_count)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, hurt_id, {dambase}, true, nil, nil, 101)
    skillResult:EndResult()
  end
end

function bs_107003:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isUltSkill and skill.funcHeroId == self.caster.roleDataId then
    if self.secondult and not self:IsReadyToTake() then
      local curtime = skill.totalCDTime
      LuaSkillCtrl:CallResetCDForSingleSkill(skill, curtime)
    end
    self:SkillUpgrade()
  end
end

function bs_107003:SkillUpgrade()
  if self.Ult_LV < self.arglist[6] and self.secondult == false then
    self.Ult_LV = self.Ult_LV + 1
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_Ex_LV, 1)
  end
  if self.Ex_LV < self.caster.recordTable.damge_Ex_upgrade_times then
    self.Ex_LV = self.Ex_LV + 1
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_Ult_LV, 1)
  end
  self.secondult = false
end

function bs_107003:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107003:PlayUltMovie(moveSelectTarget, selectTargetCoord, selectRoles)
  local currentMP = LuaSkillCtrl:GetUltHMp()
  if self.isUltCanSpeicalPlay and currentMP < self.firstUltMpcost then
    return true
  end
  return base.PlayUltMovie(self, moveSelectTarget, selectTargetCoord, selectRoles)
end

function bs_107003:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_107003:OnRoleDie(killer, role)
  if role:GetBuffTier(self.config.buff_lock) > 0 and role.hp == 0 and role ~= nil and role.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:DispelBuff(role.targetRole, self.config.buff_lock, 1)
  end
end

function bs_107003:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107003:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107003:OnCasterDie()
  base.OnCasterDie(self)
  if self.firstUlttimer ~= nil then
    self.firstUlttimer:Stop()
    self.firstUlttimer = nil
  end
end

function bs_107003:LuaDispose()
  base.LuaDispose(self)
  if self.firstUlttimer ~= nil then
    self.firstUlttimer:Stop()
    self.firstUlttimer = nil
  end
end

return bs_107003
