local bs_15331 = class("bs_15331", LuaSkillBase)
local base = LuaSkillBase
bs_15331.config = {
  buffId = 2119,
  buffId2 = 2120,
  buffId3 = 1178,
  buffId4 = 2130,
  buffId5 = 2131,
  select_code = 64,
  select_code = 59,
  effectId1 = 12071,
  effectId2 = 12072
}

function bs_15331:ctor()
end

function bs_15331:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_15331_2", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, self.config.buffId3)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15331", 1, self.AfterBattleStart)
end

function bs_15331:AfterBattleStart()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList == nil and targetList.Count < 1 then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId2, 1, nil, true)
  end
end

function bs_15331:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId3 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId4, 1, self.arglist[3], true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId5, 1, self.arglist[3], true)
  end
end

function bs_15331:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15331
