require("sp_base_inst")
_class("SkillPreviewPlayGridEffectInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayGridEffectInstruction = SkillPreviewPlayGridEffectInstruction

function SkillPreviewPlayGridEffectInstruction:Constructor(params)
  self._effectID = tonumber(params.effectID)
  self._playType = tonumber(params.playType)
  if params.x and params.y then
    local gridX = tonumber(params.x)
    local gridY = tonumber(params.y)
    self._girdPos = Vector2(gridX, gridY)
  end
end

function SkillPreviewPlayGridEffectInstruction:GetCacheResource()
  local res = {}
  local effRes = {
    Cfg.cfg_effect[self._effectID].ResPath,
    1
  }
  table.insert(res, effRes)
  return res
end

function SkillPreviewPlayGridEffectInstruction:DoInstruction(TT, casterEntity, previewContext)
  local previewActiveSkillService = previewContext:GetWorld():GetService("PreviewActiveSkill")
  local world = casterEntity:GetOwnerWorld()
  local previewPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  local useEffectID = self._effectID
  if self._playType == 1 then
    local effectEntity = world:GetService("Effect"):CreateWorldPositionEffect(useEffectID, self._girdPos)
    previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID(), useEffectID)
  else
    local renderBoardEntity = world:GetRenderBoardEntity()
    local renderBoardCmpt = renderBoardEntity:RenderBoard()
    local effectSvc = world:GetService("Effect")
    local utilData = world:GetService("UtilData")
    local gridEntityData = utilData:GetReplicaGridEntityData()
    local gridCount = table.count(gridEntityData)
    Log.fatal("GridCount:", gridCount)
    if gridEntityData then
      for pos, _ in pairs(gridEntityData) do
        local effectEntity = effectSvc:CreateWorldPositionDirectionEffect(useEffectID, pos)
        previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID(), useEffectID)
      end
    end
  end
end
