local LuaGridBase = class("LuaGridBase")

function LuaGridBase:ctor()
end

function LuaGridBase:__InitGridInternal(cEffectGrid, x, y)
  self.x = x
  self.y = y
  self.cEffectGrid = cEffectGrid
end

function LuaGridBase:__OnGridBattleStartInit(role)
  self.isOnBattleInit = true
  self:__OnGridSkillInit()
  self:OnGridBattleStart(role)
end

function LuaGridBase:__OnGridSkillInit()
  self.cskill = self.cEffectGrid.battleSkill
  self.caster = self.cskill.maker
  if not self.isOnBattleInit then
    local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
    if role ~= nil then
      self:OnGridEnterRole(role)
    end
  end
end

function LuaGridBase:OnGridBattleStart(role)
end

function LuaGridBase:OnGridEnterRole(role)
end

function LuaGridBase:OnGridExitRole(role)
end

function LuaGridBase:OnGridRoleDead(role)
end

function LuaGridBase:OnGridReachTimeLimit(role, isCorved)
end

function LuaGridBase:OnGridBeCorvered(role, coverGrid)
end

function LuaGridBase:OnGridUncorver(role)
end

function LuaGridBase:GridLoseEffect()
  if self.cEffectGrid == nil then
    return
  end
  self.cEffectGrid:GridLoseEffect()
end

function LuaGridBase:OnGridBattleEnd(role)
end

function LuaGridBase:GetHurtResultConfig(configId)
  if self.hurtResultConfig == nil then
    self.hurtResultConfig = {}
  end
  if self.hurtResultConfig[configId] == nil then
    local config = ConfigData.battle_skill_hurt_result_config[configId]
    if config == nil then
      warn("找不到对应的技能伤害配置:" .. tostring(configId))
      config = generalHurtConfig
    end
    self.hurtResultConfig[configId] = self:__GetTempHurtConfig(config)
  end
  return self.hurtResultConfig[configId]
end

function LuaGridBase:__GetTempHurtConfig(config)
  local tempConfig = {}
  for _, v in ipairs(ConfigData.battle_skill_hurt_result_config.formulaTypes) do
    tempConfig[v] = config[v]
  end
  return tempConfig
end

function LuaGridBase:AddGridTrigger(triggerType, name, priority, eventFunc)
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTrigger(triggerType, self.cEffectGrid, eTriggerSkillType.GridSkill, name, priority, bindFunc, false)
end

function LuaGridBase:RemoveGridTrigger(triggerType)
  LuaSkillCtrl:RemoveTrigger(self.cEffectGrid, triggerType)
end

function LuaGridBase:LuaDispose()
  self.cskill = nil
  self.caster = nil
  self.cEffectGrid = nil
end

return LuaGridBase
