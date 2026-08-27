local bs_4018 = class("bs_4018", LuaSkillBase)
local base = LuaSkillBase
bs_4018.config = {HurtConfig = 14}

function bs_4018:ctor()
end

function bs_4018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4018_2", 1, self.OnAfterPlaySkill)
end

function bs_4018:OnAfterPlaySkill(skill, role)
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  local damage = self.caster.def * self.arglist[2] // 1000 + self.caster.magic_res * self.arglist[2] // 1000
  if target == self.caster and skill.isCommonAttack and role.belongNum ~= self.caster.belongNum and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {damage}, true)
    skillResult:EndResult()
  end
end

function bs_4018:LuaDispose()
  base.LuaDispose(self)
end

function bs_4018:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4018
