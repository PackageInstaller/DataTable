local bs_107201 = class("bs_107201", LuaSkillBase)
local base = LuaSkillBase
bs_107201.config = {
  buffId = 107101,
  time_buff = 120,
  buff_lock = 107201,
  buff_notmove = 107205,
  buffId_bati = 196,
  buff_show = 107204,
  buff_jianjia = 107206,
  weaponLv = 0,
  shieldFormula = 3021
}

function bs_107201:ctor()
end

function bs_107201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_107201_1", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId)
  self:AddAfterHurtTrigger("bs_107201_2", 1, self.OnAfterHurt, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil, nil)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107201_4", 1, self.OnAfterBattleStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnXinghuanAddZhuRan, self.OnXinghuanAddZhuRan)
  self.caster.recordTable.energy_num = 0
  self.caster.recordTable.dam_bot_attack = self.arglist[7]
  self.caster.recordTable.energy_num_max = self.arglist[6]
  self.caster.recordTable.firstChangeTimes = self.arglist[9]
  if self.config.weaponLv >= 2 then
    self.caster.recordTable.exChangeTimes = self.arglist[12]
  else
    self.caster.recordTable.exChangeTimes = 0
  end
  self.energyCount = 0
end

function bs_107201:OnAfterBattleStart()
  if self.config.weaponLv >= 2 then
    local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, nil, self, self.arglist[10])
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_show, self.arglist[11], 9999)
    self.caster.recordTable.energy_num = self.caster.recordTable.energy_num + self.arglist[11]
    if self.config.weaponLv >= 3 then
      self:AddUltiEnergy(self.arglist[11])
    end
    self.caster.recordTable.firstChangeTimes = self.arglist[9] + self.arglist[12]
  end
  local changestart = BindCallback(self, self.changOnBattleStart)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_lock, 1, 11, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_notmove, 1, 11, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_bati, 1, 11)
  self:CallCasterWait(11)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1005, 2, 11, changestart)
end

function bs_107201:changOnBattleStart()
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnPlayArmorChange, self.caster.recordTable.firstChangeTimes)
end

function bs_107201:OnAfterAddBuff(buff, target)
  if self.caster.recordTable.energy_num < self.caster.recordTable.energy_num_max then
    local buff_num = self.caster.recordTable.energy_num
    if self.caster.recordTable.changebody == false then
      self.caster.recordTable.energy_num = math.min(buff_num + self.arglist[1], self.caster.recordTable.energy_num_max)
      local buff_add = self.caster.recordTable.energy_num - buff_num
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_show, buff_add, 9999)
      if self.config.weaponLv >= 3 then
        self:AddUltiEnergy(buff_add)
      end
    else
      self.caster.recordTable.energy_num = math.min(buff_num + self.arglist[3], self.caster.recordTable.energy_num_max)
      local buff_add = self.caster.recordTable.energy_num - buff_num
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_show, buff_add, 9999)
      if self.config.weaponLv >= 3 then
        self:AddUltiEnergy(buff_add)
      end
    end
  end
  if self.config.weaponLv >= 2 and target ~= nil and target.hp > 0 and target.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_jianjia, 1, self.arglist[14])
  end
end

function bs_107201:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.skillType == eBattleSkillLogicType.Original and (skill.isNormalSkill or skill.isCommonAttack) and isMiss == false and isCrit then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.arglist[8], self.config.time_buff)
  end
end

function bs_107201:AddUltiEnergy(buffNum)
  self.energyCount = self.energyCount + buffNum
  if self.energyCount >= self.arglist[15] then
    LuaSkillCtrl:CallAddPlayerHmp(self.arglist[16] * 50)
    self.energyCount = self.energyCount - self.arglist[15]
  end
end

function bs_107201:OnXinghuanAddZhuRan(buffNum)
  if self.config.weaponLv >= 3 then
    self:AddUltiEnergy(buffNum)
  end
end

function bs_107201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107201
