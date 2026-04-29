_class("TrapConfigData", Object)
TrapConfigData = TrapConfigData

function TrapConfigData:Constructor()
end

function TrapConfigData:GetTrapArea(trapID)
  local trapConfig = Cfg.cfg_trap[trapID]
  local areaStrArray = trapConfig.Area
  return self:ExplainTrapArea(areaStrArray)
end

function TrapConfigData:GetTrapData(trapID)
  local trapData = Cfg.cfg_trap[trapID]
  if trapData == nil then
    Log.error("TrapConfigData:GetTrapConfigData error ", trapID)
  end
  return trapData
end

function TrapConfigData:GetTrapList()
  local listConfig = Cfg.cfg_trap()
  local listReturn = {}
  for key, value in pairs(listConfig) do
    table.insert(listReturn, key)
  end
  return listReturn
end

function TrapConfigData:GetTrapListByGroupID(nGroupID)
  local listConfig = Cfg.cfg_trap()
  local listReturn = {}
  for key, value in pairs(listConfig) do
    if nGroupID == value.GroupID then
      table.insert(listReturn, value)
    end
  end
  return listReturn
end

function TrapConfigData:GetTrapResPath(trapID)
  local trapData = self:GetTrapData(trapID)
  if nil == trapData then
    return
  end
  return trapData.ResPath
end

function TrapConfigData:GetTrapAISkillIDs(trapID)
  local trapData = self:GetTrapData(trapID)
  if nil == trapData then
    return {}
  end
  local tidSkill = {}
  local tAI = trapData.AIID
  if not tAI or #tAI == 0 then
    return {}
  end
  for _, id in ipairs(tAI) do
    if Cfg.cfg_ai[id] then
      local cfgAIData = Cfg.cfg_ai[id]
      table.appendArray(tidSkill, cfgAIData.SkillList)
    end
  end
  return tidSkill
end

function TrapConfigData:ExplainTrapArea(stArea)
  local areaPosArray = {}
  local areaStrArray = stArea
  if #areaStrArray == 1 then
    local posStr = areaStrArray[1]
    local numStr = string.split(posStr, ",")
    local vec2 = Vector2(tonumber(numStr[1]), tonumber(numStr[2]))
    areaPosArray[#areaPosArray + 1] = vec2
  else
    for index = 1, #areaStrArray do
      local posStr = areaStrArray[index]
      local numStr = string.split(posStr, ",")
      local vec2 = Vector2(tonumber(numStr[1]), tonumber(numStr[2]))
      areaPosArray[#areaPosArray + 1] = vec2
    end
  end
  return areaPosArray
end

function TrapConfigData:GetSkillIDs(trapID)
  local trapData = self:GetTrapData(trapID)
  if nil == trapData then
    return
  end
  local trapDataSkillID = trapData.SkillID
  if not trapDataSkillID then
    return
  end
  local result = {}
  self:GetSkillID(trapDataSkillID, result, "Trigger")
  self:GetSkillID(trapDataSkillID, result, "Appear")
  self:GetSkillID(trapDataSkillID, result, "Disappear")
  self:GetSkillID(trapDataSkillID, result, "Die")
  self:GetSkillID(trapDataSkillID, result, "Hit")
  self:GetSkillID(trapDataSkillID, result, "Hide")
  self:GetSkillID(trapDataSkillID, result, "Show")
  self:GetSkillID(trapDataSkillID, result, "Active")
  self:GetSkillID(trapDataSkillID, result, "Victory")
  self:GetSkillID(trapDataSkillID, result, "Warning")
  self:GetSkillID(trapDataSkillID, result, "Move")
  if trapData.TriggerByRace then
    for _, t in ipairs(trapData.TriggerByRace) do
      table.insert(result, t.SkillID)
    end
  end
  return result
end

function TrapConfigData:GetSkillID(trapDataSkillID, result, name)
  local skillID = trapDataSkillID[name]
  if skillID then
    if type(skillID) == "table" then
      table.appendArray(result, skillID)
    else
      table.insert(result, skillID)
    end
  end
end

function TrapConfigData:GetTrapShaderEffect(trapID)
  local trapData = self:GetTrapData(trapID)
  if nil == trapData then
    return
  end
  return trapData.ShaderEffect
end

function TrapConfigData:GetTrapInnerDesc(trapID)
  local trapData = self:GetTrapData(trapID)
  if nil == trapData then
    return nil
  end
  return trapData.InnerDesc
end

function TrapConfigData:GetTrapName(trapID)
  local trapData = self:GetTrapData(trapID)
  if nil == trapData then
    return nil
  end
  return trapData.NameStr
end

function TrapConfigData:IsShowDescTips(trapID)
  local trapData = self:GetTrapData(trapID)
  if nil == trapData then
    return nil
  end
  return trapData.ShowDescTips == 1
end

function TrapConfigData:GetStoryTipsOffset(trapID)
  local trapData = self:GetTrapData(trapID)
  if nil == trapData then
    return nil
  end
  return trapData.TipsOffset
end

function TrapConfigData:GetTransferTrapIDs(trapID)
  local trapData = self:GetTrapData(trapID)
  if nil == trapData then
    return nil
  end
  return trapData.TransferTrapIDs
end
