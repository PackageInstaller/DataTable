_class("PreviewLinkLineSystem_Render", ReactiveSystem)
PreviewLinkLineSystem_Render = PreviewLinkLineSystem_Render

function PreviewLinkLineSystem_Render:Constructor(world)
  self._world = world
end

function PreviewLinkLineSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PreviewLinkLine)
  }, {"Added"})
  return c
end

function PreviewLinkLineSystem_Render:Filter(entity)
  return entity:HasPreviewLinkLine()
end

function PreviewLinkLineSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:RenderChainPath(entities[i])
  end
end

function PreviewLinkLineSystem_Render:RenderChainPath(e)
  local exist_pos = self:RefreshLinkLine(e)
  local previewLinkLineCmpt = e:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  if chainPath == nil then
    return
  end
  local syncMoveServiceRender = self._world:GetService("SyncMoveRender")
  if syncMoveServiceRender then
    syncMoveServiceRender:PreviewOnLinkLine(chainPath)
  end
  local pathCount = #chainPath
  self:_RemoveUnLinkedGridEffectEntity(chainPath)
  local linkageRenderService = self._world:GetService("LinkageRender")
  local preLinkLineSvc = self._world:GetService("PreviewLinkLine")
  for i, v in ipairs(chainPath) do
    if i ~= 1 then
      local dir = chainPath[i - 1] - chainPath[i]
      if not table.icontains(exist_pos, v) then
        local pieceType = preLinkLineSvc:ConvertLinkPosPieceType(chainPath[i])
        linkageRenderService:CreateLineRender(chainPath[i - 1], chainPath[i], i, v, dir, pieceType)
        linkageRenderService:ShowLinkDot(chainPath[i])
      end
      if i == pathCount then
        local env = self._world:GetPreviewEntity():PreviewEnv()
        local curType = env:GetPieceType(chainPath[i])
        linkageRenderService:RefreshTouchPosGridEffect(chainPath[i], -dir, curType)
      end
    end
  end
  if pathCount <= 1 then
    linkageRenderService:RefreshTouchPosGridEffect()
  end
end

function PreviewLinkLineSystem_Render:RefreshLinkLine(previewEntity)
  local reBoard = self._world:GetRenderBoardEntity()
  local linkRendererDataCmpt = reBoard:LinkRendererData()
  local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  local remove_list = {}
  local exist_pos = {}
  local boardServiceRender = self._world:GetService("BoardRender")
  for _, link_line_entity in ipairs(allEntities) do
    local pos = boardServiceRender:GetRealEntityGridPos(link_line_entity)
    table.insert(exist_pos, pos)
    if not table.icontains(chainPath, pos) then
      table.insert(remove_list, link_line_entity)
    end
  end
  local renderChainPathComponent = reBoard:RenderChainPath()
  local chainAcrossMonster = renderChainPathComponent:GetChainMonsterShadowPosList() or {}
  local selectMonsterShadowPosList = renderChainPathComponent:GetChainSelectMonsterShadowPosList() or {}
  local pieceService = self._world:GetService("Piece")
  local preLinkLineSvc = self._world:GetService("PreviewLinkLine")
  local linkageRenderService = self._world:GetService("LinkageRender")
  local gridTouchCmpt = self._world:GridTouch()
  local touchStateID = gridTouchCmpt:GetGridTouchStateID()
  local env = self._world:GetPreviewEntity():PreviewEnv()
  for _, e in ipairs(remove_list) do
    local chainPos = boardServiceRender:GetRealEntityGridPos(e)
    linkageRenderService:HideLinkDot(chainPos)
    linkageRenderService:DestroyLinkLine(e)
    preLinkLineSvc:CancelLinkPosPieceType(chainPos)
    if touchStateID == GridTouchStateID.PLLEndDrag and (table.intable(chainAcrossMonster, chainPos) or table.intable(selectMonsterShadowPosList, chainPos)) then
      pieceService:SetPieceAnimDown(chainPos)
    end
    if env:IsPrismPiece(chainPos) then
      pieceService:SetPieceAnimNormal(chainPos)
    end
  end
  return exist_pos
end

function PreviewLinkLineSystem_Render:_RemoveUnLinkedGridEffectEntity(chainPath)
  local gridEffectGroup = self._world:GetGroup(self._world.BW_WEMatchers.GridEffect)
  local remove_list = {}
  local boardServiceRender = self._world:GetService("BoardRender")
  for _, gridEffectEntity in ipairs(gridEffectGroup:GetEntities()) do
    local gridEffectCmpt = gridEffectEntity:GridEffect()
    local gridEffectType = gridEffectCmpt:GetGridEffectType()
    if gridEffectType == "InPath" then
      local pos = boardServiceRender:GetRealEntityGridPos(gridEffectEntity)
      if not table.icontains(chainPath, pos) then
        table.insert(remove_list, gridEffectEntity)
      end
    end
  end
  for _, e in ipairs(remove_list) do
    self._world:DestroyEntity(e)
  end
end
