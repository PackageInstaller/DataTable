local bs_17307 = class("bs_17307", LuaSkillBase)
local base = LuaSkillBase
bs_17307.config = {buffId_base = 2220, buffId_add = 2221}

function bs_17307:ctor()
end

function bs_17307:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17307", 1, self.OnAfterBattleStart)
end

function bs_17307:OnAfterBattleStart()
  local num = self:EnemyNumOverPlayer()
  if num < 0 then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_base, 1, nil, true, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_add, num, nil, true, nil, true)
end

function bs_17307:EnemyNumOverPlayer()
  local enmeyNum = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy).Count
  local playerNum = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player).Count
  if enmeyNum < self.arglist[1] then
    return -1
  end
  return enmeyNum - self.arglist[1]
end

function bs_17307:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17307
