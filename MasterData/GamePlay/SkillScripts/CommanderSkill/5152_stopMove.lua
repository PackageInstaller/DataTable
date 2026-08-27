local bs_5152 = class("bs_5152", LuaSkillBase)
local base = LuaSkillBase
bs_5152.config = {buffId_60504 = 60504}

function bs_5152:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_5152_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_5152:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5152:CallSelectExecute(role)
  if role ~= nil and role.belongNum == self.caster.belongNum then
    if role:GetBuffTier(self.config.buffId_60504) < 1 then
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId_60504, 1, nil, true)
      role.recordTable.IngnoreStopMove = true
    else
      LuaSkillCtrl:DispelBuff(role, self.config.buffId_60504, 0, nil, true)
      role.recordTable.IngnoreStopMove = false
    end
  end
end

function bs_5152:OnRoleDie(killer, role)
  LuaSkillCtrl:DispelBuff(role, self.config.buffId_60504, 0, nil, true)
end

function bs_5152:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5152
