require("sp_base_inst")
_class("SkillPreviewPlayAllScopeConvertGridInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayAllScopeConvertGridInstruction = SkillPreviewPlayAllScopeConvertGridInstruction

function SkillPreviewPlayAllScopeConvertGridInstruction:Constructor(params)
end

function SkillPreviewPlayAllScopeConvertGridInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local scopeGridList = previewContext:GetScopeResult()
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local effectList = previewContext:GetEffectsByType(SkillEffectType.ConvertGridElement)
  local totalBlockPosList = {}
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local previewConvertElementCmpt = casterEntity:PreviewConvertElement()
  local pieceService = self._world:GetService("Piece")
  local utilData = self._world:GetService("UtilData")
  local trapServiceRender = self._world:GetService("TrapRender")
  if not previewConvertElementCmpt then
    casterEntity:AddPreviewConvertElement()
    previewConvertElementCmpt = casterEntity:PreviewConvertElement()
  end
  local needRecreateList = {}
  for i, v in ipairs(effectList) do
    local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.ConvertGridElement, v)
    local result = previewEffectCalcService:CalcConvertGridElement(casterEntity, scopeGridList, effectParam)
    local gridList = result:GetTargetGridArray()
    for _, gridPos in ipairs(gridList) do
      local originalElementType = utilData:FindPieceElement(gridPos)
      previewConvertElementCmpt:AddTempConvertElement(gridPos, originalElementType)
      local entity = pieceService:FindPieceEntity(gridPos)
      env:SetPieceType(gridPos, result:GetTargetElementType())
      table.insert(needRecreateList, {
        entity = entity,
        pos = gridPos,
        color = result:GetTargetElementType()
      })
    end
    table.Vector2Append(totalBlockPosList, result:GetBlockGridArray(), totalBlockPosList)
  end
  local oldPreviewIndex = previewActiveSkillService:GetPreviewIndex()
  YIELD(TT)
  local newPreviewIndex = previewActiveSkillService:GetPreviewIndex()
  if oldPreviewIndex ~= newPreviewIndex then
    Log.fatal("preview active skill failed ")
    return
  end
  for i, v in ipairs(needRecreateList) do
    local sourceEntity = pieceService:FindPieceEntity(v.pos)
    pieceService:SetPieceAnimColor(v.pos, v.color)
  end
  if totalBlockPosList then
    for _, gridPos in ipairs(totalBlockPosList) do
      local es = env:GetEntitiesAtPos(gridPos, function(e)
        return e:TrapRender() and e:TrapRender():GetTrapRender_IsLockedGrid()
      end)
      local lockGridTrap = es[1]
      if lockGridTrap then
        local go = lockGridTrap:View():GetGameObject()
        local u3dAnimCmpt = go:GetComponent(typeof(UnityEngine.Animation))
        if lockGridTrap:TrapID():GetTrapID() == BattleConst.LockGridTrapID then
          u3dAnimCmpt:Play("eff_2000521_lock_red01")
        else
          u3dAnimCmpt:Play("eff_2000521_lock_red")
        end
      end
    end
  end
end
