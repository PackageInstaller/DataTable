local bs_21063 = class("bs_21063", LuaSkillBase)
local base = LuaSkillBase
bs_21063.config = {}

function bs_21063:ctor()
end

function bs_21063:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21063_1", 1, self.OnAfterBattleStart)
  self.Timer = nil
end

function bs_21063:OnAfterBattleStart()
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
  self.Timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetlist.Count > 0 then
      local maxTargetRole = targetlist[0].targetRole
      local minTargetRole = targetlist[0].targetRole
      for i = 0, targetlist.Count - 1 do
        local targetRole = targetlist[i].targetRole
        if targetRole.hp // targetRole.maxHp >= maxTargetRole.hp // maxTargetRole.maxHp then
          maxTargetRole = targetRole
        end
        if targetRole.hp // targetRole.maxHp <= minTargetRole.hp // minTargetRole.maxHp then
          minTargetRole = targetRole
        end
      end
      if minTargetRole == maxTargetRole then
        return
      end
      local value1 = maxTargetRole.maxHp * (maxTargetRole.hp // maxTargetRole.maxHp - minTargetRole.hp // minTargetRole.maxHp)
      local value2 = minTargetRole.maxHp * (maxTargetRole.hp // maxTargetRole.maxHp - minTargetRole.hp // minTargetRole.maxHp)
      LuaSkillCtrl:RemoveLife(value1, self, maxTargetRole, false, nil, true, true, eHurtType.RealDmg)
      LuaSkillCtrl:CallHeal(value2, self, minTargetRole, true)
    end
  end, nil, -1, self.arglist[1])
end

function bs_21063:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_21063:LuaDispose()
  base.LuaDispose(self)
  if self.Timer ~= nil then
    self.Timer:Stop()
    self.Timer = nil
  end
end

return bs_21063
