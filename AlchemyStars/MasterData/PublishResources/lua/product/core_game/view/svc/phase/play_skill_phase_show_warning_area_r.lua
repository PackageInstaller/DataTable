require("play_skill_phase_base_r")
_class("PlaySkillPhase_ShowWarningArea", PlaySkillPhaseBase)
PlaySkillPhase_ShowWarningArea = PlaySkillPhase_ShowWarningArea

function PlaySkillPhase_ShowWarningArea:PlayFlight(TT, casterEntity, phaseParam)
  local showWarningAreaParam = phaseParam
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local effectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ShowWarningArea)
  if effectResult == nil then
    Log.fatal("PlaySkillPhase_ShowWarningArea can not find result")
    return
  end
  local posList = effectResult:GetWarningPosList()
  self:_ShowWarningArea(casterEntity, posList, showWarningAreaParam)
  self:_ShowWaringDeathArea(casterEntity, posList, showWarningAreaParam)
end

function PlaySkillPhase_ShowWarningArea:_ShowWarningArea(casterEntity, listPosWarning, showWarningAreaParam)
  if nil == listPosWarning or #listPosWarning <= 0 then
    return
  end
  local renderEntityService = self._world:GetService("RenderEntity")
  local areaRes = showWarningAreaParam:GetAreaRes()
  local hasDeadWaring = showWarningAreaParam:HasDeadWaring()
  local outlineEntityList = renderEntityService:CreateAreaOutlineEntity(listPosWarning, EntityConfigIDRender.WarningArea)
  for i = 1, #outlineEntityList do
    local outlineEntity = outlineEntityList[i]
    outlineEntity:ReplaceDamageWarningAreaElement(casterEntity:GetID(), EntityConfigIDRender.WarningArea)
  end
end

function PlaySkillPhase_ShowWarningArea:_ShowWaringDeathArea(casterEntity, listPosWarning, showWarningAreaParam)
  if nil == listPosWarning or #listPosWarning <= 0 then
    return
  end
  local renderEntityService = self._world:GetService("RenderEntity")
  local areaRes = showWarningAreaParam:GetAreaRes()
  local hasDeadWaring = showWarningAreaParam:HasDeadWaring()
  if not hasDeadWaring then
    return
  end
  local renderEntityService = self._world:GetService("RenderEntity")
  for _, pos in ipairs(listPosWarning) do
    local entity = renderEntityService:CreateDeathRangeEntity(pos, EntityConfigIDRender.WaringDeathArea)
    entity:ReplaceDamageWarningAreaElement(casterEntity:GetID(), EntityConfigIDRender.WaringDeathArea)
  end
end

function PlaySkillPhase_ShowWarningArea:_ShowWarningCenterText(casterEntity, showWarningAreaParam, effectResult)
  local type = showWarningAreaParam:GetWarningCenterPosType()
  local gridPosList = {}
  if type == WarningCenterPosType.CasterPos then
    local gridPos = casterEntity:GridLocation().Position
    table.insert(gridPosList, gridPos)
  elseif type == WarningCenterPosType.GridPos then
    gridPosList = showWarningAreaParam:GetGridPosList()
  elseif type == WarningCenterPosType.CasterPosOffSet then
    local dir = Vector2(casterEntity:GridLocation():GetGridDir().x, casterEntity:GridLocation():GetGridDir().y)
    local offset = showWarningAreaParam:GetOffSet()
    local offSetPos = dir:Mul(offset)
    local gridPos = casterEntity:GridLocation().Position + offSetPos
    table.insert(gridPosList, gridPos)
  elseif type == WarningCenterPosType.EffectPos then
    gridPosList = effectResult:GetCenterList()
  end
  self:_CreateEffect(casterEntity, showWarningAreaParam:GetTextEffectID(), gridPosList)
end

function PlaySkillPhase_ShowWarningArea:_CreateEffect(casterEntity, effectID, gridPosList)
  local effectService = self._world:GetService("Effect")
  local entityList = {}
  for k, v in ipairs(gridPosList) do
    local entity = effectService:CreateUIEffect(casterEntity, effectID, v)
    table.insert(entityList, entity)
  end
  return entityList
end
