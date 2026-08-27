local bs_15213 = class("bs_15213", LuaSkillBase)
local base = LuaSkillBase
bs_15213.config = {buffId = 110111}

function bs_15213:ctor()
end

function bs_15213:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15213_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_15213_02", 1, self.ReCallBuff, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.ReCallBuff)
end

function bs_15213:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_15213:ReCallBuff()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  else
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_15213:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15213
