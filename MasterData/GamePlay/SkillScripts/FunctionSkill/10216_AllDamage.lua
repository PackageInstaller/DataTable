local bs_10216 = class("bs_10216", LuaSkillBase)
local base = LuaSkillBase
bs_10216.config = {effectId = 10127}

function bs_10216:ctor()
end

function bs_10216:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10216_1", 1, self.OnAfterBattleStart)
end

function bs_10216:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      if targetRole.belongNum == 2 then
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
        local hurt = math.max(1, targetRole.maxHp * self.arglist[1] // 1000)
        LuaSkillCtrl:RemoveLife(hurt, self, targetRole, true, nil, true, false, eHurtType.RealDmg)
      end
    end
  end
end

function bs_10216:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10216
