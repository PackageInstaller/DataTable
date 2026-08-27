local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local DynSpecEffectMgr = class("DynSpecEffectMgr")

local function GetChipCounterTab()
  local map = {count = 0}
  local c = ConfigData.game_config.heroMaxCareer
  for i = 1, c do
    map[i] = 0
  end
  return map
end

local LogicAddFunc = {
  [proto_object_EffectType.EffectType_CareerChange] = function(self, effect)
    local dic = self._chipActiveCareer[effect.value2]
    if dic == nil then
      dic = GetChipCounterTab()
      self._chipActiveCareer[effect.value2] = dic
    end
    dic[effect.value1] = dic[effect.value1] + 1
    dic.count = dic.count + 1
  end,
  [proto_object_EffectType.EffectType_OnlyCareerChange] = function(self, effect)
    local dic = self._chipActiveCareer[effect.value2]
    if dic == nil then
      dic = GetChipCounterTab()
      self._chipActiveCareer[effect.value2] = dic
    end
    dic[effect.value1] = dic[effect.value1] + 1
    dic.count = dic.count + 1
    local list = self._chipOnlyCareer[effect.value1]
    if list == nil then
      list = {}
      self._chipOnlyCareer[effect.value1] = list
    end
    table.insert(list, 1, effect.value2)
    if 1 < #list then
      error("add effect OnlyCareerChang exceed 1,new effect Id:" .. tostring(effect.effectId))
      table.sort(list)
    end
  end
}
local LogicRemoveFunc = {
  [proto_object_EffectType.EffectType_CareerChange] = function(self, effect)
    local dic = self._chipActiveCareer[effect.value2]
    if dic == nil then
      return
    end
    dic[effect.value1] = dic[effect.value1] - 1
    dic.count = dic.count - 1
  end,
  [proto_object_EffectType.EffectType_OnlyCareerChange] = function(self, effect)
    local dic = self._chipActiveCareer[effect.value2]
    if dic == nil then
      return
    end
    dic[effect.value1] = dic[effect.value1] - 1
    dic.count = dic.count - 1
    local list = self._chipOnlyCareer[effect.value1]
    if list ~= nil then
      table.removebyvalue(list, effect.value2, false)
      if #list <= 0 then
        self._chipOnlyCareer[effect.value1] = nil
      end
    end
  end
}
local chipInfluenceFunc = {}

function DynSpecEffectMgr:ctor()
  self._effets = {}
  self._count = 0
  self._chipActiveCareer = {}
  self._chipOnlyCareer = {}
end

function DynSpecEffectMgr:InitSpecEffect(effect)
  if effect == nil then
    return
  end
  for id, effect in pairs(effect.effects) do
    self._effets[id] = effect
    self._count = self._count + 1
    LogicAddFunc[effect.effectType](self, effect)
  end
end

function DynSpecEffectMgr:UpdateSpecEffectDiff(diff)
  if diff == nil then
    return
  end
  for _, id in pairs(diff.removed) do
    local effect = self._effets[id]
    if effect ~= nil then
      self._effets[id] = nil
      self._count = self._count - 1
      LogicRemoveFunc[effect.effectType](self, effect)
    end
  end
  for id, effect in pairs(diff.added) do
    if self._effets[id] == nil then
      self._effets[id] = effect
      self._count = self._count + 1
      LogicAddFunc[effect.effectType](self, effect)
    end
  end
end

function DynSpecEffectMgr:HasSpecEffectCount()
  return self._count > 0
end

function DynSpecEffectMgr:ModifyChipValidRole(roleList, validRoleDic, influenceType, influenceArg)
  local func = chipInfluenceFunc[influenceType]
  if func ~= nil then
    func(self, roleList, validRoleDic, influenceArg)
    return true
  end
  return false
end

function DynSpecEffectMgr:_ChipCareerInfluence(roleList, validRoleDic, influenceArg)
  local activeDic = self._chipActiveCareer[influenceArg]
  for k, role in ipairs(roleList) do
    local career = role:GetCareer()
    local careerTrans = self._chipOnlyCareer[career]
    if careerTrans ~= nil then
      if careerTrans[1] == influenceArg then
        validRoleDic[role] = true
      end
    elseif career == influenceArg or activeDic ~= nil and 0 < activeDic[career] then
      validRoleDic[role] = true
    end
  end
end

chipInfluenceFunc[ChipEnum.eChipInfluenceType.Career] = DynSpecEffectMgr._ChipCareerInfluence
return DynSpecEffectMgr
