local bs_100501 = require("GamePlay.SkillScripts.RoleSkill.100501_CroquePassive")
local bs_100504 = class("bs_100504", bs_100501)
local base = bs_100501
bs_100504.config = {
  buffId_chiyan = 107101,
  weaponLv = 1,
  heal_formula = 100501
}
bs_100504.config = setmetatable(bs_100504.config, {
  __index = base.config
})

function bs_100504:ctor()
end

function bs_100504:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_100504_1", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, nil, nil, eBuffFeatureType.Taunt)
end

function bs_100504:OnAfterAddBuff(buff, target)
  if LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Taunt) and buff.maker == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_chiyan, 1, self.arglist[4])
  end
end

function bs_100504:Callback()
  if self.passive ~= nil and self.passive:IsOver() then
    self.passive = nil
  end
  local num = 0
  if self.caster.recordTable.peopleNum ~= nil and self.caster.recordTable.peopleNum ~= 0 then
    num = self.caster.recordTable.peopleNum
  end
  if self.caster.maxHp == self.caster.hp then
    local ShieldNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.heal_formula, self.caster, nil, self, num)
    self.caster.recordTable.recover_shield = self.caster.recordTable.recover_shield + ShieldNum
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {num}, true)
  skillResult:EndResult()
end

return bs_100504
