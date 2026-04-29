local openBeautifulSide = false
_class("UIResolution", Object)
UIResolution = UIResolution

function UIResolution:Constructor(uiLayerManager)
  self.uiResolutionHelper = UIResolutionHelper:New(uiLayerManager.layerManagerHelper)
  self.uiResolutionHelper:SetBlackSideVisible(false)
  self.uiImgWidth = 0
  if not _G.APPVER1220 then
    openBeautifulSide = true
    self.uiResolutionHelper:SetBlackSideVisible(true)
  end
  if not openBeautifulSide then
    return
  end
  if not _G.APPVER1220 then
    self:RefreshBeautifulSideTB()
  end
  local imgLeft = self.uiResolutionHelper:GetRTOfLeftBlackImage()
  local imgRight = self.uiResolutionHelper:GetRTOfRightBlackImage()
  local defaultBangWidth = ResolutionManager.BangWidth()
  self:RefreshBeautifulSideLR(defaultBangWidth, imgLeft, imgRight)
  self.cb = GameHelper:GetInstance():CreateCallback(function(bangWidth)
    self:RefreshBeautifulSideLR(bangWidth, imgLeft, imgRight)
  end)
  self.cb2 = GameHelper:GetInstance():CreateCallback(function()
    self:RefreshBeautifulSideLR(ResolutionManager.BangWidth(), imgLeft, imgRight)
    if not _G.APPVER1220 then
      self:RefreshBeautifulSideTB()
    end
  end)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIBangWidthChange, self.cb)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIBlackChange, self.cb2)
end

function UIResolution:Dispose()
  self.uiResolutionHelper:Dispose()
  if not openBeautifulSide then
    return
  end
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIBangWidthChange, self.cb)
end

function UIResolution:RefreshBeautifulSideLR(bangWidth, imgLeft, imgRight)
  if bangWidth < ResolutionManager.BlackWidth() then
    return
  end
  self.uiImgWidth = bangWidth
  local y = imgLeft.sizeDelta.y
  imgLeft.sizeDelta = Vector2(bangWidth, y)
  imgRight.sizeDelta = Vector2(bangWidth, y)
end

function UIResolution:RefreshBeautifulSideTB()
  local imgTop = self.uiResolutionHelper:GetRTOfTopBlackImage()
  local imgBottom = self.uiResolutionHelper:GetRTOfBottomBlackImage()
  local imgHeight = ResolutionManager.BlackHeight()
  if imgTop == nil or imgBottom == nil then
    Log.error("UIResolution:RefreshBeautifulSideTB,imgTop is nil or imgBottom is nil")
    return
  end
  if imgHeight < 0 then
    imgHeight = 0
  end
  Log.debug("处理上下黑边, 黑边高=", imgHeight)
  local x = imgTop.sizeDelta.x
  imgTop.sizeDelta = Vector2(x, imgHeight)
  imgBottom.sizeDelta = Vector2(x, imgHeight)
end

function UIResolution:SetBlackSideVisible(visible)
  if not openBeautifulSide then
    return
  end
  if not _G.APPVER1220 then
    return
  end
  if ResolutionManager.IsAspectOutofSupport() then
    Log.debug("[UIResolution] 当前设备宽高比不在支持范围内，不允许控制黑边")
    return
  end
  self.uiResolutionHelper:SetBlackSideVisible(false)
end

function UIResolution:SetBlackSideVisibleForce(visible)
  if not openBeautifulSide then
    return
  end
  if not _G.APPVER1220 then
    self.uiResolutionHelper:SetBlackSideVisible(true)
    return
  end
  self.uiResolutionHelper:SetBlackSideVisible(false)
end

function UIResolution:SetForceCloseBlackSideVisible(visible)
  self.uiResolutionHelper:SetBlackSideVisible(visible)
end
