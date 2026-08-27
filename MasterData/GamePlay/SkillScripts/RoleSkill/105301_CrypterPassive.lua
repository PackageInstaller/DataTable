local bs_105301 = class("bs_105301", LuaSkillBase)
local base = LuaSkillBase
bs_105301.config = {
  effect_trail1 = 105302,
  effect_trail2 = 105304,
  effect_trail3 = 105306,
  effectId_phase1 = 105308,
  effectId_phase2 = 105309,
  effectId_phase3 = 105310,
  effectId_getenergy = 105311,
  effectId_change = 105318,
  HurtConfigID1 = 3,
  HurtConfigID2 = 13
}

function bs_105301:ctor()
end

function bs_105301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnCrypterAttack, self.OnCrypterAttack)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_105301_2", 1, self.OnAfterPlaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_105301_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_105301_3", 1, self.BeforeEndBattle)
  self.caster.recordTable.she2 = false
  self.caster.recordTable.she3 = false
  local bind = self:GetSelfBindingObj()
  if bind ~= nil and self.caster.recordTable.she == nil then
    local sheArray = {}
    for i = 1, 3 do
      table.insert(sheArray, bind.specialObj[i])
    end
    self.caster.recordTable.she = sheArray
  end
end

function bs_105301:OnAfterBattleStart()
  self.atk_num = 0
  self.energy_max = self.arglist[5]
  self.energy_num_max = self.arglist[4]
  self.caster.recordTable.energy_num = 0
  self.caster.recordTable.energy_P1 = self.arglist[4] / 2
  self.caster.recordTable.energy_P2 = self.arglist[4]
end

function bs_105301:SetDaShe(num)
  local sheArray = self.caster.recordTable.she
  if sheArray == nil then
    return
  end
  if num ~= 1 and sheArray[1] ~= nil and sheArray[1].activeSelf ~= false then
    sheArray[1]:SetActive(false)
  end
  if num ~= 2 and sheArray[2] ~= nil and sheArray[2].activeSelf ~= false then
    sheArray[2]:SetActive(false)
  end
  if num ~= 3 and sheArray[3] ~= nil and sheArray[3].activeSelf ~= false then
    sheArray[3]:SetActive(false)
  end
  if sheArray[num] ~= nil then
    if sheArray[num].activeSelf ~= true then
      sheArray[num]:SetActive(true)
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_change, self)
  end
end

function bs_105301:HideDaShe()
  local sheArray = self.caster.recordTable.she
  if sheArray == nil then
    return
  end
  if sheArray[1] ~= nil and sheArray[1].activeSelf ~= true then
    sheArray[1]:SetActive(true)
  end
  if sheArray[2] ~= nil and sheArray[2].activeSelf ~= false then
    sheArray[2]:SetActive(false)
  end
  if sheArray[3] ~= nil and sheArray[3].activeSelf ~= false then
    sheArray[3]:SetActive(false)
  end
end

function bs_105301:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isUltSkill then
    self.caster.recordTable.energy_num = self.caster.recordTable.energy_num + self.caster.recordTable.energy_Ult
    self.energy_num_max = self.caster.recordTable.energy_Ult + self.energy_num_max
    if self.caster.recordTable.energy_num >= self.energy_max then
      self.caster.recordTable.energy_num = self.energy_max
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_getenergy, self)
    self:ShowAttackCounting(self.caster.recordTable.energy_num)
  end
  if role == self.caster and skill.isCommonAttack then
    self.atk_num = self.atk_num + 1
    if self.atk_num == self.arglist[1] then
      self.atk_num = 0
      if self.caster.recordTable.energy_num < self.energy_num_max then
        self.caster.recordTable.energy_num = self.caster.recordTable.energy_num + 1
        if self.caster.recordTable.energy_num >= self.energy_max then
          self.caster.recordTable.energy_num = self.energy_max
        end
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_getenergy, self)
        self:ShowAttackCounting(self.caster.recordTable.energy_num)
      end
    end
  end
  if self.caster.recordTable.energy_num >= self.caster.recordTable.energy_P1 and self.caster.recordTable.energy_num < self.caster.recordTable.energy_P2 and self.caster.recordTable.she2 == false and self.caster.recordTable.she3 == false then
    self:SetDaShe(2)
    self.caster.recordTable.she2 = true
  end
  if self.caster.recordTable.energy_num >= self.caster.recordTable.energy_P2 and self.caster.recordTable.she3 == false then
    self:SetDaShe(3)
    self.caster.recordTable.she3 = true
    self.caster.recordTable.she2 = false
  end
end

function bs_105301:OnCrypterAttack(target, sender, skill)
  if sender.hp <= 0 then
    return
  end
  if self.caster.recordTable.energy_num < self.caster.recordTable.energy_P1 then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effect_trail1, self, nil, false, self.Dodamage1)
  end
  if self.caster.recordTable.energy_num >= self.caster.recordTable.energy_P1 and self.caster.recordTable.energy_num < self.caster.recordTable.energy_P2 then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effect_trail2, self, nil, false, self.Dodamage2)
  end
  if self.caster.recordTable.energy_num >= self.caster.recordTable.energy_P2 then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effect_trail3, self, nil, false, self.Dodamage3)
  end
end

function bs_105301:Dodamage1(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID2, {
      self.arglist[2] + self.caster.recordTable.energy_num * self.arglist[3]
    })
    skillResult:EndResult()
  end
end

function bs_105301:Dodamage2(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID2, {
      self.arglist[2] + self.caster.recordTable.energy_num * self.arglist[3]
    })
    skillResult:EndResult()
  end
end

function bs_105301:Dodamage3(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID2, {
      self.arglist[2] + self.caster.recordTable.energy_num * self.arglist[3]
    })
    skillResult:EndResult()
  end
end

function bs_105301:ShowAttackCounting(nowCount)
  if nowCount == 0 then
    LuaSkillCtrl:HideCounting(self.caster)
    return
  end
  if nowCount < self.caster.recordTable.energy_P2 then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.caster.recordTable.energy_P2)
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 255, 255, 255)
  end
  if nowCount == self.caster.recordTable.energy_P2 then
    LuaSkillCtrl:ShowCounting(self.caster, nowCount, self.caster.recordTable.energy_P2)
    LuaSkillCtrl:SetCountingColor(self.caster, 0, 203, 250, 255)
  end
  if nowCount > self.caster.recordTable.energy_P2 and nowCount < self.energy_max then
    local Count = nowCount % self.caster.recordTable.energy_P2
    LuaSkillCtrl:ShowCounting(self.caster, Count, self.caster.recordTable.energy_P2)
    LuaSkillCtrl:SetCountingColor(self.caster, 224, 64, 255, 255)
  end
  if nowCount == self.energy_max then
    LuaSkillCtrl:ShowCounting(self.caster, self.caster.recordTable.energy_P2, self.caster.recordTable.energy_P2)
    LuaSkillCtrl:SetCountingColor(self.caster, 224, 64, 255, 255)
  end
end

function bs_105301:BeforeEndBattle()
  self:HideDaShe()
  self:ShowAttackCounting(0)
end

function bs_105301:OnCasterDie()
  base.OnCasterDie(self)
  self:HideDaShe()
  self:ShowAttackCounting(0)
end

return bs_105301
