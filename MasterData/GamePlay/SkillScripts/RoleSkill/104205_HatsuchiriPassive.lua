local bs_104204 = require("GamePlay.SkillScripts.RoleSkill.104201_HatsuchiriPassive")
local bs_104205 = class("bs_104205", bs_104204)
local base = bs_104204
bs_104205.config = {weaponLv = 2}
bs_104205.config = setmetatable(bs_104205.config, {
  __index = base.config
})

function bs_104205:ctor()
end

function bs_104205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.blinkTime = 0
  self.diveTime = 0
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddBuffDieTrigger("bs_104205_5", 1, self.OnBuffDie, self.caster, nil, self.config.buff_CD2)
  self:AddAfterBuffRemoveTrigger("bs_104205_6", 1, self.AfterBuffRemove, self.caster, nil, nil, nil, eBuffFeatureType.Stun)
  self:AddTrigger(eSkillTriggerType.OnBattleEnd, "bs_104205_22", 2, self.OnBattleEnd)
end

function bs_104205:OnRoleSplash(role)
  if role.belongNum == self.caster.belongNum then
    self.blinkTime = self.blinkTime + 1
  end
  self:AddDiveTime()
end

function bs_104205:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == self.caster.belongNum then
    self.blinkTime = self.blinkTime + 1
  end
  self:AddDiveTime()
end

function bs_104205:AddDiveTime()
  local value = self.diveTime
  if self.blinkTime >= self.arglist[7] then
    self.blinkTime = self.blinkTime - self.arglist[7]
    if self.caster:GetBuffTier(self.config.buff_CD2) == 0 and LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) == false then
      self:RealMove()
      self.caster.recordTable.case = 1
    elseif LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun) == true then
      self.caster.recordTable.case = 2
      if value < self.arglist[10] then
        value = value + 1
      end
      self.diveTime = value
      self:ShowDiveCounting()
    else
      if value < self.arglist[10] then
        value = value + 1
      end
      self.diveTime = value
      self:ShowDiveCounting()
    end
  end
end

function bs_104205:ShowDiveCounting()
  local value = self.diveTime
  if value == 0 then
    LuaSkillCtrl:HideCounting(self.caster)
  end
  if value ~= 0 then
    LuaSkillCtrl:ShowCounting(self.caster, value, self.arglist[10])
  end
end

function bs_104205:OnBuffDie(buff, target, removeType)
  local num = self.diveTime
  local isStun = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun)
  if self.caster.recordTable.case == 1 and removeType == eBuffRemoveType.Timeout and 0 < num and self.config.weaponLv >= 2 then
    if isStun == false then
      self:RealMove()
      num = num - 1
      self.diveTime = num
    else
      self.caster.recordTable.case = 2
    end
  end
end

function bs_104205:AfterBuffRemove(buffId, target, removeType)
  if self.caster.recordTable.case == 2 then
    local num = self.diveTime
    local isStun = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Stun)
    if isStun == false and 0 < num and 2 <= self.config.weaponLv and self.caster:GetBuffTier(self.config.buff_CD2) == 0 then
      self:RealMove()
      num = num - 1
      self.diveTime = num
    end
    if isStun == false then
      self.caster.recordTable.case = 1
    end
  end
end

function bs_104205:OnBattleEnd()
  LuaSkillCtrl:HideCounting(self.caster)
end

function bs_104205:OnCasterDie()
  LuaSkillCtrl:HideCounting(self.caster)
  base.OnCasterDie(self)
  self.blinkTime = 0
  self.diveTime = 0
end

function bs_104205:LuaDispose()
  LuaSkillCtrl:HideCounting(self.caster)
  base.LuaDispose(self)
end

return bs_104205
