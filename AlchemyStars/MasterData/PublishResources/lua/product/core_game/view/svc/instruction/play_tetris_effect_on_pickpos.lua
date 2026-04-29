require("base_ins_r")
_class("PlayTetrisEffectOnPickUpPosInstruction", BaseInstruction)
PlayTetrisEffectOnPickUpPosInstruction = PlayTetrisEffectOnPickUpPosInstruction

function PlayTetrisEffectOnPickUpPosInstruction:Constructor(paramList)
  local strList = paramList.tetrisEffectList
  local strIDs = string.split(strList, "|")
  self._tetrisEffectList = {}
  for i = 1, #strIDs do
    local effectID = tonumber(strIDs[i])
    table.insert(self._tetrisEffectList, effectID)
  end
  self._waitTime = tonumber(paramList.waitTime or 0)
end

function PlayTetrisEffectOnPickUpPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local utilDataSvc = self._world:GetService("UtilData")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local convertResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ConvertGridElement)
  if not convertResultArray or convertResultArray == {} then
    return
  end
  local result = convertResultArray[1]
  local tetrisIndex = result:GetSaveTetrisIndex()
  local dirType = result:GetSaveTetrisDirType()
  local tetrisDir = utilDataSvc:ParseFeatureTetrisDirTypeToVector2(dirType)
  local effectID = self._tetrisEffectList[tetrisIndex]
  local pickUpGridPos
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  if renderPickUpComponent then
    pickUpGridPos = renderPickUpComponent:GetLastPickUpGridPos()
  end
  local effectEntity = self._world:GetService("Effect"):CreateWorldPositionDirectionEffect(effectID, pickUpGridPos, tetrisDir)
  local effectGO = effectEntity:View():GetGameObject()
  local anim = effectGO.gameObject:GetComponent("Animation")
  if self._waitTime ~= 0 then
    YIELD(TT, self._waitTime)
    self._world:DestroyEntity(effectEntity)
  end
end

function PlayTetrisEffectOnPickUpPosInstruction:GetCacheResource()
  local res = {}
  for i, effectID in pairs(self._tetrisEffectList) do
    local skinEffRes = {
      Cfg.cfg_effect[effectID].ResPath,
      1
    }
    table.insert(res, skinEffRes)
  end
  return res
end
