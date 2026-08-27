local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1011012 = class("bs_1011012", base)
bs_1011012.config = {buffId_maxHpUp_maxHpUp_maxHpUp = 101103}

function bs_1011012:ctor()
end

function bs_1011012:InitSkill(isMidwaySkill)
  self.timeattack = 0
  self.time = 0
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_1011012_12", 1, self.OnAfterPlaySkill)
  self:OnCasterAttributeChange()
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_1011012_attrObs", 1, self.OnCasterAttributeChange)
end

function bs_1011012:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    self.timeattack = self.timeattack + 1
  end
  if role == self.caster and skill.isCommonAttack and self.timeattack == self.arglist[1] and self.time < self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_maxHpUp_maxHpUp_maxHpUp, 1, nil, true)
    local heal = self.caster.skill_intensity * self.arglist[2] // 1000
    LuaSkillCtrl:CallHeal(heal, self, self.caster, true)
    self.time = self.time + 1
    self.timeattack = 0
  end
end

function bs_1011012:OnCasterAttributeChange()
  if self.num == nil then
    self.num = 0
    self._change_def = 0
    self.maxHp = self.caster.maxHp
  end
  local change_hp = self.caster.maxHp - self.maxHp
  local change_def = change_hp * self.arglist[6] // self.arglist[5]
  if self._change_def ~= change_def then
    local num = change_def - self._change_def
    self.caster:AddRoleProperty(eHeroAttr.magic_res, num, eHeroAttrType.Extra)
    self._change_def = change_def
  end
end

function bs_1011012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1011012
