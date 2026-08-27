local bs_104403 = class("bs_104403", LuaSkillBase)
local base = LuaSkillBase
bs_104403.config = {
  effectId_ZD = 104410,
  effectTime = 10,
  effectId_Loop = 104412,
  buffId = 104401,
  configId = 3,
  aoe_config = {
    effect_shape = 2,
    aoe_select_code = 4,
    aoe_range = 1
  },
  audioIdStart = 104410,
  audioIdMovie = 104411,
  audioIdEnd = 104412
}

function bs_104403:ctor()
end

function bs_104403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_104403_2", 99, self.OnSetHurt, nil, nil, self.caster.belongNum)
end

function bs_104403:PlaySkill(data, selectTargetCoord, selectRolesdata)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(targetGrid)
    self:CallCasterWait(5)
    LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_ZD, self)
    LuaSkillCtrl:StartTimer(nil, self.config.effectTime, function()
      if targetGrid ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetGrid, self.config.aoe_config)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
          self.arglist[1]
        })
        skillResult:EndResult()
        local effect = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_Loop, self)
        local collisionEnter = BindCallback(self, self.OnCollisionEnter)
        local collisionExit = BindCallback(self, self.OnCollisionExit)
        LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
        LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
          if effect ~= nil then
            effect:Die()
            effect = nil
          end
        end)
      end
    end)
  end
end

function bs_104403:OnCollisionEnter(collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= self.caster.belongNum and not LuaSkillCtrl:IsFixedObstacle(entity) then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId, 1)
  end
end

function bs_104403:OnCollisionExit(collider, entity)
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier(self.config.buffId) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId, 1)
  end
end

function bs_104403:OnSetHurt(context)
  if context.target.belongNum ~= self.caster.belongNum and context.target ~= self.caster and context.hurt > 0 and context.isTriggerSet ~= true and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and 0 < context.target:GetBuffTier(self.config.buffId) then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[3]
    }, true)
    skillResult:EndResult()
  end
end

function bs_104403:PlayUltEffect(data, selectTargetCoord, selectRoles)
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_104403:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 0.55)
end

function bs_104403:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_104403:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_104403:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104403:LuaDispose()
  base.LuaDispose(self)
end

return bs_104403
