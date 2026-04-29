_class("CutsceneConfigData", Object)
CutsceneConfigData = CutsceneConfigData
CutscenePhaseType = {Instruction = 0}

function CutsceneConfigData:Constructor()
  self._phaseDataArray = {}
  self._viewParamDic = {}
  self._viewParamDic[CutscenePhaseType.Instruction] = CutsceneInstructionParam
end

function CutsceneConfigData:ParseCutsceneConfig(cutsceneID)
  self._phaseDataArray = {}
  local phaseRawDataArray = self:_GetPhaseRawDataArray(cutsceneID)
  local phaseCount = phaseRawDataArray and phaseRawDataArray:Size() or 0
  for i = 1, phaseCount do
    local phaseRawData = phaseRawDataArray:GetAt(i)
    local onePhaseData = self:_ParseOnePhaseRawData(phaseRawData)
    self._phaseDataArray[#self._phaseDataArray + 1] = onePhaseData
  end
  return self._phaseDataArray
end

function CutsceneConfigData:GetCutscenePhaseArray()
  return self._phaseDataArray
end

function CutsceneConfigData:_GetPhaseRawDataArray(cutsceneID)
  local rawDataArray = ArrayList:New()
  local cutsceneTableName = "cfg_cutscene_" .. cutsceneID
  local fileExist = ResourceManager:GetInstance():HasLua(cutsceneTableName)
  if not fileExist then
    Log.warn("cannot find cutscene:", cutsceneTableName)
    return nil
  end
  local cutsceneList = table.cloneconf(Cfg[cutsceneTableName]())
  table.sort(cutsceneList, function(a, b)
    return a.ViewPhase < b.ViewPhase
  end)
  for k, v in ipairs(cutsceneList) do
    rawDataArray:Insert(v, k)
  end
  return rawDataArray
end

function CutsceneConfigData:_ParseOnePhaseRawData(phaseRawData)
  if not phaseRawData then
    return
  end
  local phaseClass = self._viewParamDic[phaseRawData.PhaseType]
  if not phaseClass then
    Log.fatal("parse cutscene phase error, phase type = ", phaseRawData.PhaseType)
    return
  end
  local insParam = phaseClass:New(phaseRawData.PhaseParam)
  local phaseParam = CutscenePhaseParam:New(phaseRawData.DelayType, phaseRawData.DelayFromPhase, phaseRawData.DelayMS, insParam)
  return phaseParam
end
