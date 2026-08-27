local bs_101701 = class("bs_101701", LuaSkillBase)
local base = LuaSkillBase
bs_101701.config = {buffId_cdSpeed = 101701, effectId = 101702}

function bs_101701:ctor()
end

function bs_101701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_101701_2", 1, self.OnAfterPlaySkill)
end

function bs_101701:OnAfterPlaySkill(skill, role)
  if role.belongNum ~= self.caster.belongNum and role ~= self.caster and skill.isCommonAttack ~= true then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_cdSpeed, 1)
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
  end
end

function bs_101701:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101701
