require("sp_base_inst")
_class("SkillPreviewCreateOutlineRangeInstruction", SkillPreviewBaseInstruction)
SkillPreviewCreateOutlineRangeInstruction = SkillPreviewCreateOutlineRangeInstruction

function SkillPreviewCreateOutlineRangeInstruction:Constructor(params)
  local strOutlineWidth = params.outlineWidth or "0.041"
  self._outlineWidth = tonumber(strOutlineWidth)
end

function SkillPreviewCreateOutlineRangeInstruction:DoInstruction(TT, casterEntity, previewContext)
  local scopeType = previewContext:GetScopeType()
  if scopeType == SkillScopeType.Nearest then
    return
  end
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local boardServiceRender = self._world:GetService("BoardRender")
  local sEntity = self._world:GetService("RenderEntity")
  local scopeGridList = previewContext:GetScopeResult()
  local casterPos = previewContext:GetCasterPos()
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceType = utilDataSvc:GetEntityElementPrimaryType(casterEntity)
  for _, pos in ipairs(scopeGridList) do
    local roundPosList = boardServiceRender:GetRoundPosList(pos)
    for _, roundPos in ipairs(roundPosList) do
      if not table.icontains(scopeGridList, roundPos) and roundPos ~= casterPos then
        local e = sEntity:CreateRenderEntity(EntityConfigIDRender.SkillRangeOutline, true)
        e:ReplaceSkillRangeOutline(pieceType, true)
        e:SkillRangeOutline():SetIsDestroy(true)
        local outlineDir = roundPos - pos
        local outlineDirType = boardServiceRender:GetOutlineDirType(outlineDir)
        self:_SetOutlineEntityPosAndDir(pos, e, outlineDirType)
      end
    end
  end
end

function SkillPreviewCreateOutlineRangeInstruction:_SetOutlineEntityPosAndDir(pos, outlineEntity, outlineDirType)
  local gridOutlineRadius = 0.52
  local outlinePos = pos
  local outlineDir = Vector2(0, 0)
  local OutlineDirType = {
    Up = 1,
    Down = 2,
    Left = 3,
    Right = 4,
    LeftUp = 5,
    RightUp = 6,
    RightDown = 7,
    LeftDown = 8
  }
  local OutlineType = {
    Short = 1,
    LeftShort = 2,
    RightShort = 3,
    Long = 4
  }
  if outlineDirType == OutlineDirType.Up then
    outlinePos = pos + Vector2(0, gridOutlineRadius)
    outlineDir = Vector2(0, 1)
  elseif outlineDirType == OutlineDirType.Down then
    outlinePos = pos + Vector2(0, -gridOutlineRadius)
    outlineDir = Vector2(0, -1)
  elseif outlineDirType == OutlineDirType.Left then
    outlinePos = pos + Vector2(-gridOutlineRadius, 0)
    outlineDir = Vector2(-1, 0)
  elseif outlineDirType == OutlineDirType.Right then
    outlinePos = pos + Vector2(gridOutlineRadius, 0)
    outlineDir = Vector2(1, 0)
  end
  outlineEntity:SetLocation(outlinePos, outlineDir)
end
