_class("LinkageRenderService", Object)
LinkageRenderService = LinkageRenderService

function LinkageRenderService:Constructor(world)
  self._world = world
end

function LinkageRenderService:_ClearLinkageInfo()
  local linkageGroup = self._world:GetGroup(self._world.BW_WEMatchers.LinkageInfo)
  for _, linkageEntity in ipairs(linkageGroup:GetEntities()) do
    local linkageInfoCmpt = linkageEntity:LinkageInfo()
    linkageInfoCmpt:SetLinkCount(0)
    linkageEntity:SetViewVisible(false)
  end
end

function LinkageRenderService:ShowChainSkillIcon(petEntityID)
  local petEntity = self._world:GetEntityByID(petEntityID)
  if not petEntity then
    return
  end
  local teLinkageInfo = self._world:GetGroupEntities(self._world.BW_WEMatchers.LinkageInfo)
  for _, eLinkageInfo in ipairs(teLinkageInfo) do
    local cLinkageInfo = eLinkageInfo:LinkageInfo()
    cLinkageInfo:SetChainSkillPet(petEntity)
  end
end

function LinkageRenderService:HideChainSkillIcon()
  local teLinkageInfo = self._world:GetGroupEntities(self._world.BW_WEMatchers.LinkageInfo)
  for _, eLinkageInfo in ipairs(teLinkageInfo) do
    local cLinkageInfo = eLinkageInfo:LinkageInfo()
    cLinkageInfo:HideChainSkillPet()
  end
end

function LinkageRenderService:ShowLinkageInfo(chainPath, pieceType)
  if #chainPath <= 0 then
    self:_RemoveAllLinkedNumEntity()
    self:_ClearLinkageInfo()
    return
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local chainCount, superGridNum = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, #chainPath)
  chainCount = chainCount + 1
  self:_ShowLinkageNum(chainPath, pieceType)
  local lastChainPos = chainPath[#chainPath]
  local hudWorldPos = self:_CalcGridHUDWorldPos(lastChainPos)
  if hudWorldPos == nil then
    return
  end
  local linkageGroup = self._world:GetGroup(self._world.BW_WEMatchers.LinkageInfo)
  if 1 < chainCount then
    for _, linkageEntity in ipairs(linkageGroup:GetEntities()) do
      local linkageInfoCmpt = linkageEntity:LinkageInfo()
      linkageEntity:SetViewVisible(true)
      linkageInfoCmpt:SetLinkCount(chainCount)
      linkageInfoCmpt:SetLinkagePos(hudWorldPos)
    end
  else
    for _, linkageEntity in ipairs(linkageGroup:GetEntities()) do
      local linkageInfoCmpt = linkageEntity:LinkageInfo()
      linkageEntity:SetViewVisible(false)
    end
  end
end

function LinkageRenderService:UpdateLinkageInfoPos()
  local previewEntity = self._world:GetPreviewEntity()
  if previewEntity == nil then
    return
  end
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  if previewChainPathCmpt == nil then
    return
  end
  local chainPathArray = previewChainPathCmpt:GetPreviewChainPath()
  if chainPathArray == nil then
    return
  end
  local linkageGroup = self._world:GetGroup(self._world.BW_WEMatchers.LinkageInfo)
  for _, linkageEntity in ipairs(linkageGroup:GetEntities()) do
    if linkageEntity:HasViewExtension() then
      local visible = linkageEntity:IsViewVisible()
      if visible ~= true then
        return
      end
    else
      return
    end
  end
  local chainPathCount = #chainPathArray
  if chainPathCount < 2 then
    return
  end
  local lastChainPos = chainPathArray[chainPathCount]
  local hudWorldPos = self:_CalcGridHUDWorldPos(lastChainPos)
  if hudWorldPos == nil then
    return
  end
  local linkageGroup = self._world:GetGroup(self._world.BW_WEMatchers.LinkageInfo)
  for _, linkageEntity in ipairs(linkageGroup:GetEntities()) do
    local linkageInfoCmpt = linkageEntity:LinkageInfo()
    linkageInfoCmpt:SetLinkagePos(hudWorldPos)
  end
end

function LinkageRenderService:_RemoveAllLinkedNumEntity()
  local entityPoolService = self._world:GetService("EntityPool")
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  local allEntities = linkRendererDataCmpt:GetLinkageNumEntityList()
  local remove_list = {}
  for _, linkageNumEntity in ipairs(allEntities) do
    table.insert(remove_list, linkageNumEntity)
  end
  for _, e in ipairs(remove_list) do
    self:DestroyLinkNum(e)
  end
end

function LinkageRenderService:_HasLinkageNumIndex(linkageNumIndex)
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  local allEntities = linkRendererDataCmpt:GetLinkageNumEntityList()
  for _, linkageNumEntity in ipairs(allEntities) do
    local linkageNumCmpt = linkageNumEntity:LinkageNum()
    local linkIndex = linkageNumCmpt:GetLinkageIndex()
    if linkIndex == linkageNumIndex then
      return true
    end
  end
  return false
end

function LinkageRenderService:_RemoveUnLinkedNumEntity(chainPath)
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  local allEntities = linkRendererDataCmpt:GetLinkageNumEntityList()
  local boardServiceRender = self._world:GetService("BoardRender")
  local remove_list = {}
  local lastPos = chainPath[#chainPath]
  local alreadyOnScreenList = {}
  for _, linkageNumEntity in ipairs(allEntities) do
    local pos = boardServiceRender:GetRealEntityGridPos(linkageNumEntity)
    if not table.icontains(chainPath, pos) then
      table.insert(remove_list, linkageNumEntity)
    end
  end
  local entityPoolService = self._world:GetService("EntityPool")
  for _, e in ipairs(remove_list) do
    self:DestroyLinkNum(e)
  end
end

function LinkageRenderService:IsNeedShowLinkageNumForCostStep()
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    return true
  end
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  if previewChainPathCmpt:GetLinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    return true
  end
  return false
end

function LinkageRenderService:_ShowLinkageNum(chainPath, pieceType)
  if self:IsNeedShowLinkageNumForCostStep() then
    return self:_ShowLinkageNumForCostStep(chainPath, pieceType)
  end
  self:_RemoveUnLinkedNumEntity(chainPath)
  local chainPathCount = #chainPath
  if chainPathCount < 2 then
    return
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  for chainIndex, v in ipairs(chainPath) do
    if 2 <= chainIndex then
      local hasLinkageNum = self:_HasLinkageNumIndex(chainIndex)
      if hasLinkageNum == false then
        local linkageNumPoint = chainPath[chainIndex]
        local chainRate, superGrid, poorGrid = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, chainIndex)
        self:CreateLinkNumEntity(linkageNumPoint, chainIndex, chainRate + superGrid - poorGrid, pieceType)
      end
    end
  end
end

function LinkageRenderService:_ShowLinkageNumForCostStep(chainPath, pieceType)
  self:_RemoveUnLinkedNumEntity(chainPath)
  local chainPathCount = #chainPath
  if chainPathCount < 2 then
    return
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local utilDataSvc = self._world:GetService("UtilData")
  local curStepPoint = utilDataSvc:GetCurLinkStepPoint()
  for chainIndex, v in ipairs(chainPath) do
    if 2 <= chainIndex then
      local hasLinkageNum = self:_HasLinkageNumIndex(chainIndex)
      if hasLinkageNum == false then
        local linkageNumPoint = chainPath[chainIndex]
        local restStep = curStepPoint - (chainIndex - 1)
        self:CreateLinkNumEntityForCostStep(linkageNumPoint, chainIndex, restStep, pieceType)
      end
    end
  end
end

function LinkageRenderService:_CalcGridHUDWorldPos(gridPos)
  local lastPieceEntity = self._world:GetService("Piece"):FindPieceEntity(gridPos)
  if lastPieceEntity == nil then
    return
  end
  local locationCmpt = lastPieceEntity:Location()
  if locationCmpt == nil then
    return
  end
  local gridRenderPos = lastPieceEntity:GetPosition()
  local camera = self._world:MainCamera():Camera()
  local screenPos = camera:WorldToScreenPoint(gridRenderPos)
  local hudCamera = self._world:MainCamera():HUDCamera()
  local hudWorldPos = hudCamera:ScreenToWorldPoint(screenPos)
  return hudWorldPos
end

function LinkageRenderService:CreateLinkNumEntity(linkageNumPoint, linkageNum, chainRate, pieceType)
  local entityPoolService = self._world:GetService("EntityPool")
  local entityConfigId = self:_GetLinkageNumIDByPieceType(pieceType)
  local linkageNumEntity = entityPoolService:GetCacheEntityByConfigID(entityConfigId)
  entityPoolService:GetCacheEntityCountByID(entityConfigId)
  linkageNumEntity:SetViewVisible(false)
  linkageNumEntity:SetLocation(linkageNumPoint, Vector2(0, 0))
  local linkageNumCmpt = linkageNumEntity:LinkageNum()
  linkageNumCmpt:SetEntityConfigId(entityConfigId)
  linkageNumCmpt:SetLinkNum(linkageNum)
  linkageNumCmpt:SetLinkChainRate(chainRate)
  linkageNumCmpt:SetLinkLineType(ELinkLineType.ELLT_LINE_Common)
  self:_SetLinkNumRate(linkageNumEntity)
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  linkRendererDataCmpt:AddLinkageNumEntity(linkageNumEntity)
  return linkageNumEntity
end

function LinkageRenderService:CreateLinkNumEntityForCostStep(linkageNumPoint, linkageNum, restStep, pieceType)
  local entityPoolService = self._world:GetService("EntityPool")
  local entityConfigId = EntityConfigIDRender.LinkNumStep
  local linkageNumEntity = entityPoolService:GetCacheEntityByConfigID(entityConfigId)
  entityPoolService:GetCacheEntityCountByID(entityConfigId)
  linkageNumEntity:SetViewVisible(false)
  linkageNumEntity:SetLocation(linkageNumPoint, Vector2(0, 0))
  local linkageNumCmpt = linkageNumEntity:LinkageNum()
  linkageNumCmpt:SetEntityConfigId(entityConfigId)
  linkageNumCmpt:SetLinkNum(linkageNum)
  linkageNumCmpt:SetLinkRestStep(restStep)
  linkageNumCmpt:SetLinkLineType(ELinkLineType.ELLT_LINE_NoElementCostStep)
  self:_SetLinkNumRate(linkageNumEntity)
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  linkRendererDataCmpt:AddLinkageNumEntity(linkageNumEntity)
  return linkageNumEntity
end

function LinkageRenderService:_SetLinkNumRate(linknumEntity)
  local viewCmpt = linknumEntity:View()
  if viewCmpt == nil then
    return
  end
  local viewObj = viewCmpt:GetGameObject()
  if viewObj == nil then
    return
  end
  local linkageNumCmpt = linknumEntity:LinkageNum()
  linknumEntity:SetViewVisible(true)
  local viewWrapper = viewCmpt.ViewWrapper
  local viewRoot = viewWrapper.GameObject
  viewRoot.transform.rotation = Quaternion.Euler(90, -90, 0)
  linkageNumCmpt:SetLinkCount(viewRoot)
end

function LinkageRenderService:_GetLinkageNumIDByPieceType(pieceType)
  local res = EntityConfigIDRender.LinkNum_Any
  if pieceType == PieceType.Red then
    res = EntityConfigIDRender.LinkNum_Red
  elseif pieceType == PieceType.Green then
    res = EntityConfigIDRender.LinkNum_Green
  elseif pieceType == PieceType.Blue then
    res = EntityConfigIDRender.LinkNum_Blue
  elseif pieceType == PieceType.Yellow then
    res = EntityConfigIDRender.LinkNum_Yellow
  end
  return res
end

function LinkageRenderService:ShowPathGridEffect(gridPos, pathIndex)
  local pieceEntity = self._world:GetService("Piece"):FindPieceEntity(gridPos)
  if not self._gridMpb then
    self._gridMpb = UnityEngine.MaterialPropertyBlock:New()
    self._gridColorIntensityStart = 0
    self._gridColorIntensityEnd = 1
    self._baseColorDicGrid = {}
  end
  local go = pieceEntity:View():GetGameObject()
  local trans = go.transform:Find("xd/plane_3")
  if not trans then
    return
  end
  local renderer = trans.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer))
  if not renderer then
    return
  end
  local pieceType = pieceEntity:Piece().Type
  local baseColor = self._baseColorDicGrid[pieceType]
  if not baseColor then
    baseColor = renderer.sharedMaterial:GetVector("_MainColor")
    self._baseColorDicGrid[pieceType] = baseColor
  end
  local t = pathIndex - 2
  local max = BattleConst.SuperChainCount - 1
  if t > max then
    t = max
  end
  if 0 <= t then
    local res = Mathf.Lerp(self._gridColorIntensityStart, self._gridColorIntensityEnd, t / max)
    local resColor = baseColor * (1 + res)
    resColor.w = baseColor.w
    self._gridMpb:SetVector("_MainColor", resColor)
    renderer:SetPropertyBlock(self._gridMpb)
  end
end

function LinkageRenderService:ShowSelectGridEffect(gridPos, pieceType, pathIndex)
  local hasGridEffect = self:_HasGridEffect(gridPos)
  if hasGridEffect == true then
    return
  end
  local sEntity = self._world:GetService("RenderEntity")
  local inPathGridEffectEntity = sEntity:CreateRenderEntity(self:_GetGridEffectIDByPieceType(pieceType))
  inPathGridEffectEntity:SetViewVisible(true)
  inPathGridEffectEntity:SetLocation(gridPos, Vector2(0, 0))
  inPathGridEffectEntity:GridEffect():SetPathIndex(pathIndex)
  inPathGridEffectEntity:GridEffect():SetPieceType(pieceType)
  return inPathGridEffectEntity
end

function LinkageRenderService:_GetGridEffectIDByPieceType(pieceType)
  local res = EntityConfigIDRender.LinkGridInPath_Any
  if pieceType == PieceType.Red then
    res = EntityConfigIDRender.LinkGridInPath_Red
  elseif pieceType == PieceType.Green then
    res = EntityConfigIDRender.LinkGridInPath_Green
  elseif pieceType == PieceType.Blue then
    res = EntityConfigIDRender.LinkGridInPath_Blue
  elseif pieceType == PieceType.Yellow then
    res = EntityConfigIDRender.LinkGridInPath_Yellow
  end
  return res
end

function LinkageRenderService:_HasGridEffect(targetGridPos)
  local gridEffectGroup = self._world:GetGroup(self._world.BW_WEMatchers.GridEffect)
  for _, gridEffectEntity in ipairs(gridEffectGroup:GetEntities()) do
    local gridEffectCmpt = gridEffectEntity:GridEffect()
    local gridEffectType = gridEffectCmpt:GetGridEffectType()
    if gridEffectType == "InPath" and gridEffectEntity:GridLocation() then
      local gridEffectPos = gridEffectEntity:GridLocation().Position
      if gridEffectPos == targetGridPos then
        return true
      end
    end
  end
  return false
end

function LinkageRenderService:RefreshTouchPosGridEffect(gridPos, dir, pieceType)
  local curTouchPosGridEffect
  local gridEffectGroup = self._world:GetGroup(self._world.BW_WEMatchers.GridEffect)
  for _, gridEffectEntity in ipairs(gridEffectGroup:GetEntities()) do
    local gridEffectCmpt = gridEffectEntity:GridEffect()
    local gridEffectType = gridEffectCmpt:GetGridEffectType()
    if gridEffectType == "TouchPos" then
      if gridEffectCmpt:GetPieceType() ~= pieceType then
        self._world:DestroyEntity(gridEffectEntity)
        break
      end
      curTouchPosGridEffect = gridEffectEntity
      break
    end
  end
  if curTouchPosGridEffect and not gridPos then
    self._world:DestroyEntity(curTouchPosGridEffect)
  elseif curTouchPosGridEffect and gridPos then
    curTouchPosGridEffect:SetLocation(gridPos, dir)
  elseif gridPos then
    local sEntity = self._world:GetService("RenderEntity")
    local touchPosEffect = sEntity:CreateRenderEntity(self:_GetTouchPosEffectIDByPieceType(pieceType))
    touchPosEffect:SetLocation(gridPos, dir)
    touchPosEffect:GridEffect():SetPieceType(pieceType)
  end
end

function LinkageRenderService:_GetTouchPosEffectIDByPieceType(pieceType)
  local res = EntityConfigIDRender.LinkPos_Any
  if pieceType == PieceType.Red then
    res = EntityConfigIDRender.LinkPos_Red
  elseif pieceType == PieceType.Green then
    res = EntityConfigIDRender.LinkPos_Green
  elseif pieceType == PieceType.Blue then
    res = EntityConfigIDRender.LinkPos_Blue
  elseif pieceType == PieceType.Yellow then
    res = EntityConfigIDRender.LinkPos_Yellow
  end
  return res
end

function LinkageRenderService:CreateLineRender(headGridPos, endGridPos, idx, gridPos, dir, pieceType)
  local entityPoolService = self._world:GetService("EntityPool")
  local entityConfigId = self:_GetLinkLineRenderIDByPieceType(pieceType)
  local linkLineRenderEntity = entityPoolService:GetCacheEntityByConfigID(entityConfigId)
  entityPoolService:GetCacheEntityCountByID(entityConfigId)
  linkLineRenderEntity:SetLocation(gridPos, Vector2(0, 0))
  linkLineRenderEntity:ReplaceLinkLineIndex(idx)
  local boardServiceRender = self._world:GetService("BoardRender")
  local headRenderPos
  if headGridPos ~= nil then
    headRenderPos = boardServiceRender:GridPos2RenderPos(headGridPos)
  end
  local endRenderPos = boardServiceRender:GridPos2RenderPos(endGridPos)
  local lineHeight = 0.01
  headRenderPos.y = lineHeight
  endRenderPos.y = lineHeight
  linkLineRenderEntity:ReplaceLinkLineRender(headRenderPos, endRenderPos)
  local gridEffectCmp = linkLineRenderEntity:GridEffect()
  local gridEffectType = gridEffectCmp:GetGridEffectType()
  linkLineRenderEntity:ReplaceGridEffect(gridEffectType)
  gridEffectCmp = linkLineRenderEntity:GridEffect()
  gridEffectCmp:SetPieceType(pieceType)
  gridEffectCmp:SetPathIndex(idx)
  local linkLineIndexCmp = linkLineRenderEntity:LinkLineIndex()
  if linkLineIndexCmp then
    linkLineIndexCmp:SetEntityConfigId(entityConfigId)
  end
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  linkRendererDataCmpt:AddLinkLineEntity(linkLineRenderEntity)
  return linkLineRenderEntity
end

function LinkageRenderService:_GetLinkLineRenderIDByPieceType(pieceType)
  local res = EntityConfigIDRender.LinkLine_Any
  if pieceType == PieceType.Red then
    res = EntityConfigIDRender.LinkLine_Red
  elseif pieceType == PieceType.Green then
    res = EntityConfigIDRender.LinkLine_Green
  elseif pieceType == PieceType.Blue then
    res = EntityConfigIDRender.LinkLine_Blue
  elseif pieceType == PieceType.Yellow then
    res = EntityConfigIDRender.LinkLine_Yellow
  end
  return res
end

function LinkageRenderService:DestroyLinkNum(e)
  local entityPoolService = self._world:GetService("EntityPool")
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  local linkageNumCmpt = e:LinkageNum()
  local entityConfigId = linkageNumCmpt:GetEntityConfigId()
  entityPoolService:DestroyCacheEntity(e, entityConfigId)
  entityPoolService:GetCacheEntityCountByID(entityConfigId)
  linkRendererDataCmpt:RemoveLinkageNumEntity(e)
end

function LinkageRenderService:DestroyLinkLine(e)
  local entityPoolService = self._world:GetService("EntityPool")
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  local linkLineCmpt = e:LinkLineIndex()
  local entityConfigId = linkLineCmpt:GetEntityConfigId()
  self:ResetLinkLineEntity(e)
  entityPoolService:DestroyCacheEntity(e, entityConfigId)
  entityPoolService:GetCacheEntityCountByID(entityConfigId)
  linkRendererDataCmpt:RemoveLinkLineEntity(e)
end

function LinkageRenderService:DestroyAllLinkLine()
  local entityPoolService = self._world:GetService("EntityPool")
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
  local remove_list = {}
  for _, link_line_entity in ipairs(allEntities) do
    table.insert(remove_list, link_line_entity)
  end
  for _, e in ipairs(remove_list) do
    self:DestroyLinkLine(e)
  end
end

function LinkageRenderService:HideAllLinkDot()
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
  local boardServiceRender = self._world:GetService("BoardRender")
  for _, e in ipairs(allEntities) do
    local pos = boardServiceRender:GetRealEntityGridPos(e)
    self:HideLinkDot(pos)
  end
end

function LinkageRenderService:HideLinkDot(pos)
  self._world:GetService("Piece"):SetPieceAnimLinkOut(pos)
end

function LinkageRenderService:ShowLinkDot(pos)
  local pieceService = self._world:GetService("Piece")
  pieceService:SetPieceAnimLinkIn(pos)
end

function LinkageRenderService:ShowLinkNormal(pos)
  local pieceService = self._world:GetService("Piece")
  pieceService:SetPieceAnimNormal(pos)
end

function LinkageRenderService:CreateLinkDot(pos, idx, pieceType)
  local entityPoolService = self._world:GetService("EntityPool")
  local entityConfigId = self:_GetLinkDotRenderIDByPieceType(pieceType)
  local dotEntity = entityPoolService:GetCacheEntityByConfigID(entityConfigId)
  dotEntity:SetLocation(pos, Vector2(1, 0))
  dotEntity:ReplaceLinkLineIndex(idx)
  local linkLineIndexCmp = dotEntity:LinkLineIndex()
  if linkLineIndexCmp then
    linkLineIndexCmp:SetEntityConfigId(entityConfigId)
  end
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  linkRendererDataCmpt:AddLinkageNumEntity(dotEntity)
  return dotEntity
end

function LinkageRenderService:_GetLinkDotRenderIDByPieceType(pieceType)
  local res = EntityConfigIDRender.LinkGridDot_Any
  if pieceType == PieceType.Red then
    res = EntityConfigIDRender.LinkGridDot_Red
  elseif pieceType == PieceType.Green then
    res = EntityConfigIDRender.LinkGridDot_Green
  elseif pieceType == PieceType.Blue then
    res = EntityConfigIDRender.LinkGridDot_Blue
  elseif pieceType == PieceType.Yellow then
    res = EntityConfigIDRender.LinkGridDot_Yellow
  end
  return res
end

function LinkageRenderService:DestroyAllLinkedNum()
  local entityPoolService = self._world:GetService("EntityPool")
  local linkRendererDataCmpt = self:GetLinkRenderDataComponent()
  local allEntities = linkRendererDataCmpt:GetLinkageNumEntityList()
  local remove_list = {}
  for _, linkageNumEntity in ipairs(allEntities) do
    table.insert(remove_list, linkageNumEntity)
  end
  for _, e in ipairs(remove_list) do
    self:DestroyLinkNum(e)
  end
end

function LinkageRenderService:DestroyLinkedGridEffect()
  local gridEffectGroup = self._world:GetGroup(self._world.BW_WEMatchers.GridEffect)
  local remove_list = {}
  for _, gridEffectEntity in ipairs(gridEffectGroup:GetEntities()) do
    local gridEffectCmpt = gridEffectEntity:GridEffect()
    local gridEffectType = gridEffectCmpt:GetGridEffectType()
    if gridEffectType == "InPath" then
      table.insert(remove_list, gridEffectEntity)
    end
  end
  for _, e in ipairs(remove_list) do
    self._world:DestroyEntity(e)
  end
end

function LinkageRenderService:ClearLinkRender()
  self:ClearLinkageInfo()
  self:DestroyTouchPosEffect()
  self:_DisablePreviewChainSkillRange()
  self:HideBenumbTips()
  self:HideTrapWallBlock()
end

function LinkageRenderService:ClearLinkageInfo()
  local linkageGroup = self._world:GetGroup(self._world.BW_WEMatchers.LinkageInfo)
  for _, linkageEntity in ipairs(linkageGroup:GetEntities()) do
    linkageEntity:LinkageInfo():SetLinkCount(0)
  end
end

function LinkageRenderService:DestroyTouchPosEffect()
  local gridEffectGroup = self._world:GetGroup(self._world.BW_WEMatchers.GridEffect)
  for _, gridEffectEntity in ipairs(gridEffectGroup:GetEntities()) do
    local gridEffectCmpt = gridEffectEntity:GridEffect()
    local gridEffectType = gridEffectCmpt:GetGridEffectType()
    if gridEffectType == "TouchPos" then
      self._world:DestroyEntity(gridEffectEntity)
      break
    end
  end
end

function LinkageRenderService:_DisablePreviewChainSkillRange()
  local reBoard = self._world:GetRenderBoardEntity()
  local previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
  previewChainSkillRangeCmpt:EnablePreviewChainSkillRange(false)
  local chainPreviewMonsterBehaviorCmpt = reBoard:ChainPreviewMonsterBehavior()
  chainPreviewMonsterBehaviorCmpt:SetChainPath({})
end

function LinkageRenderService:ShowBenumbTips(endPos, pieceType)
  local buffC = self._world:Player():GetPreviewTeamEntity():BuffView()
  if not buffC:HasBuffEffect(BuffEffectType.Benumb) then
    return
  end
  local effectService = self._world:GetService("Effect")
  local utilDataSvc = self._world:GetService("UtilData")
  local previewEntity = self._world:GetPreviewEntity()
  local previewEnv = previewEntity:PreviewEnv()
  self._world:EventDispatcher():Dispatch(GameEventType.ShowHideBenumbTips, true)
  local roundPosList = utilDataSvc:GetRoundGrid(endPos)
  for _, pos in ipairs(roundPosList) do
    local piece_type = previewEnv:GetPieceType(pos)
    if CanMatchPieceType(pieceType, piece_type) and utilDataSvc:IsValidPiecePos(pos) and not utilDataSvc:IsPosBlockLinkLineForChain(pos) then
      local effEntity = effectService:CreateWorldPositionEffect(BattleConst.BenumbGridEffectID, Vector2(pos.x, pos.y), true)
      effEntity:AddBenumbEffect()
    end
  end
end

function LinkageRenderService:HideBenumbTips()
  local playerPreviewTeamEntity = self._world:Player():GetPreviewTeamEntity()
  if not playerPreviewTeamEntity then
    return
  end
  local buffC = playerPreviewTeamEntity:BuffView()
  if not buffC:HasBuffEffect(BuffEffectType.Benumb) then
    return
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ShowHideBenumbTips, false)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.BenumbEffect)
  for i, e in ipairs(group:GetEntities()) do
    self._world:DestroyEntity(e)
  end
end

function LinkageRenderService:ShowTrapWallBlock(chainPath, pieceType)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderTrapWallComponent = renderBoardEntity:RenderTrapWall()
  if not renderTrapWallComponent then
    return
  end
  local trapWallPosList = renderTrapWallComponent:GetTrapWallPosList()
  if not trapWallPosList or table.count(trapWallPosList) == 0 then
    return
  end
  self:HideTrapWallBlock()
  local effectService = self._world:GetService("Effect")
  local utilDataSvc = self._world:GetService("UtilData")
  local previewEntity = self._world:GetPreviewEntity()
  local previewEnv = previewEntity:PreviewEnv()
  local posEnd = chainPath[#chainPath]
  local roundPosList = utilDataSvc:GetRoundGrid(posEnd)
  for _, pos in ipairs(roundPosList) do
    if not table.icontains(chainPath, Vector2(pos.x, pos.y)) then
      local piece_type = previewEnv:GetPieceType(pos)
      local canMatchPieceType = CanMatchPieceType(pieceType, piece_type)
      if pieceType == PieceType.None then
        canMatchPieceType = true
      end
      if self:IsNeedShowLinkageNumForCostStep() then
        canMatchPieceType = true
      end
      if canMatchPieceType and utilDataSvc:IsValidPiecePos(pos) and not utilDataSvc:IsPosBlockLinkLineForChain(pos) and utilDataSvc:IsPosBlockMoveForTrapWall(posEnd, pos) then
        local effEntity = effectService:CreateWorldPositionEffect(BattleConst.TrapWallBlockGridEffectID, Vector2(pos.x, pos.y), true)
        renderTrapWallComponent:AddBlockEffectEntityID(effEntity:GetID())
      end
    end
  end
end

function LinkageRenderService:HideTrapWallBlock()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderTrapWallComponent = renderBoardEntity:RenderTrapWall()
  if not renderTrapWallComponent then
    return
  end
  local blockEffectEntityIDList = renderTrapWallComponent:GetBlockEffectEntityIDList()
  if not blockEffectEntityIDList or table.count(blockEffectEntityIDList) == 0 then
    return
  end
  for _, effectEntityID in ipairs(blockEffectEntityIDList) do
    local effectEntity = self._world:GetEntityByID(effectEntityID)
    if effectEntity then
      self._world:DestroyEntity(effectEntity)
    end
  end
  renderTrapWallComponent:ClearBlockEffectEntityIDList()
end

function LinkageRenderService:ResetLinkLineEntity(e)
  local viewCmpt = e:View()
  if not viewCmpt then
    Log.fatal("re1 ID:", e:GetID())
    return
  end
  local gameObj = viewCmpt.ViewWrapper.GameObject
  if not gameObj then
    Log.fatal("re2 ID:", e:GetID())
    return
  end
  local lineRender = gameObj:GetComponent("LineRenderer")
  if lineRender == nil then
    lineRender = gameObj:GetComponentInChildren(typeof(UnityEngine.LineRenderer))
    if lineRender == nil then
      Log.fatal("Line render is null ID:", e:GetID())
      return
    end
  end
  local pos = Vector3(0, 1000, 0)
  lineRender:SetPosition(0, pos)
  lineRender:SetPosition(1, pos)
  e:ReplaceLinkLineRender(pos, pos)
end

function LinkageRenderService:AssembleChainPath(e)
  local linkLineRenderCmpt = e:LinkLineRender()
  local headPos = linkLineRenderCmpt:GetHeadPos()
  local endPos = linkLineRenderCmpt:GetEndPos()
  local viewCmpt = e:View()
  if not viewCmpt then
    return
  end
  local gameObj = viewCmpt.ViewWrapper.GameObject
  local lineRender = gameObj:GetComponent("LineRenderer")
  if lineRender == nil then
    lineRender = gameObj:GetComponentInChildren(typeof(UnityEngine.LineRenderer))
    if lineRender == nil then
      Log.fatal("Line render is null")
      return
    end
  end
  gameObj.transform.rotation = Quaternion.Euler(90, 0, 0)
  lineRender:SetPosition(0, headPos)
  lineRender:SetPosition(1, endPos)
end

function LinkageRenderService:GetLinkRenderDataComponent()
  local reBoard = self._world:GetRenderBoardEntity()
  return reBoard:LinkRendererData()
end

function LinkageRenderService:ShowLinkageInfoForPopStarPro(chainPath)
  if #chainPath <= 0 then
    self:_ClearLinkageInfo()
    self:_DisablePreviewChainSkillRange()
    return
  end
  local showPos = chainPath[1]
  local hudWorldPos = self:_CalcGridHUDWorldPos(showPos)
  if hudWorldPos == nil then
    return
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local chainCount = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, #chainPath)
  chainCount = chainCount + 1
  local linkageGroup = self._world:GetGroup(self._world.BW_WEMatchers.LinkageInfo)
  if 1 < #chainPath then
    for _, linkageEntity in ipairs(linkageGroup:GetEntities()) do
      local linkageInfoCmpt = linkageEntity:LinkageInfo()
      linkageEntity:SetViewVisible(true)
      linkageInfoCmpt:SetLinkCount(chainCount, true)
      linkageInfoCmpt:SetLinkagePos(hudWorldPos)
    end
    local reBoard = self._world:GetRenderBoardEntity()
    local previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
    previewChainSkillRangeCmpt:EnablePreviewChainSkillRange(true)
  else
    for _, linkageEntity in ipairs(linkageGroup:GetEntities()) do
      linkageEntity:SetViewVisible(false)
    end
  end
end
