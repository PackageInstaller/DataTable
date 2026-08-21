require("guide_svc_r")

function GuideServiceRender:IsGuidePreviewLineLineInvokeType()
  return self:GetPLLInvokeType() == GuideInvokeType.GuidePreviewLinkLine
end

function GuideServiceRender:GetPLLInvokeType()
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePLLCmpt = reBoard:GuidePreviewLinkLine()
  return guidePLLCmpt and guidePLLCmpt:GetInvokeType() or GuideInvokeType.None
end

function GuideServiceRender:ShowPLLGuideLine(guideParam)
  self:_ShowPLLGuideLine(GuideRefreshType.StartGuidePath, guideParam)
end

function GuideServiceRender:_ShowPLLGuideLine(guideRefreshType, guideParam)
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePLLCmpt = reBoard:GuidePreviewLinkLine()
  local curGuideRefreshType = guidePLLCmpt:GetGuideRefreshType()
  if curGuideRefreshType ~= GuideRefreshType.StartGuidePath then
    if guideParam then
      local path = guideParam.LogicParams
      guidePLLCmpt:SetGuidePLLPath(path)
      guidePLLCmpt:SetInvokeType(guideParam.InvokeType)
    end
    guidePLLCmpt:SetGuideRefreshType(guideRefreshType)
    reBoard:ReplaceGuidePreviewLinkLine()
    self._eventDispatcher:Dispatch(GameEventType.ShowGuideMask, true)
  end
end

function GuideServiceRender:HandlePLLCameraMoveToNormalTrigger()
  local invokeType = self:GetPLLInvokeType()
  if invokeType ~= GuideInvokeType.GuidePreviewLinkLine then
    return false
  end
  local previewEntity = self._world:GetPreviewEntity()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  local finishGuide = self:CheckGuidePLLPathFinish(chainPath)
  if finishGuide == false then
    local previewEntity = self._world:GetPreviewEntity()
    previewEntity:ReplacePreviewLinkLine({}, PieceType.None, PieceType.None)
    local linkLineSvc = self._world:GetService("PreviewLinkLine")
    linkLineSvc:NotifyPickUpTargetChange()
    self:_ReShowPLLGuideLine()
    return true
  end
  return false
end

function GuideServiceRender:CheckGuidePLLPathFinish(chainPath)
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePLLCmpt = reBoard:GuidePreviewLinkLine()
  local guidePath = guidePLLCmpt:GetGuidePLLPath()
  if chainPath == nil or guidePath == nil then
    return true
  end
  if #chainPath ~= #guidePath then
    return false
  end
  for index, pathPoint in ipairs(chainPath) do
    local curGuidePoint = guidePath[index]
    if curGuidePoint ~= pathPoint then
      return false
    end
  end
  return true
end

function GuideServiceRender:_ReShowPLLGuideLine()
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePLLCmpt = reBoard:GuidePreviewLinkLine()
  guidePLLCmpt:SetGuideRefreshType(GuideRefreshType.RestartGuidePath)
  reBoard:ReplaceGuidePreviewLinkLine()
end

function GuideServiceRender:HandlePLLCameraMoveToFocusTrigger()
  local invokeType = self:GetPLLInvokeType()
  if invokeType ~= GuideInvokeType.GuidePreviewLinkLine then
    return
  end
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePLLCmpt = reBoard:GuidePreviewLinkLine()
  local curGuideRefreshType = guidePLLCmpt:GetGuideRefreshType()
  if curGuideRefreshType ~= GuideRefreshType.ShowGuideLine then
    guidePLLCmpt:SetGuideRefreshType(GuideRefreshType.ShowGuideLine)
    reBoard:ReplaceGuidePreviewLinkLine()
  end
end

function GuideServiceRender:HandlePLLBeginDragTrigger(newGridPos)
  self:PauseGuideWeakLine()
  local invokeType = self:GetPLLInvokeType()
  if invokeType == GuideInvokeType.GuidePreviewLinkLine then
    local reBoard = self._world:GetRenderBoardEntity()
    local guidePLLCmpt = reBoard:GuidePreviewLinkLine()
    guidePLLCmpt:SetGuideRefreshType(GuideRefreshType.ShowGuideLine)
    reBoard:ReplaceGuidePreviewLinkLine()
    return self:_CheckGuidePLLHasPos(newGridPos)
  end
  return true
end

function GuideServiceRender:_CheckGuidePLLHasPos(gridPos)
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePLLCmpt = reBoard:GuidePreviewLinkLine()
  local guidePath = guidePLLCmpt:GetGuidePLLPath()
  if guidePath == nil then
    return false
  end
  for _, v in ipairs(guidePath) do
    if v == gridPos then
      return true
    end
  end
  return false
end

function GuideServiceRender:HandlePLLEndDragTrigger()
  local invokeType = self:GetPLLInvokeType()
  if invokeType == GuideInvokeType.GuidePreviewLinkLine then
    local previewEntity = self._world:GetPreviewEntity()
    local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
    local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
    local reBoard = self._world:GetRenderBoardEntity()
    local guidePLLCmpt = reBoard:GuidePreviewLinkLine()
    local finishGuide = self:CheckGuidePLLPathFinish(chainPath)
    if finishGuide == true then
      guidePLLCmpt:SetInvokeType(GuideInvokeType.None)
      guidePLLCmpt:SetGuideRefreshType(GuideRefreshType.StopGuidePath)
      guidePLLCmpt:SetGuidePLLPath({})
      reBoard:ReplaceGuidePreviewLinkLine()
      self._eventDispatcher:Dispatch(GameEventType.ShowGuideMask, false)
      self._eventDispatcher:Dispatch(GameEventType.FinishGuideStep, GuideType.PreviewLinkLine)
    else
      ToastManager.ShowToast(StringTable.Get("str_guide_link_warn"))
      return false
    end
  end
  return true
end

function GuideServiceRender:HandlePLLDragTrigger(newGridPos)
  local invokeType = self:GetPLLInvokeType()
  if invokeType ~= GuideInvokeType.GuidePreviewLinkLine then
    return true
  end
  local previewEntity = self._world:GetPreviewEntity()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  local newPosIndex = #chainPath + 1
  return self:_CheckChainPosMatchGuidePLLPath(newPosIndex, newGridPos)
end

function GuideServiceRender:_CheckChainPosMatchGuidePLLPath(index, gridPos)
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePLLCmpt = reBoard:GuidePreviewLinkLine()
  local guidePath = guidePLLCmpt:GetGuidePLLPath()
  if guidePath == nil then
    return false
  end
  if index > #guidePath then
    return false
  end
  local guidePoint = guidePath[index]
  if guidePoint ~= gridPos then
    return false
  end
  return true
end
