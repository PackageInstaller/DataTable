local bs_208603 = class("bs_208603", LuaSkillBase)
local base = LuaSkillBase
bs_208603.config = {
  buffId_192 = 208602,
  select_id = 2,
  select_range = 10
}

function bs_208603:ctor()
end

function bs_208603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_208603_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_208603_10", 1, self.OnRoleDie)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_208603_11", 1, self.OnBeforePlaySkill)
  self.last_num = 0
end

function bs_208603:OnBeforePlaySkill(role, context)
  if role == self.caster then
    local targetList = LuaSkillCtrl:GetAllFriendRolesRelative(self.caster.belongNum)
    if targetList.Count > 0 and targetList.Count ~= self.last_num then
      local again = targetList.Count - self.last_num
      if 0 < again then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_192, again)
        self.last_num = self.last_num + again
      end
      if again < 0 then
        local num = -again
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_192, num)
        self.last_num = self.last_num + again
      end
    end
  end
end

function bs_208603:OnAfterBattleStart()
  local targetall = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetall.Count > 0 then
    self.last_num = targetall.Count
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_192, targetall.Count)
  end
end

function bs_208603:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_192, 1)
    self.last_num = self.last_num - 1
  end
end

function bs_208603:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208603
