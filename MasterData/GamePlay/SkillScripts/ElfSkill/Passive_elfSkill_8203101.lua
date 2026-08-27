local bs_8203101 = class("bs_8203101", LuaSkillBase)
local base = LuaSkillBase
bs_8203101.config = {buff_up1 = 705}

function bs_8203101:ctor()
end

function bs_8203101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_8203101_1", 1, self.OnCasterAttributeChange)
  self.caster.recordTable["self.dodge"] = 0
  self.skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
  self:OnCasterAttributeChange()
end

function bs_8203101:OnCasterAttributeChange()
  local dodgeNum = self.arglist[1]
  if self.skillCasterEntity.recordTable.elfSkill_Level == 4 then
    dodgeNum = dodgeNum - 30
  elseif self.skillCasterEntity.recordTable.elfSkill_Level == 3 then
    dodgeNum = dodgeNum - 20
  elseif self.skillCasterEntity.recordTable.elfSkill_Level == 2 then
    dodgeNum = dodgeNum - 10
  end
  if self.caster.recordTable["self.dodge"] ~= self.caster.dodge then
    self.caster.recordTable["self.dodge"] = self.caster.dodge
    local buffTier = self.caster.dodge // dodgeNum
    if 10 <= buffTier then
      buffTier = 10
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_up1, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_up1, buffTier, nil, true)
  end
end

function bs_8203101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8203101
