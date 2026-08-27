local bs_10201 = class("bs_10201", LuaSkillBase)
local base = LuaSkillBase
bs_10201.config = {buffId = 1037}

function bs_10201:ctor()
end

function bs_10201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_10201_1", 1, self.OnAfterMove)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10201_2", 2, self.OnAfterBattleStart)
end

function bs_10201:OnAfterBattleStart()
  self.blueCount = 0
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if 0 >= targetlist.Count then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 1002 and LuaSkillCtrl:GetRoleGridsDistance(self.caster, targetRole) == 1 then
      self.blueCount = self.blueCount + 1
    end
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1] * self.blueCount, nil, true)
end

function bs_10201:OnAfterMove()
  self.blueCount = 0
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if 0 >= targetlist.Count then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 1002 and LuaSkillCtrl:GetRoleGridsDistance(self.caster, targetRole) == 1 then
      self.blueCount = self.blueCount + 1
    end
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1] * self.blueCount)
  self:PlayChipEffect()
end

function bs_10201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10201
