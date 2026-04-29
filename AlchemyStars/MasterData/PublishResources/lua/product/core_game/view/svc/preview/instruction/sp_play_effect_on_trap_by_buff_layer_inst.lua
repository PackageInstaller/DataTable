require("sp_base_inst")
_class("SkillPreviewPlayEffectOnTrapByBuffLayerInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayEffectOnTrapByBuffLayerInstruction = SkillPreviewPlayEffectOnTrapByBuffLayerInstruction

function SkillPreviewPlayEffectOnTrapByBuffLayerInstruction:Constructor(params)
  self._trapIDList = {}
  local trapList = params.trapIDList
  if trapList then
    local strTrapIDs = string.split(trapList, "|")
    for i, v in ipairs(strTrapIDs) do
      table.insert(self._trapIDList, tonumber(v))
    end
  end
  self._effectIDDic = {}
  local effectIDDic = params.effectIDList
  if effectIDDic then
    local strEffIDs = string.split(effectIDDic, "|")
    for k, effectID in ipairs(strEffIDs) do
      self._effectIDDic[k] = tonumber(effectID)
    end
  end
  self._checkBuffEffectType = tonumber(params.checkBuffEffectType)
  self._dirX = 0
  self._dirY = 1
  if params.dirX then
    self._dirX = tonumber(params.dirX)
  end
  if params.dirY then
    self._dirY = tonumber(params.dirY)
  end
end

function SkillPreviewPlayEffectOnTrapByBuffLayerInstruction:GetCacheResource()
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

function SkillPreviewPlayEffectOnTrapByBuffLayerInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local trapEntityList = {}
  local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    local trapRenderCmpt = e:TrapRender()
    if trapRenderCmpt and not trapRenderCmpt:GetHadPlayDestroy() and table.icontains(self._trapIDList, trapRenderCmpt:GetTrapID()) then
      table.insert(trapEntityList, e)
    end
  end
  if not casterEntity:HasPreviewStageEffectRecord() then
    casterEntity:AddPreviewStageEffectRecord()
  end
  local previewStrageEffectRecordComponent = casterEntity:PreviewStageEffectRecord()
  local dir = Vector2(self._dirX, self._dirY)
  local sEffect = world:GetService("Effect")
  for i, trapEntity in ipairs(trapEntityList) do
    local effectID = 0
    local trap = trapEntity
    local buffLogicService = world:GetService("BuffLogic")
    local buffLayer = buffLogicService:GetBuffLayer(trap, self._checkBuffEffectType)
    local effCount = #self._effectIDDic
    effectID = self._effectIDDic[buffLayer]
    if not effectID and 0 < effCount then
      effectID = self._effectIDDic[effCount]
    end
    if effectID and 0 < effectID then
      local trapPos = trap:GetGridPosition()
      local effectEntity = sEffect:CreateWorldPositionDirectionEffect(effectID, trapPos, dir)
      if previewStrageEffectRecordComponent then
        previewStrageEffectRecordComponent:AddPreviewStageEffectEntityID(effectEntity:GetID())
      end
    end
  end
end
