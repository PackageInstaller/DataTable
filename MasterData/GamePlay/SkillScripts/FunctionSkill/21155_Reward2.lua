local bs_21155 = class("bs_21155", LuaSkillBase)
local base = LuaSkillBase
bs_21155.config = {buffId = 110034}

function bs_21155:ctor()
end

function bs_21155:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21155_1", 1, self.OnAfterBattleStart)
end

function bs_21155:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count > 0 then
    local buffTier = self.arglist[1] - targetlist.Count
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      local hpPercent = targetRole.hp * 1000 // targetRole.maxHp
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, buffTier, nil)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      local heal = hpPercent * targetRole.maxHp // 1000 - targetRole.hp
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {heal}, true, true)
    end
  end
end

function bs_21155:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21155
