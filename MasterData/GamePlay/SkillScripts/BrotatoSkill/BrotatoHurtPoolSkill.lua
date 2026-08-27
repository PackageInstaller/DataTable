local BrotatoHurtPoolSkill = class("BrotatoHurtPoolSkill", LuaSkillBase)
local base = LuaSkillBase
BrotatoHurtPoolSkill.config = {
  range = 50,
  range2 = 60,
  buffId1 = 2097,
  buffTier1 = 1,
  buffId2 = 2098,
  buffTier2 = 1,
  buffId3 = 2099,
  buffTier3 = 1,
  buffId4 = 2100
}
BrotatoHurtPoolSkill.hurPoolConfigs = {
  [1] = {
    effectId = 60603,
    effectId2 = 60622,
    duration = 75,
    duration2 = 150,
    skillId = 70042
  },
  [2] = {
    effectId = 60605,
    effectId2 = 60624,
    duration = 75,
    duration2 = 150,
    skillId = 70043,
    hurt_config = {
      hit_formula = 0,
      basehurt_formula = 502,
      crit_formula = 0
    }
  },
  [3] = {
    effectId = 60601,
    effectId2 = 60620,
    duration = 75,
    duration2 = 150,
    skillId = 70044
  }
}

function BrotatoHurtPoolSkill:ctor()
end

function BrotatoHurtPoolSkill:InitSkill(isMidwaySkill)
  self.hurtPoolDic = {}
  self:AddLuaTrigger(eSkillLuaTrigger.CallHurtPool, self.CallHurtPool)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "BrotatoHurtPoolSkill_1", 1, self.OnAfterBattleStart)
end

function BrotatoHurtPoolSkill:OnAfterBattleStart()
  self.updateTimer = LuaSkillCtrl:StartTimer(nil, 1, BindCallback(self, self.OnUpdate), nil, -1)
  for k, v in pairs(self.hurPoolConfigs) do
    v.battleSkill = LuaSkillCtrl:CallNewSkill(v.skillId, 1, CS.BattleSkillType.Chip)
    self.caster:AddBattleSkill(v.battleSkill)
  end
end

function BrotatoHurtPoolSkill:OnUpdate()
  for k1, v1 in pairs(self.hurtPoolDic) do
    local count = 0
    for k2, v2 in pairs(v1) do
      if v2.duration ~= nil then
        count = count + 1
        v2.duration = v2.duration - 1
        if 0 >= v2.duration then
          local effect = v2.effect
          if effect ~= nil then
            effect:Die()
            v2.effect = nil
          end
          v2 = nil
          v1[k2] = nil
          count = count - 1
        end
      end
    end
    if count == 0 then
      local collider = v1.collider
      if collider ~= nil then
        LuaSkillCtrl:ClearColliderOrEmission(collider)
        v1.collider = nil
      end
      v1 = nil
      self.hurtPoolDic[k1] = nil
    end
  end
end

function BrotatoHurtPoolSkill:CallHurtPool(luaSkill, typeId, posX, posY)
  local durationFix
  if self.caster.recordTable["25204_Flag"] then
    durationFix = self.caster.recordTable["25204_arg"]
  end
  local hurtPoolConfig = self.hurPoolConfigs[typeId]
  if hurtPoolConfig == nil then
    return
  end
  local posIndex = BattleUtil.XYCoord2Pos(posX, posY)
  local targetHurtPools = self.hurtPoolDic[posIndex]
  if targetHurtPools == nil then
    targetHurtPools = {}
    local grid = LuaSkillCtrl:GetGridWithPos(posX, posY)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter, posIndex, hurtPoolConfig.battleSkill)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    local colliderRange
    if self.caster.recordTable["25204_Flag"] == true then
      colliderRange = self.config.range2
    else
      colliderRange = self.config.range
    end
    local collider = LuaSkillCtrl:CallGetCircleSkillColliderByGrid(luaSkill, grid, colliderRange, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit)
    targetHurtPools.collider = collider
    self.hurtPoolDic[posIndex] = targetHurtPools
  end
  if targetHurtPools[typeId] ~= nil then
    local upDuration
    if self.caster.recordTable["25204_Flag"] == true and durationFix ~= nil then
      upDuration = hurtPoolConfig.duration * (1000 + durationFix) // 1000
    else
      upDuration = hurtPoolConfig.duration
    end
    targetHurtPools[typeId].duration = upDuration
  else
    local target = LuaSkillCtrl:GetTargetWithGrid(posX, posY)
    local effect
    if self.caster.recordTable["25204_Flag"] == true then
      effect = LuaSkillCtrl:CallEffect(target, hurtPoolConfig.effectId2, luaSkill)
    else
      effect = LuaSkillCtrl:CallEffect(target, hurtPoolConfig.effectId, luaSkill)
    end
    local upDuration
    if self.caster.recordTable["25204_Flag"] == true and durationFix ~= nil then
      upDuration = hurtPoolConfig.duration * (1000 + durationFix) // 1000
    else
      upDuration = hurtPoolConfig.duration
    end
    targetHurtPools[typeId] = {effect = effect, duration = upDuration}
  end
end

function BrotatoHurtPoolSkill:OnCollisionEnter(posIndex, csSkill, collider, index, entity)
  local targetHurtPools = self.hurtPoolDic[posIndex]
  if targetHurtPools == nil then
    return
  end
  for k, v in pairs(targetHurtPools) do
    if k == 1 then
      self:Icepool(entity, csSkill)
    elseif k == 2 then
      self:Firepool(entity, csSkill)
    elseif k == 3 then
      self:Drugpool(entity, csSkill)
    end
  end
end

function BrotatoHurtPoolSkill:OnCollisionExit(collider, entity)
  if entity ~= nil and entity:GetBuffTier(self.config.buffId4) > 0 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffId4, 0)
  end
end

function BrotatoHurtPoolSkill:Icepool(entity, luaSkill)
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId1, self.config.buffTier1, nil, false)
  if self.caster.recordTable["25206_Flag"] == true and self.caster.recordTable["25206_arg"] ~= nil then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId4, self.caster.recordTable["25206_arg"], nil, true)
  end
  if self.caster.recordTable["25202_Flag"] == true and self.caster.recordTable["25202_arg"] ~= nil and LuaSkillCtrl:CallRange(1, 1000) <= self.caster.recordTable["25202_arg"] then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId1, self.config.buffTier1, nil, false)
  end
end

function BrotatoHurtPoolSkill:Firepool(entity, csSkill)
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId2, self.config.buffTier2, 90, false)
  local skill_intensity = self.caster.recordTable["17016_arg"]
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(csSkill, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 3, {skill_intensity}, true, true)
  skillResult:EndResult()
  if self.caster.recordTable["25206_Flag"] == true and self.caster.recordTable["25206_arg"] ~= nil then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId4, self.caster.recordTable["25206_arg"], nil, true)
  end
  if self.caster.recordTable["25202_Flag"] == true and self.caster.recordTable["25202_arg"] ~= nil and LuaSkillCtrl:CallRange(1, 1000) <= self.caster.recordTable["25202_arg"] then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId2, self.config.buffTier2, 90, false)
  end
end

function BrotatoHurtPoolSkill:Drugpool(entity, luaSkill)
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId3, self.config.buffTier3, 30, false)
  if self.caster.recordTable["25206_Flag"] == true and self.caster.recordTable["25206_arg"] ~= nil then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId4, self.caster.recordTable["25206_arg"], nil, true)
  end
  if self.caster.recordTable["25202_Flag"] == true and self.caster.recordTable["25202_arg"] ~= nil and LuaSkillCtrl:CallRange(1, 1000) <= self.caster.recordTable["25202_arg"] then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId3, self.config.buffTier3, 30, false)
  end
end

function BrotatoHurtPoolSkill:OnCasterDie()
  base.OnCasterDie(self)
  for k1, v1 in pairs(self.hurtPoolDic) do
    local collider = v1.collider
    if collider ~= nil then
      LuaSkillCtrl:ClearColliderOrEmission(collider)
      v1.collider = nil
    end
  end
  self.hurtPoolDic = {}
  if self.updateTimer ~= nil then
    self.updateTimer:Stop()
    self.updateTimer = nil
  end
end

function BrotatoHurtPoolSkill:LuaDispose()
  base.LuaDispose(self)
  for k1, v1 in pairs(self.hurtPoolDic) do
    local collider = v1.collider
    if collider ~= nil then
      LuaSkillCtrl:ClearColliderOrEmission(collider)
      v1.collider = nil
    end
  end
  for i, v in pairs(self.hurPoolConfigs) do
    v.battleSkill = nil
  end
  self.hurtPoolDic = nil
  self.updateTimer = nil
  self.collisionEnterType1 = nil
  self.collisionEnterType2 = nil
end

return BrotatoHurtPoolSkill
