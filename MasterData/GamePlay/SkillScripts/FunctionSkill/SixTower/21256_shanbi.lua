local sixtower_shanbi = class("sixtower_shanbi", LuaSkillBase)
local base = LuaSkillBase
sixtower_shanbi.config = {
  buffId = 2240,
  effectId1 = 12206,
  effectId2 = 12207
}

function sixtower_shanbi:ctor()
end

function sixtower_shanbi:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("sixtower_shanbi", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.enemy, nil, nil, eBattleRoleType.character, nil, nil, false)
  self.countTimes = 0
end

function sixtower_shanbi:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if isMiss then
    self.countTimes = self.countTimes + 1
    local clear_times = self.countTimes // self.arglist[2]
    self.countTimes = self.countTimes % self.arglist[2]
    if 0 < clear_times then
      local p_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      for i = 0, p_list.Count - 1 do
        LuaSkillCtrl:DispelBuff(p_list[i], self.config.buffId, clear_times, false, false)
      end
    end
  else
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil)
    LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
  end
end

function sixtower_shanbi:OnCasterDie()
  base.OnCasterDie(self)
end

return sixtower_shanbi
