local bs_108003 = class("bs_108003", LuaSkillBase)
local base = LuaSkillBase
bs_108003.config = {
  actionId_start = 1005,
  actionId_end = 1006,
  effectId_ground = 108013,
  effectId_start = 108012,
  effectId_Trail = 108014,
  effectId_end = 108016,
  buffSpeed = 108005,
  buffXm = 108006,
  buffXm2 = 108008,
  buffGround = 108009,
  aoe_config = {
    effect_shape = 2,
    aoe_select_code = 4,
    aoe_range = 2
  },
  configId = 25,
  audioIdStart = 108011,
  audioIdMovie = 108012,
  audioIdEnd = 108013
}

function bs_108003:ctor()
end

function bs_108003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.hurtArgs = {}
end

function bs_108003:PlaySkill(data, selectTargetCoord, selectRoles, selectRolesType)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(targetGrid)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
    self:CallCasterWait(5)
    LuaSkillCtrl:CallEffectWithArg(targetGrid, self.config.effectId_Trail, self, nil, nil, self.SkillEventFunc, targetGrid)
  end
end

function bs_108003:SkillEventFunc(targetGrid, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 0.3, 0.6, 50)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetGrid, self.config.aoe_config)
    local args = LuaSkillCtrl:CreatCacheTable(self.arglist[1], self.hurtArgs)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, args)
    skillResult:EndResult()
    local effect = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_ground, self)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 200, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
    LuaSkillCtrl:StartTimer(nil, self.arglist[3], function()
      if effect ~= nil then
        LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_end, self)
        effect:Die()
        effect = nil
      end
    end)
  end
end

function bs_108003:OnCollisionEnter(collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == eBattleRoleBelong.enemy and not LuaSkillCtrl:IsFixedObstacle(entity) then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffXm2, 1)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffGround, 1)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffSpeed, 1)
  end
end

function bs_108003:OnCollisionExit(collider, entity)
  if entity ~= nil and entity.hp > 0 then
    if 0 < entity:GetBuffTier(self.config.buffGround) then
      LuaSkillCtrl:DispelBuff(entity, self.config.buffGround, 1)
    end
    if 0 < entity:GetBuffTier(self.config.buffXm2) and entity:GetBuffTier(self.config.buffGround) == 0 then
      LuaSkillCtrl:DispelBuff(entity, self.config.buffXm2, 0)
    end
    if 0 < entity:GetBuffTier(self.config.buffSpeed) and entity:GetBuffTier(self.config.buffGround) == 0 then
      LuaSkillCtrl:DispelBuff(entity, self.config.buffSpeed, 0)
    end
  end
end

function bs_108003:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108003:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_108003:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_108003:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_108003:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108003:LuaDispose()
  base.LuaDispose(self)
  self.hurtArgs = nil
end

return bs_108003
