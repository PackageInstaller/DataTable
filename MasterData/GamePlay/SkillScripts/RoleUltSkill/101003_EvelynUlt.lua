local bs_101003 = class("bs_101003", LuaSkillBase)
local base = LuaSkillBase
bs_101003.config = {
  effectId = 101006,
  buffId_Reduce = 101003,
  audioIdStart = 101005,
  audioIdMovie = 101006,
  audioIdEnd = 101007,
  movieEndRoleActionId = 100
}

function bs_101003:ctor()
end

function bs_101003:InitSkill(isMidwaySkill)
end

function bs_101003:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    if targetGrid ~= nil then
      self:CallTogether(targetGrid)
      self:CallShield(targetGrid)
    end
  end
end

function bs_101003:CallTogether(target)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  for i = 0, targetList.Count - 1 do
    if targetList[i] ~= nil and targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral then
      local emptyGrid = LuaSkillCtrl:CallFindEmptyGridClosedToTargetInRange(target.x, target.y, targetList[i].targetRole)
      if emptyGrid ~= nil and LuaSkillCtrl:GetGridsDistance(emptyGrid.x, emptyGrid.y, target.x, target.y) < LuaSkillCtrl:GetGridsDistance(targetList[i].targetRole.x, targetList[i].targetRole.y, target.x, target.y) then
        targetList[i].targetRole:ResetRoleState()
        LuaSkillCtrl:CallPhaseMove(self, targetList[i].targetRole, emptyGrid.x, emptyGrid.y, 5)
      end
    end
  end
end

function bs_101003:CallShield(targetGrid)
  local effect = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId, self)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Player, nil, collisionEnter, collisionExit)
  LuaSkillCtrl:StartTimer(nil, self.arglist[2], BindCallback(self, function(table, effect)
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end, effect))
end

function bs_101003:OnCollisionEnter(collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_Reduce, 1)
  end
end

function bs_101003:OnCollisionExit(collider, entity)
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier(self.config.buffId_Reduce) >= 1 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_Reduce, 1)
  end
end

function bs_101003:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_101003:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_101003:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_101003:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_101003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101003
