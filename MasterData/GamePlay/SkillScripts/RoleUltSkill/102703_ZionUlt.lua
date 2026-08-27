local bs_102703 = class("bs_102703", LuaSkillBase)
local base = LuaSkillBase
bs_102703.config = {
  effectId_loop = 1027031,
  effectId_break = 1027032,
  effectId_line = 1027033,
  effectId_hit = 10380,
  effectId_sheild = 1027034,
  effectId_sheildBreak = 1027035,
  effectId_speed = 1,
  actionId_start = 1005,
  actionId_Loop = 1010,
  audioIdStart = 102705,
  audioIdMovie = 102701,
  audioIdEnd = 102702,
  audioIdBoom = 102704,
  audioIdLoop = 102703,
  start_time = 5,
  buffId_protect = 1027031,
  buffId_defence = 1027032,
  buffId_sheild = 1027033,
  select_id = 9,
  select_range = 20,
  realDamage = {
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  aoe_Config = {
    effect_shape = 2,
    aoe_select_code = 4,
    aoe_range = 10
  }
}

function bs_102703:ctor()
end

function bs_102703:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_102703_2", 1, self.OnBuffDie)
  self:AddTrigger(eSkillTriggerType.HurtResultStart, "bs_102703_3", 2, self.OnHurtResultStart)
  self:AddAfterHurtTrigger("bs_102703_1", 1, self.OnAfterHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_102703_4", 1, self.OnAfterShieldHurt)
  self.totalDamage = 0
end

function bs_102703:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20 + self.arglist[2])
  LuaSkillCtrl:CallBattleCamShake()
  self:CallSkillExecute()
end

function bs_102703:CallSkillExecute()
  local zionUlt = self.caster:GetBuffTier(self.config.buffId_defence)
  if 0 < zionUlt then
    self:EndAoeHurt()
  end
  local CallDefenseField = BindCallback(self, self.CallDefenseField)
  local skillTime = self.config.start_time + self.arglist[2]
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, skillTime, true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, 1, self.config.start_time, CallDefenseField)
end

function bs_102703:CallDefenseField()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_defence, 1, self.arglist[2], true)
  local sheild = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, sheild)
  self:CallCasterWait(self.arglist[2])
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  if self.fieldeffect ~= nil then
    self.fieldeffect:Die()
    self.fieldeffect = nil
  end
  self.fieldeffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
  self.protectfield = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 175, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_102703:OnCollisionEnter(collider, index, entity)
  if entity:GetBuffTier(self.config.buffId_protect) < 1 and entity ~= self.caster and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.roleType == 1 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_protect, 1)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_sheild, 1)
  end
end

function bs_102703:OnCollisionExit(collider, entity)
  if entity:GetBuffTier(self.config.buffId_protect) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_protect, 0)
  end
  if 1 <= entity:GetBuffTier(self.config.buffId_sheild) then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId_sheild, 0)
  end
end

function bs_102703:OnHurtResultStart(skill, context)
  local zionUlt = context.target:GetBuffTier(self.config.buffId_defence)
  if context.target ~= self.caster then
    local isprotected = context.target:GetBuffTier(self.config.buffId_protect)
    if isprotected <= 0 or isprotected == nil then
      return
    end
    if 0 < isprotected and 0 < context.target.hp and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 then
      context.target = self.caster
    end
  end
end

function bs_102703:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local zionUlt = target:GetBuffTier(self.config.buffId_defence)
  if sender.belongNum == self.caster.belongNum then
    return
  end
  if 0 < zionUlt then
    self.totalDamage = self.totalDamage + hurt
  end
end

function bs_102703:OnAfterShieldHurt(context)
  local zionUlt = context.target:GetBuffTier(self.config.buffId_defence)
  if context.sender.belongNum == self.caster.belongNum then
    return
  end
  if 0 < zionUlt then
    self.totalDamage = self.totalDamage + context.shield_cost_hurt
  end
end

function bs_102703:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_defence and target == self.caster then
    self:EndAoeHurt()
  end
end

function bs_102703:EndAoeHurt()
  local zionUlt = self.caster:GetBuffTier(self.config.buffId_defence)
  if zionUlt < 1 then
    return
  end
  local realHurt = self.totalDamage * self.arglist[3] // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe_Config)
  if skillResult.roleList.Count <= 0 then
    return
  end
  for i = 0, skillResult.roleList.Count - 1 do
    local target = skillResult.roleList[i]
    if target ~= nil and 0 < target.hp then
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioIdBoom)
      LuaSkillCtrl:CallRealDamage(self, target, nil, self.config.realDamage, {realHurt}, true)
    end
  end
  skillResult:EndResult()
  if self.fieldeffect ~= nil then
    self.fieldeffect:Die()
    self.fieldeffect = nil
  end
  if self.protectfield ~= nil and self.protectfield.collider ~= nil then
    LuaSkillCtrl:ClearColliderOrEmission(self.protectfield.collider)
    self.protectfield = nil
  end
  self.totalDamage = 0
  self:CancleCasterWait()
end

function bs_102703:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15 + self.arglist[2], true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_102703:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_102703:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_102703:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_102703:OnCasterDie()
  self:EndAoeHurt()
  base.OnCasterDie(self)
end

function bs_102703:LuaDispose()
  base.LuaDispose(self)
  self.fieldeffect = nil
  self.protectfield = nil
end

return bs_102703
