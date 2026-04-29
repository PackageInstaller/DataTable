require("base_ins_r")
_class("PlayEffectAtPickUpGridByTrapBuffLayerInstruction", BaseInstruction)
PlayEffectAtPickUpGridByTrapBuffLayerInstruction = PlayEffectAtPickUpGridByTrapBuffLayerInstruction

function PlayEffectAtPickUpGridByTrapBuffLayerInstruction:Constructor(paramList)
  self._pickUpIndex = tonumber(paramList.pickUpIndex) or 1
  self._trapIDList = {}
  local trapList = paramList.trapIDList
  if trapList then
    local arr = string.split(trapList, "|")
    for i, v in ipairs(arr) do
      table.insert(self._trapIDList, tonumber(v))
    end
  end
  self._effectIDDic = {}
  local effList = paramList.effectIDList
  if effList then
    local arr = string.split(effList, "|")
    for k, effectID in ipairs(arr) do
      self._effectIDDic[k] = tonumber(effectID)
    end
  end
  self._effectScaleDic = {}
  local effScaleList = paramList.effectScaleList
  if effScaleList then
    local arr = string.split(effScaleList, "|")
    for k, scale in ipairs(arr) do
      self._effectScaleDic[k] = tonumber(scale)
    end
  end
  self._checkBuffEffectType = tonumber(paramList.checkBuffEffectType)
  self._dirX = 0
  self._dirY = 1
  if paramList.dirX then
    self._dirX = tonumber(paramList.dirX)
  end
  if paramList.dirY then
    self._dirY = tonumber(paramList.dirY)
  end
end

function PlayEffectAtPickUpGridByTrapBuffLayerInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local oriEntity = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    oriEntity = cSuperEntity:GetSuperEntity()
  end
  local world = oriEntity:GetOwnerWorld()
  local sEffect = world:GetService("Effect")
  local dir = Vector2(self._dirX, self._dirY)
  local renderPickUpComponent = oriEntity:RenderPickUpComponent()
  if not renderPickUpComponent then
    return
  end
  local effectID = 0
  local effScale = 1
  local tarBuffLayer = 0
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer then
    local pickUpTrapAndBuffDamageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.PickUpTrapAndBuffDamage)
    if pickUpTrapAndBuffDamageResultArray and 0 < #pickUpTrapAndBuffDamageResultArray then
      local effResult = pickUpTrapAndBuffDamageResultArray[1]
      tarBuffLayer = effResult:GetTarBuffLayer()
    end
  end
  local buffLayer = tarBuffLayer
  local effCount = #self._effectIDDic
  effectID = self._effectIDDic[buffLayer]
  if not effectID and 0 < effCount then
    effectID = self._effectIDDic[effCount]
  end
  effScale = self._effectScaleDic[buffLayer]
  if not effScale and 0 < #self._effectScaleDic then
    effScale = self._effectScaleDic[#self._effectScaleDic]
  end
  local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
  local pickUpPos = pickUpGridArray[self._pickUpIndex]
  if effectID and 0 < effectID then
    local effectEntity = sEffect:CreateWorldPositionDirectionEffect(effectID, pickUpPos, dir)
    if effScale and effScale ~= 1 then
      YIELD(TT)
      local effObject = effectEntity:View():GetGameObject()
      local transWork = effObject.transform
      local scaleData = Vector3.New(effScale, effScale, effScale)
      local sequence = transWork:DOScale(scaleData, 0)
    end
  end
end

function PlayEffectAtPickUpGridByTrapBuffLayerInstruction:GetCacheResource()
  local res = {}
  for i, effectID in pairs(self._effectIDDic) do
    local effRes = {
      Cfg.cfg_effect[effectID].ResPath,
      1
    }
    table.insert(res, effRes)
  end
  return res
end
