local gs_27 = class("gs_27", LuaGridBase)
local base = LuaGridBase
gs_27.config = {
  effectId = 10374,
  leafEffectId = 10733,
  eatEffectId = 10376,
  buffId = 1049,
  buffTier = 300,
  caoTime = 45,
  lineEffectId = 10728,
  buff280 = 280
}

function gs_27:ctor()
end

function gs_27:OnGridBattleStart(role)
end

function gs_27:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff280, 1, nil, true)
  if self.caoTimer ~= nil then
    self.caoTimer:Stop()
    self.caoTimer = nil
  end
  self.currentRole = role
  local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  self.caoTimer = LuaSkillCtrl:StartTimer(nil, self.config.caoTime, arriveCallBack, nil, -1, self.config.caoTime)
  self.damage = 100
end

function gs_27:OnArriveAction(role)
  if self.caoTimer ~= nil and self.caoTimer:IsOver() then
    self.caoTimer = nil
  end
  if self.currentRole ~= nil and self.currentRole.hp > 0 then
    local targetRole = self.currentRole
    local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
    LuaSkillCtrl:CallEffect(target, self.config.lineEffectId, self, nil, role)
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.leafEffectId, self, targetRole, false, false, self.SkillEventFunc, targetRole)
  end
end

function gs_27:SkillEventFunc(targetRole, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skills = targetRole:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
        LuaSkillCtrl:CallDoodad(nil, targetRole)
        local hurt = targetRole.maxHp * self.damage // 1000
        LuaSkillCtrl:RemoveLife(hurt, self, targetRole, true, nil, nil, true)
        self.damage = self.damage + 100
      end
    end
  end
end

function gs_27:OnGridExitRole(role)
end

function gs_27:OnGridRoleDead(role)
end

function gs_27:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_27:LuaDispose()
  self.currentRole = nil
  base.LuaDispose(self)
end

return gs_27
