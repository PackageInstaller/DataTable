local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1017012 = class("bs_1017012", base)
bs_1017012.config = {buffId_cdSpeed = 10170101, effectId = 101702}

function bs_1017012:ctor()
end

function bs_1017012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_1017012_2", 1, self.OnAfterPlaySkill)
end

function bs_1017012:OnAfterPlaySkill(skill, role)
  if role.belongNum ~= self.caster.belongNum and role ~= self.caster and skill.isCommonAttack ~= true then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_cdSpeed, 1)
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  end
end

function bs_1017012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1017012
