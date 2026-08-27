local gs_11 = class("gs_11", LuaGridBase)
gs_11.config = {
  effectId = 10374,
  leafEffectId = 10734,
  eatEffectId = 10735,
  buffId = 1049,
  buffTier = 300,
  caoTime = 70,
  lineEffectId = 10728
}

function gs_11:ctor()
end

function gs_11:OnGridBattleStart(role)
end

function gs_11:OnGridEnterRole(role)
  if self.caoTimer ~= nil then
    self.caoTimer:Stop()
    self.caoTimer = nil
  end
  self.currentRole = role
  local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  self.caoTimer = LuaSkillCtrl:StartTimer(nil, self.config.caoTime, arriveCallBack, nil, -1, self.config.caoTime)
end

function gs_11:SkillEventFunc1(target, effect, eventId)
end

function gs_11:OnArriveAction(role)
  if self.caoTimer ~= nil and self.caoTimer:IsOver() then
    self.caoTimer = nil
  end
  if self.currentRole ~= nil and self.currentRole.hp > 0 then
    local targetRole = self.currentRole
    local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.leafEffectId, self, targetRole, false, false, self.SkillEventFunc, targetRole)
  end
end

function gs_11:SkillEventFunc(targetRole, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skills = targetRole:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * 250 // 1000
          if not skills[j].isCommonAttack and not skills[j].isFreezeCD then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            LuaSkillCtrl:CallEffect(targetRole, self.config.eatEffectId, self)
          end
        end
        LuaSkillCtrl:CallDoodad(nil, targetRole)
      end
    end
  end
end

function gs_11:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_11:OnGridExitRole(role)
end

function gs_11:OnGridRoleDead(role)
end

function gs_11:LuaDispose()
  self.currentRole = nil
  LuaGridBase.LuaDispose(self)
end

return gs_11
