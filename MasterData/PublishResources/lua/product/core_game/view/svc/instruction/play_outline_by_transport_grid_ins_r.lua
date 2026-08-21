require("base_ins_r")
_class("PlayOutlineByTransportGridInstruction", BaseInstruction)
PlayOutlineByTransportGridInstruction = PlayOutlineByTransportGridInstruction

function PlayOutlineByTransportGridInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._radius = tonumber(paramList.radius) or 0
end

function PlayOutlineByTransportGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local effectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.TransportByRange)
  if effectResult == nil then
    return
  end
  local pieceDataList = effectResult:GetPieceDataList()
  local posList = effectResult:GetOutlineRange()
  local outlineEntityList = self:CreateAreaOutlineEntity(casterEntity, posList)
end

function PlayOutlineByTransportGridInstruction:CreateAreaOutlineEntity(casterEntity, gridList)
  local world = casterEntity:GetOwnerWorld()
  local boardServiceRender = world:GetService("BoardRender")
  local effectService = world:GetService("Effect")
  local renderEntityService = world:GetService("RenderEntity")
  local effectCpmt = casterEntity:EffectHolder()
  if not effectCpmt then
    casterEntity:AddEffectHolder()
    effectCpmt = casterEntity:EffectHolder()
  end
  local outlineEntityList = {}
  for _, pos in ipairs(gridList) do
    local roundPosList = boardServiceRender:GetRoundPosList(pos)
    for i = 1, #roundPosList do
      local roundPos = roundPosList[i]
      if not table.icontains(gridList, roundPos) then
        local outlineEntity = effectService:CreatePositionEffect(self._effectID, Vector3(0, 1000, 0))
        effectCpmt:AttachIdleEffect(outlineEntity:GetID())
        local gridOutlineHeight = 0
        local outlineDir = roundPos - pos
        local outlineDirType = boardServiceRender:GetOutlineDirType(outlineDir)
        outlineEntity:SetLocationHeight(gridOutlineHeight)
        renderEntityService:_SetOutlineEntityPosAndDir(pos, outlineEntity, outlineDirType, self._radius)
        outlineEntityList[#outlineEntityList + 1] = outlineEntity
      end
    end
  end
  return outlineEntityList
end

function PlayOutlineByTransportGridInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
