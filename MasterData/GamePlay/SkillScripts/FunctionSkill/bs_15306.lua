local bs_15306 = class("bs_15306", LuaSkillBase)
local base = LuaSkillBase
bs_15306.config = {
  hurt_config = 10,
  buffId = 110125,
  effectId = 12088,
  effectId1 = 12087
}

function bs_15306:ctor()
end

function bs_15306:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15306_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_15306_02", 1, self.ReCallBuff, nil, nil, nil, eBattleRoleBelong.enemy)
end

function bs_15306:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 43, 10)
  if targetList.Count == 0 then
    return
  end
  self.buffRole = targetList[0].targetRole
  LuaSkillCtrl:CallBuff(self, self.buffRole, self.config.buffId, 1, nil, true)
end

function bs_15306:ReCallBuff(killer, role)
  if role == self.buffRole then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 43, 10)
    if targetList.Count == 0 then
      return
    end
    self.buffRole = targetList[0].targetRole
    LuaSkillCtrl:CallBuff(self, self.buffRole, self.config.buffId, 1, nil, true)
  end
end

function bs_15306:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_15306:LuaDispose()
  base.LuaDispose(self)
  self.buffRole = nil
end

return bs_15306
