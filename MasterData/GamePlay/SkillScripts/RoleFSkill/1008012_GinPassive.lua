local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1008012 = class("bs_1008012", base)
bs_1008012.config = {buffId_159 = 10080201}

function bs_1008012:ctor()
end

function bs_1008012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.BJ = true
  self.caster.recordTable["arglist[1]"] = self.arglist[1]
  self:AddAfterHealTrigger("bs_1008012_1", 1, self.OnAfterHeal, self.caster, nil, nil, nil, nil, nil, 1008002)
  self:AddAfterAddBuffTrigger("bs_1008012_2", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, nil, nil, eBuffFeatureType.Taunt)
  self:AddBuffDieTrigger("bs_1008012_3", 1, self.OnBuffDie, self.caster, nil, nil, nil, eBuffFeatureType.Taunt)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1008012_4", 1, self.OnAfterBattleStart)
end

function bs_1008012:OnAfterBattleStart()
  self.caster:AddRoleProperty(eHeroAttr.attackRange, 5, eHeroAttrType.Origin)
end

function bs_1008012:OnAfterHeal(sender, target, skill, heal, isStealHeal)
  if skill.dataId == 1008002 and sender == self.caster and not isStealHeal then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_159, 1, self.arglist[2])
  end
end

function bs_1008012:OnAfterAddBuff(buff, target)
  self.caster:AddRoleProperty(eHeroAttr.attackRange, -5, eHeroAttrType.Origin)
  self.caster.recordTable.BJ = false
end

function bs_1008012:OnBuffDie(buff, target, removeType)
  self.caster:AddRoleProperty(eHeroAttr.attackRange, 5, eHeroAttrType.Origin)
  self.caster.recordTable.BJ = true
end

function bs_1008012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1008012
