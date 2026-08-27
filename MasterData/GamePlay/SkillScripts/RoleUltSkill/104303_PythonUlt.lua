local bs_104303 = class("bs_104303", LuaSkillBase)
local base = LuaSkillBase
bs_104303.config = {
  buff_unselected = 104306,
  buff_vulnerable = 104308,
  buff_Strong = 104307,
  buffId_151 = 3007,
  effectId_ZD = 104306,
  effectId_Smoke = 104305,
  actionId = 1006,
  action_speed = 1,
  start_time = 8,
  audioIdStart = 104309,
  audioIdMovie = 104310,
  audioIdEnd = 104311
}

function bs_104303:ctor()
end

function bs_104303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104303:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(targetGrid)
    local attackTrigger = BindCallback(self, self.UltSkill, targetGrid)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
end

function bs_104303:UltSkill(targetGrid)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_Strong, 1, self.arglist[3], true)
  LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_ZD, self)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:StartTimer(nil, 10, function()
    local EnemyList = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
    for i = 0, EnemyList.Count - 1 do
      if EnemyList[i] ~= nil and 0 < EnemyList[i].hp and 0 < EnemyList[i].intensity and LuaSkillCtrl:CheckReletionWithRoleBelong(self.caster, EnemyList[i], eBelongReletionType.Enemy) then
        LuaSkillCtrl:CallBuff(self, EnemyList[i], self.config.buffId_151, 1, 3, true)
      end
    end
    local effect = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_Smoke, self)
    LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Player, nil, collisionEnter, collisionExit)
    LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
      if effect ~= nil then
        effect:Die()
        effect = nil
      end
    end)
  end)
end

function bs_104303:OnCollisionEnter(collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buff_unselected, 1, self.arglist[1], true)
    if 1 < entity.attackRange then
      LuaSkillCtrl:CallBuff(self, entity, self.config.buff_vulnerable, 1, self.arglist[1], true)
    end
  end
end

function bs_104303:OnCollisionExit(collider, entity)
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier(self.config.buff_unselected) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buff_unselected, 1)
    if 1 <= entity:GetBuffTier(self.config.buff_vulnerable) then
      LuaSkillCtrl:DispelBuff(entity, self.config.buff_vulnerable, 1)
    end
  end
end

function bs_104303:PlayUltEffect(data, selectTargetCoord, selectRoles)
  if selectRoles == nil or selectRoles.Count <= 0 then
    return true
  end
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_104303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 0.55)
end

function bs_104303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_104303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_104303:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104303:LuaDispose()
  base.LuaDispose(self)
end

return bs_104303
