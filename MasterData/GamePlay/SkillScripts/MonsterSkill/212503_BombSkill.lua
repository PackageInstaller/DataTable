local bs_212503 = class("bs_212503", LuaSkillBase)
local base = LuaSkillBase
bs_212503.config = {
  effectId_bomb_end = 212501,
  effectId = 10988,
  buffId = 196
}

function bs_212503:ctor()
end

function bs_212503:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local arriveCallBack1 = BindCallback(self, self.OnArriveAction1)
  self.timer2 = LuaSkillCtrl:StartTimer(nil, 75, arriveCallBack1, nil, -1, 75)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
  LuaSkillCtrl:StartShowSkillDurationTime(self, 75)
  self:AddOnRoleDieTriggerForTable("bs_212503_2", 99, self.OnRoleDie, {
    targetBelongNum = eBattleRoleBelong.player,
    target = self.caster
  })
  self.flag = 2
end

function bs_212503:OnArriveAction1()
  if self.timer2 ~= nil and self.timer2:IsOver() then
    self.timer2 = nil
  end
  self.flag = self.flag - 1
  if self.flag == 0 then
    local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    local targetgrid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    LuaSkillCtrl:CallEffect(targetgrid, self.config.effectId, self)
    LuaSkillCtrl:RemoveLife(self.caster.maxHp * 2, self, self.caster, true, nil, false, true, 2, true)
    LuaSkillCtrl:SetRoleVisible(self.caster, false)
  end
end

function bs_212503:OnRoleDie(killer, role, skill)
  if killer.belongNum == eBattleRoleBelong.player and role == self.caster and self.flag == 1 then
    local damg = self.caster.maxHp * self.arglist[1]
    if killer ~= nil then
      LuaSkillCtrl:RemoveLife(damg, self, killer, true, nil, true)
    end
  end
end

function bs_212503:OnCasterDie()
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
  base.OnCasterDie(self)
end

function bs_212503:LuaDispose()
  base.LuaDispose(self)
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
end

return bs_212503
