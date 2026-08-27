local bs_208001 = class("bs_208001", LuaSkillBase)
local base = LuaSkillBase
bs_208001.config = {
  buffId_passive = 208001,
  shieldFormula = 3001,
  buffId_Boss = 3017
}

function bs_208001:ctor()
end

function bs_208001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnSixAttack, self.OnSixAttack)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_208001_2", 1, self.OnAfterBattleStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnMonsterStageCreat, self.OnMonsterStageCreat)
  if self.caster.roleDataId == 20059 then
    self:CallCasterWait(75)
  end
  self.time = 0
  self.caster.recordTable.pass = false
end

function bs_208001:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
end

function bs_208001:OnMonsterStageCreat(roleEnity)
  if roleEnity == self.caster then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
end

function bs_208001:OnSixAttack(target, sender, skill)
  if self.time == 0 and self.caster.recordTable.pass == true then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_passive, self.arglist[3])
    self.caster.recordTable.pass = false
  end
  self.time = self.time + 1
  if self.time >= self.arglist[1] then
    self.time = 0
    self.caster.recordTable.pass = true
    local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, self.caster, self, self.arglist[2], self.arglist[2])
    if 0 < shieldValue then
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
    end
  end
end

function bs_208001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208001
