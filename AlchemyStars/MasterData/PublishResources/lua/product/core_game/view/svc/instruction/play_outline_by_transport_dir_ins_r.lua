require("base_ins_r")
_class("PlayOutlineByTransportDirInstruction", BaseInstruction)
PlayOutlineByTransportDirInstruction = PlayOutlineByTransportDirInstruction

function PlayOutlineByTransportDirInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._radius = tonumber(paramList.radius) or 0
end

function PlayOutlineByTransportDirInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local effectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.TransportByRange)
  if effectResult == nil then
    return
  end
  local pieceDataList = effectResult:GetPieceDataList()
  local edgeBegin, edgeEnd = effectResult:GetEdge()
  local dirType = effectResult:GetTransportDir()
  local posList = {}
  for i, data in ipairs(pieceDataList) do
    local pos = data:GetPiecePos()
    table.insert(posList, pos)
  end
  local outlineEntityList = self:CreateAreaOutlineEntity(casterEntity, edgeBegin, edgeEnd, dirType)
end

function PlayOutlineByTransportDirInstruction:_CreateOutlineEntity(roundPos, pos)
  local boardServiceRender = self._world:GetService("BoardRender")
  local effectService = self._world:GetService("Effect")
  local renderEntityService = self._world:GetService("RenderEntity")
  local outlineEntity = effectService:CreatePositionEffect(self._effectID, Vector3(0, 1000, 0))
  local gridOutlineHeight = 0
  local outlineDir = roundPos - pos
  local outlineDirType = boardServiceRender:GetOutlineDirType(outlineDir)
  outlineEntity:SetLocationHeight(gridOutlineHeight)
  renderEntityService:_SetOutlineEntityPosAndDir(pos, outlineEntity, outlineDirType, self._radius)
  return outlineEntity
end

function PlayOutlineByTransportDirInstruction:CreateAreaOutlineEntity(casterEntity, edgeBegin, edgeEnd, dirType)
  local effectCpmt = casterEntity:EffectHolder()
  if not effectCpmt then
    casterEntity:AddEffectHolder()
    effectCpmt = casterEntity:EffectHolder()
  end
  local outlineEntityList = {}
  for i, pos in ipairs(edgeBegin) do
    local roundPos
    if dirType == DirectionType.Left then
      roundPos = Vector2(pos.x + 1, pos.y)
    elseif dirType == DirectionType.Right then
      roundPos = Vector2(pos.x - 1, pos.y)
    elseif dirType == DirectionType.Up then
      roundPos = Vector2(pos.x, pos.y - 1)
    elseif dirType == DirectionType.Down then
      roundPos = Vector2(pos.x, pos.y + 1)
    end
    local outlineEntity = self:_CreateOutlineEntity(roundPos, pos)
    effectCpmt:AttachIdleEffect(outlineEntity:GetID())
    outlineEntityList[#outlineEntityList + 1] = outlineEntity
  end
  for i, pos in ipairs(edgeEnd) do
    local roundPos
    if dirType == DirectionType.Left then
      roundPos = Vector2(pos.x - 1, pos.y)
    elseif dirType == DirectionType.Right then
      roundPos = Vector2(pos.x + 1, pos.y)
    elseif dirType == DirectionType.Up then
      roundPos = Vector2(pos.x, pos.y + 1)
    elseif dirType == DirectionType.Down then
      roundPos = Vector2(pos.x, pos.y - 1)
    end
    local outlineEntity = self:_CreateOutlineEntity(roundPos, pos)
    effectCpmt:AttachIdleEffect(outlineEntity:GetID())
    outlineEntityList[#outlineEntityList + 1] = outlineEntity
  end
  return outlineEntityList
end

function PlayOutlineByTransportDirInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
