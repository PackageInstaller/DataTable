require("base_ins_r")
_class("PlayEffectAtAllGridPosInstruction", BaseInstruction)
PlayEffectAtAllGridPosInstruction = PlayEffectAtAllGridPosInstruction

function PlayEffectAtAllGridPosInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
end

function PlayEffectAtAllGridPosInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      99
    })
  end
  return t
end

function PlayEffectAtAllGridPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local effectSvc = world:GetService("Effect")
  local utilData = world:GetService("UtilData")
  local gridEntityData = utilData:GetReplicaGridEntityData()
  if gridEntityData then
    for pos, _ in pairs(gridEntityData) do
      if not renderBoardCmpt:GetGridEffectEntityID(pos) then
        local effectEntity = effectSvc:CreateWorldPositionDirectionEffect(self._effectID, pos)
        renderBoardCmpt:SetGridEffectEntityID(pos, effectEntity:GetID())
      end
    end
  end
end
