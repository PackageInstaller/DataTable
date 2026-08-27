local bs_4001039 = class("bs_4001039", LuaSkillBase)
local base = LuaSkillBase
bs_4001039.config = {
  buffId_gridId = 1207,
  buffId_attack = 2082,
  buffId_atkSpeed = 2083
}

function bs_4001039:ctor()
end

function bs_4001039:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001039_1", 1, self.OnAfterBattleStart)
end

function bs_4001039:OnAfterBattleStart()
  local isTargetGird = self.caster:GetBuffTier(self.config.buffId_gridId)
  if isTargetGird ~= nil and 0 < isTargetGird then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attack, 1, nil)
    local minasang = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    for i = 0, minasang.Count - 1 do
      LuaSkillCtrl:CallBuff(self, minasang[i], self.config.buffId_atkSpeed, 1, self.arglist[2])
    end
  end
end

function bs_4001039:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001039
