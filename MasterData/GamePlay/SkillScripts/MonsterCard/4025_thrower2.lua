local bs_4025 = class("bs_4025", LuaSkillBase)
local base = LuaSkillBase
bs_4025.config = {buffId = 107101}

function bs_4025:ctor()
end

function bs_4025:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4025_2", 1, self.OnAfterPlaySkill)
end

function bs_4025:OnAfterPlaySkill(skill, role)
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  if role == self.caster and skill.isCommonAttack and target.belongNum ~= self.caster.belongNum and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, 120)
  end
end

function bs_4025:LuaDispose()
  base.LuaDispose(self)
end

function bs_4025:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4025
