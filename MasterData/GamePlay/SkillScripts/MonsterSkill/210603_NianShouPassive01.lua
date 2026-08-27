local bs_210603 = class("bs_210603", LuaSkillBase)
local base = LuaSkillBase
bs_210603.config = {buffId_critcore = 210602, buffId_atkspeed = 210604}

function bs_210603:ctor()
end

function bs_210603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_210603_1", 1, self.OnAfterPlaySkill, nil, nil)
end

function bs_210603:OnAfterPlaySkill(skill, role)
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  if skill.isCommonAttack and skill.maker.belongNum ~= self.caster.belongNum and self.caster:GetBuffTier(self.config.buffId_critcore) > 0 and target == self.caster then
    LuaSkillCtrl:CallBuff(self, skill.maker, self.config.buffId_atkspeed, 1, 60, true)
  end
end

function bs_210603:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_210603
