local bs_202302 = class("bs_202302", LuaSkillBase)
local base = LuaSkillBase
bs_202302.config = {
  buffId_191 = 191,
  checkId = 202303,
  select_id = 2,
  select_range = 10
}

function bs_202302:ctor()
end

function bs_202302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_202302_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_202302_10", 1, self.OnRoleDie)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_202302_11", 1, self.OnBeforePlaySkill)
end

function bs_202302:OnBeforePlaySkill(role, context)
  if role == self.caster and context.skill.dataId == self.config.checkId then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
    if targetList.Count > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_191, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_191, targetList.Count)
    end
  end
end

function bs_202302:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetList.Count > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_191, targetList.Count)
  end
end

function bs_202302:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum and role.intensity > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_191, 1)
  end
end

function bs_202302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202302
