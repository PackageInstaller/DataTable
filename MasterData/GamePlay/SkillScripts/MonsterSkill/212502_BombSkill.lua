local bs_212502 = class("bs_212502", LuaSkillBase)
local base = LuaSkillBase
bs_212502.config = {
  effectId_bomb_end = 212501,
  effectId = 10988,
  buffId = 196
}

function bs_212502:ctor()
end

function bs_212502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local arriveCallBack1 = BindCallback(self, self.OnArriveAction1)
  self.timer2 = LuaSkillCtrl:StartTimer(nil, 75, arriveCallBack1, nil, -1, 75)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
  LuaSkillCtrl:StartShowSkillDurationTime(self, 75)
  self:AddOnRoleDieTriggerForTable("bs_212502_2", 99, self.OnRoleDie, {
    targetBelongNum = eBattleRoleBelong.player,
    target = self.caster
  })
  self.flag = 2
end

function bs_212502:OnArriveAction1()
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

function bs_212502:OnRoleDie(killer, role, skill)
  if killer.belongNum == eBattleRoleBelong.player and role == self.caster and self.flag ~= 0 then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    local damg = self.caster.maxHp * self.arglist[1]
    if 1 > targetlist.Count then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local target = targetlist[i].targetRole
      if target.belongNum == eBattleRoleBelong.player then
        LuaSkillCtrl:RemoveLife(damg, self, target, true, nil, true)
      end
    end
  end
end

function bs_212502:OnCasterDie()
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
  base.OnCasterDie(self)
end

function bs_212502:LuaDispose()
  base.LuaDispose(self)
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
end

return bs_212502
