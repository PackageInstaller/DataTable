local bs_100907 = class("bs_100907", LuaSkillBase)
local base = LuaSkillBase
bs_100907.config = {
  Role_id = 1009,
  selectId = 80,
  buffId = 100902,
  buffId2 = 100903,
  buffIdAwake = 100904
}

function bs_100907:ctor()
end

function bs_100907:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.BenchRole = LuaSkillCtrl:GetOriginRole(self.config.Role_id)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100907_1", 1, self.OnAfterBattleStart)
end

function bs_100907:OnAfterBattleStart()
  if self.BenchRole == nil then
    return
  end
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 20)
  if highAttRole == nil then
    return
  end
  local role = highAttRole[0].targetRole
  if self.BenchRole.recordTable.weaponLv >= 3 then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId2, 1, nil, true)
  else
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil, true)
  end
  LuaSkillCtrl:StartTimer(self, 15, function()
    LuaSkillCtrl:CallBuff(self, role, self.config.buffIdAwake, 1, nil)
  end, self, 0)
end

function bs_100907:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100907
