local bs_106101 = class("bs_106101", LuaSkillBase)
local base = LuaSkillBase
bs_106101.config = {
  buffId_crit = 106101,
  buffId_crit1 = 106102,
  buffId1 = 106103,
  HurtConfigID = 3,
  effectId_trail = 106103,
  effectId = 106104,
  configId = 3,
  heal_config = {baseheal_formula = 3022},
  buffId_speed = 106104,
  monsterId1 = 59,
  monsterId2 = 60,
  skilltime = 15,
  actionId = 1002,
  action_speed = 1.5,
  actionId_start_time = 7,
  effect_cast = 106105,
  effect_castend = 106106,
  buffId_1 = 106105,
  heal_config = {
    baseheal_formula = 3021,
    heal_number = 0,
    crit_formula = 9992,
    crithur_ratio = 9995,
    correct_formula = 9990
  },
  HurtConfigID1 = 17,
  weaponLv = 0
}

function bs_106101:ctor()
end

local SyncAttrList = {
  eHeroAttr.moveSpeed,
  eHeroAttr.dodge,
  eHeroAttr.critDamage,
  eHeroAttr.sunder,
  eHeroAttr.damage_increase,
  eHeroAttr.injury_reduce,
  eHeroAttr.heal,
  eHeroAttr.treatment,
  eHeroAttr.magic_pen,
  eHeroAttr.cd_reduce,
  eHeroAttr.resistance
}

function bs_106101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_106101_01", 1, self.OnAfterPlaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_106101_03", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_106101_02", 1, self.OnRoleDie)
  self.maxCount = 2
  self.table = {}
  self.gushou = nil
  self.haoshou = nil
  self.haoshou_actor = nil
  self.gushou_actor = nil
  self.attackCount = 0
  self.buffNum = 0
  self.trigger = false
end

function bs_106101:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack and role == self.caster then
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp then
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_crit1, 1, 125)
        end
      end
    end
  end
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  if skill.isCommonAttack and skill.maker.belongNum == self.caster.belongNum and role.roleType == 4 then
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, self.caster, nil, nil, self.SkillEventFunc)
    if 1 <= self.config.weaponLv then
      self.attackCount = self.attackCount + 1
      if self.attackCount >= self.arglist[18] then
        local buffNum = self.caster:GetBuffTier(self.config.buffId_1)
        if buffNum < 8 then
          LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1)
          self:OnMusicBuffChanged(true)
          self.trigger = true
          self.attackCount = 0
        end
      end
    end
  end
end

function bs_106101:StartTrack()
  self.extraSkillTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[16], function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_cast, self, nil)
    local e_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    for i = e_list.Count - 1, 0, -1 do
      local target = e_list[i]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID1, {
        self.arglist[17]
      }, true)
      skillResult:EndResult()
    end
    if self.config.weaponLv >= 3 then
      local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      if targetList ~= nil and targetList.Count > 0 then
        if targetList.Count <= 3 then
          for i = 0, targetList.Count - 1 do
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
            LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
              self.arglist[20]
            })
            skillResult:EndResult()
          end
        else
          for i = 0, 2 do
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
            LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
              self.arglist[20]
            })
            skillResult:EndResult()
          end
        end
      end
    end
    if self.trigger ~= true and 0 < self.caster:GetBuffTier(self.config.buffId_1) then
      LuaSkillCtrl:DispelBuff(target, self.buffId_1, 1, true, false)
      self:OnMusicBuffChanged(false)
    end
    self.trigger = false
  end, nil, -1)
end

function bs_106101:OnMusicBuffChanged(addBuff)
  if addBuff then
    self.extraSkillTimer.delay = self.extraSkillTimer.delay - self.arglist[19]
  else
    self.extraSkillTimer.delay = self.extraSkillTimer.delay + self.arglist[19]
  end
end

function bs_106101:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[3]
    }, nil, nil)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, nil, nil, nil, true)
  end
end

function bs_106101:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[4], BindCallback(self, self.doskill), nil, -1, 0)
  self.caster:AddRoleProperty(eHeroAttr.attackRange, 10, eHeroAttrType.Origin)
  if 0 < self.config.weaponLv then
    self:StartTrack()
  end
end

function bs_106101:doskill()
  if self.caster.recordTable.NeedRestart ~= true and not LuaSkillCtrl:RoleContainsCtrlBuff(self.caster) and #self.table < 2 then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self.caster.recordTable.NeedRestart = true
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_cast, self, nil)
    local time = self.config.skilltime * 10 // 15
    self:CallCasterWait(time)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.action_speed)
    LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time, BindCallback(self, self.OnAttackTrigger), nil)
  else
    LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time, BindCallback(self, self.OnAttackTrigger), nil)
  end
end

function bs_106101:OnAttackTrigger()
  local count = #self.table
  if count < self.maxCount then
    self:Summon()
  else
    for i = 1, #self.table do
      LuaSkillCtrl:CallBuff(self, self.table[i], self.config.buffId_speed, 1, self.arglist[7])
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.table[i])
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
        self.arglist[5]
      })
      skillResult:EndResult()
    end
    self:OnSyncAttrFromHost()
  end
end

function bs_106101:Summon()
  local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if Grid == nil then
    Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  end
  if Grid ~= nil then
    if #self.table == 0 then
      local num = LuaSkillCtrl:CallRange(1, 2)
      if num == 1 then
        self.gushou = true
      elseif num == 2 then
        self.haoshou = true
      end
      self:doSummon(Grid, num)
    elseif self.gushou ~= true then
      self:doSummon(Grid, 1)
      self.gushou = true
    elseif self.haoshou ~= true then
      self:doSummon(Grid, 2)
      self.haoshou = true
    end
  end
end

function bs_106101:doSummon(Grid, num)
  local summonerEntity
  if num == 1 then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effect_castend, self)
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId1, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[10] // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[8] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[8] // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def * self.arglist[9] // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.arglist[9] // 1000)
    summoner:SetAttr(eHeroAttr.lucky, self.caster.lucky)
    summoner:SetAttr(eHeroAttr.crit, self.caster.crit)
    local hostEntity = self.caster
    if hostEntity == nil or hostEntity.hp <= 0 then
      return over
    end
    for i, v in ipairs(SyncAttrList) do
      local curValue = self.caster:GetRealProperty(v)
      summoner:SetAttr(v, curValue)
    end
    summoner:SetAsRealEntity(1)
    local arg1 = self.arglist[11]
    local tab = {arg_1 = arg1}
    summoner:SetRecordTable(tab)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    if self.table[1] == nil then
      self.table[1] = summonerEntity
      self.gushou_actor = summonerEntity
    elseif self.table[2] == nil then
      self.table[2] = summonerEntity
      self.gushou_actor = summonerEntity
    end
  end
  if num == 2 then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effect_castend, self)
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId2, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[13] // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[8] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[8] // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def * self.arglist[12] // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.arglist[12] // 1000)
    summoner:SetAttr(eHeroAttr.lucky, self.caster.lucky)
    summoner:SetAttr(eHeroAttr.crit, self.caster.crit)
    local hostEntity = self.caster
    if hostEntity == nil or hostEntity.hp <= 0 then
      return over
    end
    for i, v in ipairs(SyncAttrList) do
      local curValue = self.caster:GetRealProperty(v)
      summoner:SetAttr(v, curValue)
    end
    summoner:SetAsRealEntity(1)
    local arg1 = self.arglist[14]
    local arg2 = self.arglist[15]
    local arg3 = LuaSkillCtrl:GetCasterSkinId(self.caster)
    local tab = {
      arg_1 = arg1,
      arg_2 = arg2,
      arg_3 = arg3
    }
    summoner:SetRecordTable(tab)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    if self.table[1] == nil then
      self.table[1] = summonerEntity
      self.haoshou_actor = summonerEntity
    elseif self.table[2] == nil then
      self.table[2] = summonerEntity
      self.haoshou_actor = summonerEntity
    end
  end
end

function bs_106101:OnSyncAttrFromHost()
  if self.table == nil or #self.table <= 1 then
    return
  end
  for i = 1, #self.table do
    if self.table[i] == self.gushou_actor then
      local summonerEntity = self.table[i]
      if summonerEntity == nil or summonerEntity.isDead then
        return
      end
      local originAttrList = summonerEntity.originAttrList
      for i, v in ipairs(SyncAttrList) do
        local attrValue = summonerEntity:GetRealProperty(v)
        local curValue = self.caster:GetRealProperty(v)
        if 0 < curValue - attrValue then
          summonerEntity:AddRoleProperty(v, curValue - attrValue, eHeroAttrType.Origin)
        end
      end
      local attrValue_def = originAttrList[eHeroAttr.def]
      local attrValue_ma_def = originAttrList[eHeroAttr.magic_res]
      local curValue1 = self.caster.def * self.arglist[9] // 1000
      local curValue2 = self.caster.magic_res * self.arglist[9] // 1000
      summonerEntity:AddRoleProperty(eHeroAttr.def, curValue1 - attrValue_def, eHeroAttrType.Origin)
      summonerEntity:AddRoleProperty(eHeroAttr.magic_res, curValue2 - attrValue_ma_def, eHeroAttrType.Origin)
      local attrValue_pow = originAttrList[eHeroAttr.pow]
      local attrValue_int = originAttrList[eHeroAttr.skill_intensity]
      local curValue3 = self.caster.pow * self.arglist[8] // 1000
      local curValue4 = self.caster.skill_intensity * self.arglist[8] // 1000
      summonerEntity:AddRoleProperty(eHeroAttr.pow, curValue3 - attrValue_pow, eHeroAttrType.Origin)
      summonerEntity:AddRoleProperty(eHeroAttr.skill_intensity, curValue4 - attrValue_int, eHeroAttrType.Origin)
      local hp_per = summonerEntity.hp * 1000 // summonerEntity.maxHp
      local curValue_hp = self.caster.maxHp * self.arglist[10] // 1000
      local attrValue_hp = originAttrList[eHeroAttr.maxHp]
      summonerEntity:AddRoleProperty(eHeroAttr.maxHp, curValue_hp - attrValue_hp, eHeroAttrType.Origin)
      if 0 < curValue_hp - attrValue_hp then
        local num = curValue_hp - attrValue_hp
        LuaSkillCtrl:CallHeal(num, self, summonerEntity, true)
      elseif curValue_hp - attrValue_hp < 0 then
        local num = attrValue_hp - curValue_hp
        LuaSkillCtrl:RemoveLife(num, self, summonerEntity, true, nil, false, true, 2, true)
      end
    end
    if self.table[i] == self.haoshou_actor then
      local summonerEntity = self.table[i]
      if summonerEntity == nil or summonerEntity.isDead then
        return
      end
      local originAttrList = summonerEntity.originAttrList
      for i, v in ipairs(SyncAttrList) do
        local attrValue = summonerEntity:GetRealProperty(v)
        local curValue = self.caster:GetRealProperty(v)
        if 0 < curValue - attrValue then
          summonerEntity:AddRoleProperty(v, curValue - attrValue, eHeroAttrType.Origin)
        end
      end
      local attrValue_def = originAttrList[eHeroAttr.def]
      local attrValue_ma_def = originAttrList[eHeroAttr.magic_res]
      local curValue1 = self.caster.def * self.arglist[12] // 1000
      local curValue2 = self.caster.magic_res * self.arglist[12] // 1000
      summonerEntity:AddRoleProperty(eHeroAttr.def, curValue1 - attrValue_def, eHeroAttrType.Origin)
      summonerEntity:AddRoleProperty(eHeroAttr.magic_res, curValue2 - attrValue_ma_def, eHeroAttrType.Origin)
      local attrValue_pow = originAttrList[eHeroAttr.pow]
      local attrValue_int = originAttrList[eHeroAttr.skill_intensity]
      local curValue3 = self.caster.pow * self.arglist[8] // 1000
      local curValue4 = self.caster.skill_intensity * self.arglist[8] // 1000
      summonerEntity:AddRoleProperty(eHeroAttr.pow, curValue3 - attrValue_pow, eHeroAttrType.Origin)
      summonerEntity:AddRoleProperty(eHeroAttr.skill_intensity, curValue4 - attrValue_int, eHeroAttrType.Origin)
      local hp_per = summonerEntity.hp * 1000 // summonerEntity.maxHp
      local curValue_hp = self.caster.maxHp * self.arglist[13] // 1000
      local attrValue_hp = originAttrList[eHeroAttr.maxHp]
      summonerEntity:AddRoleProperty(eHeroAttr.maxHp, curValue_hp - attrValue_hp, eHeroAttrType.Origin)
      if 0 < curValue_hp - attrValue_hp then
        local num = curValue_hp - attrValue_hp
        LuaSkillCtrl:CallHeal(num, self, summonerEntity, true)
      elseif curValue_hp - attrValue_hp < 0 then
        local num = attrValue_hp - curValue_hp
        LuaSkillCtrl:RemoveLife(num, self, summonerEntity, true, nil, false, true, 2, true)
      end
    end
  end
end

function bs_106101:OnRoleDie(killer, role)
  if role == self.table[1] and role == self.gushou_actor then
    table.remove(self.table, 1)
    self.gushou = nil
  elseif role == self.table[1] and role == self.haoshou_actor then
    table.remove(self.table, 1)
    self.haoshou = nil
  elseif role == self.table[2] and role == self.gushou_actor then
    table.remove(self.table, 2)
    self.gushou = nil
  elseif role == self.table[2] and role == self.haoshou_actor then
    table.remove(self.table, 2)
    self.haoshou = nil
  end
end

function bs_106101:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.extraSkillTimer ~= nil then
    self.extraSkillTimer:Stop()
    self.extraSkillTimer = nil
  end
end

function bs_106101:LuaDispose()
  self.gushou = nil
  self.haoshou = nil
  self.table = nil
  base.LuaDispose(self)
end

return bs_106101
