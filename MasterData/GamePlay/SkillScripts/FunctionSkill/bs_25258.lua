local bs_25258 = class("bs_25258", LuaSkillBase)
local base = LuaSkillBase
bs_25258.config = {
  time = 150,
  buffId_gravity = 110140,
  gravityTime = 60
}

function bs_25258:ctor()
end

function bs_25258:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25258_1", 1, self.OnAfterBattleStart)
end

function bs_25258:OnAfterBattleStart()
  local gravity = BindCallback(self, self.OnAttackTrigger)
  self.time = LuaSkillCtrl:StartTimer(self, self.config.time, gravity, nil, -1, 60)
end

function bs_25258:OnAttackTrigger()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 5, 10)
  if targetList.Count <= 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    if targetList[i].targetRole.belongNum == eBattleRoleBelong.neutral then
      return
    end
    LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_gravity, 1, self.config.gravityTime)
    targetList[i].targetRole.lsObject.transform.localRotation = Quaternion.Euler(30, 0, 0)
  end
end

function bs_25258:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25258
