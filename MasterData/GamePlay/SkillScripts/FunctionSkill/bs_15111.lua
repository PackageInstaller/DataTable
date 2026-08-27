local bs_15111 = class("bs_15111", LuaSkillBase)
local base = LuaSkillBase
bs_15111.config = {buffId = 110090}

function bs_15111:ctor()
end

function bs_15111:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15111_1", 1, self.OnAfterBattleStart)
end

function bs_15111:OnAfterBattleStart()
  local value = LuaSkillCtrl:GetCacheGold() // self.arglist[1]
  local topvalue = self.arglist[3] // 10
  value = math.min(topvalue, value)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole.roleType == eBattleRoleType.character then
        LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, value, nil, true)
      end
    end
  end
end

function bs_15111:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15111
