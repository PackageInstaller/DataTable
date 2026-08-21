_class("ResourceHelper", Singleton)
ResourceHelper = ResourceHelper

function ResourceHelper:Constructor()
  self._PetSKill = nil
  self._StoryAffinity = nil
  self._PetEquip = nil
end

function ResourceHelper:GetPetSKill()
  if not self._PetSKill then
    self._PetSKill = ResPetSkill:New()
  end
  return self._PetSKill
end

function ResourceHelper:GetStoryAffinity()
  if not self._StoryAffinity then
    self._StoryAffinity = ResStoryAffinity:New()
  end
  return self._StoryAffinity
end

function ResourceHelper:GetPetEquip()
  if not self._PetEquip then
    self._PetEquip = ResPetEquip:New()
  end
  return self._PetEquip
end

function ResourceHelper:GetPetEquipRefine()
  if not self._PetEquipRefine then
    self._PetEquipRefine = ResPetEquipRefine:New()
  end
  return self._PetEquipRefine
end

_class("CfgTermEntity", Object)
CfgTermEntity = CfgTermEntity

function CfgTermEntity:Constructor()
  self.cfg_conds = {}
  self.comp_type = TCType_None
  self.dataInfo = {}
end

function ResourceHelper:CheckTermSatisfy(strCond, cfgTerm, cb)
  if self:ParseCondConfig(strCond, cfgTerm) == false then
    return false
  end
  return self:CheckSatisfy(cfgTerm, cb)
end

local TCType_None = 0
local TCType_All = 1
local TCType_Any = 2

function ResourceHelper:ParseCondConfig(strCond, cfgTerm)
  local sub_children = {}
  local composite_type = TCType_None
  local l_parse_ret, l_ret_str, composite_type = self:ParseCond(strCond, sub_children, composite_type, 1)
  if not l_parse_ret then
    Log.fatal("ResourceHelper:ParseCondConfig error:", strCond, "____", l_ret_str)
    return false
  end
  cfgTerm.comp_type = composite_type
  if 1 < #sub_children then
    for i = 1, #sub_children do
      local cfgSub = _createInstance(cfgTerm._className)
      local l_ret = self:ParseCondConfig(sub_children[i], cfgSub)
      if l_ret ~= true then
        return false
      end
      table.insert(cfgTerm.cfg_conds, cfgSub)
    end
  elseif #sub_children == 1 then
    local spstrs = string.split(sub_children[1], ",")
    for pi = 1, #spstrs do
      cfgTerm.dataInfo[pi] = tonumber(spstrs[pi])
    end
  else
    return false
  end
  return true
end

function ResourceHelper:ParseCond(strCond, cond_list, composite_type, find_start)
  local b = string.find(strCond, "%(", find_start, false)
  if b == nil then
    local str = string.sub(strCond, find_start)
    local and_list = string.split(strCond, "&")
    local or_list = string.split(strCond, "|")
    and_list = and_list or {}
    or_list = or_list or {}
    if 1 < #and_list and 1 < #or_list then
      return false, "逻辑连接符不一致", composite_type
    end
    if #and_list <= 1 and #or_list <= 1 then
      if composite_type ~= TCType_None then
        return false, "带括号和不带括号的子条件混用", composite_type
      else
        cond_list[#cond_list + 1] = str
        return true, "ok", composite_type
      end
    end
    if 1 < #and_list then
      if composite_type == TCType_Any then
        return false, "逻辑连接符不一致", composite_type
      end
      composite_type = TCType_All
    else
      if composite_type == TCType_All then
        return false, "逻辑连接符不一致", composite_type
      end
      composite_type = TCType_Any
    end
    local str_list = composite_type == TCType_All and and_list or or_list
    for i = 1, #str_list do
      cond_list[#cond_list + 1] = str_list[i]
    end
    return true, "ok", composite_type
  end
  local e = self:FindBracketEnd(strCond, b + 1)
  if e == nil then
    return false, "括号不匹配", composite_type
  end
  cond_list[#cond_list + 1] = string.sub(strCond, b + 1, e - 1)
  local and_pos = string.find(strCond, "&", e + 1, false)
  local or_pos = string.find(strCond, "|", e + 1, false)
  if and_pos == nil and or_pos == nil then
    return true, "ok", composite_type
  end
  if and_pos ~= nil and (or_pos == nil or and_pos < or_pos) then
    if composite_type == TCType_Any then
      return false, "逻辑连接符不一致", composite_type
    end
    composite_type = TCType_All
    return self:ParseCond(strCond, cond_list, composite_type, and_pos + 1)
  end
  if or_pos ~= nil then
    if composite_type == TCType_All then
      return false, "逻辑连接符不一致", composite_type
    end
    composite_type = TCType_Any
    return self:ParseCond(strCond, cond_list, composite_type, or_pos + 1)
  end
  return false, "条件配置错误请检查", composite_type
end

function ResourceHelper:FindBracketEnd(strCond, find_start)
  local b = string.find(strCond, "%(", find_start, false)
  local e = string.find(strCond, ")", find_start, false)
  if e == nil then
    return nil
  end
  if b == nil or b > e then
    return e
  end
  local sub_e = self:FindBracketEnd(strCond, b + 1)
  if sub_e == nil then
    return nil
  end
  return self:FindBracketEnd(strCond, sub_e + 1)
end

function ResourceHelper:CheckSatisfy(cfgTerm, cb)
  if cfgTerm.comp_type == TCType_All then
    for k, v in pairs(cfgTerm.cfg_conds) do
      if self:CheckSatisfy(v, cb) == false then
        return false
      end
    end
    return true
  elseif cfgTerm.comp_type == TCType_Any then
    for k, v in pairs(cfgTerm.cfg_conds) do
      if self:CheckSatisfy(v, cb) == true then
        return true
      end
    end
    return false
  elseif cfgTerm.comp_type == TCType_None then
    return cb(cfgTerm.dataInfo, cb)
  end
  return false
end
