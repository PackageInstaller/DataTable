local bs_17010 = class("bs_17010", LuaSkillBase)
local base = LuaSkillBase
bs_17010.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  buffId = 2097,
  buffTier = 1
}

function bs_17010:ctor()
end

function bs_17010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17010_2", 10, self.OnAfterBattleStart)
  self.typenum = 2
end

function bs_17010:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
end

function bs_17010:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local roleslist = LuaSkillCtrl:CallTargetSelect(self, 81, 10)
  for i = 0, roleslist.Count - 1 do
    local grid = LuaSkillCtrl:GetGridWithRole(roleslist[i].targetRole)
    local targetList = LuaSkillCtrl:FindRolesAroundGrid(grid, 2)
    if targetList ~= nil then
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId, self.config.buffTier)
      end
    end
  end
end

function bs_17010:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17010
