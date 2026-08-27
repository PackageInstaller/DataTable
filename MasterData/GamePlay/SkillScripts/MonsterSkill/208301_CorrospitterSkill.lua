local bs_208301 = class("bs_208301", LuaSkillBase)
local base = LuaSkillBase
bs_208301.config = {
  skill_time = 33,
  start_time = 19,
  actionId = 1002,
  act_speed = 1,
  buffID_gongSu = 208301,
  buffID_yiSu = 208302,
  effectId_grid = 208301,
  effectId_grid1 = 208304,
  effectId_dandao = 208306,
  aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  }
}

function bs_208301:ctor()
end

function bs_208301:InitSkill(isMidwaySkill)
end

function bs_208301:PlaySkill(data)
  local realgrid = LuaSkillCtrl:CallFindGridMostRolesArounded(1)
  if realgrid ~= nil then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self:CallCasterWait(self.config.skill_time)
    local skillTrigger = BindCallback(self, self.OnSkillTrigger, realgrid)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.act_speed, self.config.start_time, skillTrigger)
  end
end

function bs_208301:OnSkillTrigger(realgrid)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_dandao, self)
  local grid = LuaSkillCtrl:GetTargetWithGrid(realgrid.x, realgrid.y)
  LuaSkillCtrl:CallEffect(grid, self.config.effectId_grid1, self)
  local effect = LuaSkillCtrl:CallEffect(grid, self.config.effectId_grid, self)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, grid, self.config.aoe)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
    self.arglist[1]
  })
  skillResult:EndResult()
  LuaSkillCtrl:StartTimer(nil, self.arglist[2], function(effecObj)
    if effecObj ~= nil then
      effecObj:Die()
      effecObj = nil
    end
  end, effect)
end

function bs_208301:OnCollisionEnter(collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffID_gongSu, 1)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffID_yiSu, 1)
  end
end

function bs_208301:OnCollisionExit(collider, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffID_gongSu, 1)
    LuaSkillCtrl:DispelBuff(entity, self.config.buffID_yiSu, 1)
  end
end

function bs_208301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208301
