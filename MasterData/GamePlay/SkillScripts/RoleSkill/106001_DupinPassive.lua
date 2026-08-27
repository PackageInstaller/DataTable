local bs_106001 = class("bs_106001", LuaSkillBase)
local base = LuaSkillBase
bs_106001.config = {
  hurtConfigId = 3,
  hurtConfigId2 = 13,
  effectId_hit = 106003,
  effectId_hit_pass = 106017,
  buffId_A = 106001,
  buffId_C = 106004,
  buffId_ult = 106003,
  buffId_cd = 106008,
  weaponLv = 0,
  buffId_EX = 106007,
  buffId_spe = 106005
}

function bs_106001:ctor()
end

function bs_106001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_106001_02", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_106001_03", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
  self:AddOnRoleDieTrigger("bs_106001_04", 1, self.OnRoleDie, nil, nil, self.caster.belongNum)
  self.caster.recordTable.clueTable = {}
  self.caster.recordTable.clueCount = 0
  self.permanentClue = 0
  self.caster.recordTable.passive_arg1 = self.arglist[1]
  self.caster.recordTable.Helper = nil
  self:AddLuaTrigger(eSkillLuaTrigger.DupinAttack, self.AccTimer)
  self.caster.recordTable.weaponlv2 = false
  self.caster.recordTable.weaponlv3 = false
end

function bs_106001:OnAfterBattleStart()
  if self.config.weaponLv >= 3 then
    self.caster.recordTable.weaponlv3 = true
  end
  self.updateTimer = LuaSkillCtrl:StartTimer(nil, 3, function()
    local clueTable = self.caster.recordTable.clueTable
    if clueTable ~= nil then
      local curFrame = LuaSkillCtrl.battleCtrl.frame
      local tempI = 0
      for i = 1, #clueTable do
        local clue = clueTable[i]
        local frame = clue % 100000
        if curFrame - frame < self.caster.recordTable.passive_skill1 then
          break
        end
        tempI = i
      end
      if tempI ~= 0 then
        local tempTable = {}
        for i = 1, #clueTable do
          if i > tempI then
            table.insert(tempTable, clueTable[i])
          end
        end
        self.caster.recordTable.clueTable = tempTable
      end
      clueTable = nil
    end
  end, nil, -1)
  if self.config.weaponLv >= 1 then
    self.caster.recordTable.clueCount = self.caster.recordTable.clueCount + self.arglist[3]
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_A, self.arglist[3])
    if self.config.weaponLv >= 3 then
      self.caster.recordTable.exClueCount = self.caster.recordTable.exClueCount + self.arglist[3]
    end
  end
end

function bs_106001:AccTimer(target)
  if target.belongNum == eBattleRoleBelong.enemy then
    local permanentClue_cost = 0
    local hurt
    local trigger_permanentClue = false
    if self.config.weaponLv >= 3 and self.caster.recordTable.clueCount < self.arglist[7] then
      permanentClue_cost = math.min(self.arglist[7] - self.caster.recordTable.clueCount, self.permanentClue)
    end
    hurt = (self.caster.recordTable.clueCount + permanentClue_cost) * self.arglist[2]
    if hurt == 0 then
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
      if self.caster.recordTable.weaponlv2 then
        LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.DupinExDam, target)
      end
      return
    end
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit_pass, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    if 0 < self.config.weaponLv then
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId2, {hurt})
    else
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfigId, {hurt})
    end
    skillResult:EndResult()
    self.caster.recordTable.clueCount = 0
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_A, 0)
    if self.config.weaponLv >= 3 and 0 < permanentClue_cost then
      self.permanentClue = self.permanentClue - permanentClue_cost
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_EX, permanentClue_cost)
    end
    if self.caster.recordTable.weaponlv2 then
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.DupinExDam, target)
    end
  end
end

function bs_106001:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss == true then
    local curFrame = LuaSkillCtrl.battleCtrl.frame
    local senderUid = sender.uid
    local clue = sender.uid * 100000 + curFrame
    table.insert(self.caster.recordTable.clueTable, clue)
    local addCount = 1
    if target:GetBuffTier(self.config.buffId_ult) > 0 then
      addCount = 2
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_C, 1)
    end
    self.caster.recordTable.clueCount = self.caster.recordTable.clueCount + addCount
    if self.config.weaponLv >= 3 then
      self.caster.recordTable.exClueCount = self.caster.recordTable.exClueCount + addCount
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_A, addCount)
  end
end

function bs_106001:OnRoleDie(killer, role)
  local clueTable = self.caster.recordTable.clueTable
  local uid = role.uid
  for i = #clueTable, 1, -1 do
    local clue = clueTable[i]
    local senderUid = math.modf(clue / 100000)
    if uid == senderUid then
      table.remove(clueTable, i)
    end
  end
end

function bs_106001:OnCasterDie()
  base.OnCasterDie(self)
  if self.updateTimer ~= nil then
    self.updateTimer:Stop()
    self.updateTimer = nil
  end
end

function bs_106001:LuaDispose()
  base.LuaDispose(self)
  if self.updateTimer ~= nil then
    self.updateTimer:Stop()
    self.updateTimer = nil
  end
end

return bs_106001
