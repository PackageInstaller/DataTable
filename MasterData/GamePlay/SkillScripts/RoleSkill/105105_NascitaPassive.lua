local bs_105104 = require("GamePlay.SkillScripts.RoleSkill.105104_NascitaPassive")
local bs_105105 = class("bs_105404", bs_105104)
local base = bs_105104
bs_105105.config = {
  buffId_lowHeal = 3018,
  buffId_claw = 1051012,
  buffId_CD = 1051014,
  buffId_Damageup = 1051018,
  selectId = 9,
  selectRange = 10,
  realHurt = {basehurt_formula = 3000},
  weaponLv = 2
}
bs_105105.config = setmetatable(bs_105105.config, {
  __index = base.config
})

function bs_105105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.BattlestartPlay = self.arglist[11]
  self.triggerTag = false
  self.TemSpeed = 0
  self.SpeedNum = self.arglist[15]
  self.SpeedNumTier = self.arglist[12]
end

function bs_105105:OnAfterBattleStart()
  self.caster.recordTable.MaxAttackCount = self.arglist[11]
  self.caster.recordTable.SplashAttackCount = self.arglist[2]
  self.caster.recordTable.SplashAttackLow = 1000 + self.arglist[16]
end

function bs_105105:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_CD and target == self.caster and target.hp > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_miss, 1)
    if self.caster.speed >= self.SpeedNum then
      local ExtarSpeed = self.caster.speed - self.SpeedNum
      local TemDamageTier = ExtarSpeed // self.SpeedNumTier
      local MaxDamageTier = self.arglist[14] // self.arglist[13]
      local DamageTier = 0
      if TemDamageTier <= MaxDamageTier then
        DamageTier = TemDamageTier
      else
        DamageTier = MaxDamageTier
      end
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_Damageup, 0, false)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Damageup, DamageTier, nil, false)
      self.TemSpeed = self.caster.speed
    end
    if not self.triggerTag then
      self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_105101_1", 1, self.OnCasterAttributeChange)
    end
  end
  if buff.dataId == self.config.buffId_claw and target.hp > 0 and 0 < self.caster:GetBuffTier(self.config.buffId_CD) then
    self.afterNum = target:GetBuffTier(self.config.buffId_claw)
    self.clawNum = self.clawNum + self.afterNum - self.beforeNum
  end
end

function bs_105105:OnCasterAttributeChange()
  self.triggerTag = true
  if self.TemSpeed ~= self.caster.speed then
    self.TemSpeed = self.caster.speed
    if self.caster.speed >= self.SpeedNum then
      local ExtraSpeed = self.caster.speed - self.SpeedNum
      local TemDamageTier = ExtraSpeed // self.SpeedNumTier
      local MaxDamageTier = self.arglist[14] // self.arglist[13]
      local DamageTier = 0
      if TemDamageTier <= MaxDamageTier then
        DamageTier = TemDamageTier
      else
        DamageTier = MaxDamageTier
      end
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_Damageup, 0, false)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Damageup, DamageTier, nil, false)
    end
  end
end

function bs_105105:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_CD and target == self.caster and target.hp > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_miss, 0)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_Damageup, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_miss, 1, self.arglist[8])
    local originAttrList = self.caster.originAttrList
    local MaxHp = originAttrList[eHeroAttr.maxHp] * self.arglist[10] // 1000
    if MaxHp >= self.HpSum then
      local Num = self.caster.pow * self.arglist[9] // 1000 * self.clawNum
      if MaxHp < self.HpSum + Num then
        Num = MaxHp - self.HpSum
      end
      if 0 < Num then
        self.caster:AddRoleProperty(eHeroAttr.maxHp, Num, eHeroAttrType.Extra)
        LuaSkillCtrl:CallHeal(Num, self, self.caster, true)
        self.HpSum = self.HpSum + Num
      end
    end
    self.clawNum = 0
    self:RemoveSkillTrigger(eSkillTriggerType.OnSelfAttrChanged)
    self.triggerTag = false
  end
end

function bs_105105:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105105
