_class("CutsceneInstructionParam", Object)
CutsceneInstructionParam = CutsceneInstructionParam

function CutsceneInstructionParam:Constructor(t)
  self._instructionSet = self:_ParseInstructionSet(t)
end

function CutsceneInstructionParam:GetInstructionSet()
  return self._instructionSet
end

function CutsceneInstructionParam:GetCacheTable()
  local t = {}
  for _, v in ipairs(self._instructionSet) do
    local insObj = v
    local resourceTable = insObj:GetCacheResource()
    if resourceTable then
      for _, res in pairs(resourceTable) do
        table.insert(t, res)
      end
    end
  end
  return t
end

function CutsceneInstructionParam:GetSoundCacheTable()
  local t = {}
  for _, v in ipairs(self._instructionSet) do
    local insObj = v
    local resourceTable = insObj:GetCacheAudio()
    if resourceTable then
      for _, res in pairs(resourceTable) do
        table.insert(t, res)
      end
    end
  end
  return t
end

function CutsceneInstructionParam:GetVoiceCacheTable()
  local t = {}
  for _, v in ipairs(self._instructionSet) do
    local insObj = v
    local resourceTable = insObj:GetCacheVoice()
    if resourceTable then
      for _, res in pairs(resourceTable) do
        table.insert(t, res)
      end
    end
  end
  return t
end

function CutsceneInstructionParam:_ParseInstructionSet(t)
  local instructionSet = {}
  local paramString = t[1]
  local phaseInsArray = string.split(paramString, ";")
  for k, v in ipairs(phaseInsArray) do
    if 1 < string.len(v) then
      local instruction = string.split(v, ",")
      if table.count(instruction) > 0 then
        local instructionType, paramList = self:_ParseInstructionParam(instruction)
        local instructionObj = self:_CreateInstruction(instructionType, paramList)
        instructionSet[#instructionSet + 1] = instructionObj
      end
    end
  end
  return instructionSet
end

function CutsceneInstructionParam:_CreateInstruction(instructionType, paramList)
  local insObject
  local insClassName = instructionType .. "Instruction"
  local insClass = Classes[insClassName]
  if insClass == nil then
    Log.fatal("Can not create instruction:", insClassName)
  else
    insObject = insClass:New(paramList)
  end
  return insObject
end

function CutsceneInstructionParam:_ParseInstructionParam(insArray)
  local instructionType
  local paramList = {}
  for k, v in ipairs(insArray) do
    if k == 1 then
      instructionType = string.gsub(v, "^%s*(.-)%s*$", "%1")
    else
      local paramArray = string.split(v, "=")
      if table.count(paramArray) >= 2 then
        local paramName = string.gsub(paramArray[1], "^%s*(.-)%s*$", "%1")
        local paramValue = string.gsub(paramArray[2], "^%s*(.-)%s*$", "%1")
        paramList[paramName] = paramValue
      end
    end
  end
  return instructionType, paramList
end
