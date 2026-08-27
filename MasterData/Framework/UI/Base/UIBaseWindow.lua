UIBaseWindow = class("UIBaseWindow", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UIBaseWindow:ctor()
  self.__typeID = nil
end

function UIBaseWindow:GetUIWindowTypeId()
  return self.__typeID
end

function UIBaseWindow:Init(root)
  self.__permanent = false
  base.Init(self, root)
end

function UIBaseWindow:Delete(isImmeDelete)
  if self.treeDCanvas ~= nil then
    DestroyUnityObject(self.treeDCanvas)
  end
  UIManager:DeleteWindow(self.__typeID, isImmeDelete)
end

function UIBaseWindow:GetWindowSortingLayer()
  local uiconfig = UIWindowGlobalConfig[self.__typeID]
  return UIManager:GetSortingLayerName(uiconfig.LayoutLevel + 1)
end

local cs_ScreenSpaceCamera = CS.UnityEngine.RenderMode.ScreenSpaceCamera
local cs_WorldSpace = CS.UnityEngine.RenderMode.WorldSpace
local cs_Canvas = CS.UnityEngine.Canvas
local cs_UIManager = CS.UIManager.Instance

function UIBaseWindow:AlignToFakeCamera(camera, newWorldCamera)
  if self.canvas == nil then
    self.canvas = camera.transform:GetComponentInChildren(typeof(cs_Canvas))
  end
  local canvasScale = self.canvas:FindComponent(eUnityComponentID.CanvasScaler)
  self.canvas.worldCamera = camera
  self.canvas.renderMode = cs_ScreenSpaceCamera
  cs_UIManager:AdaptationCanvasScaler(canvasScale, true)
  self.transform:SetParent(self.canvas.transform, false)
  cs_Canvas.ForceUpdateCanvases()
  self.canvas.renderMode = cs_WorldSpace
  if newWorldCamera then
    self.canvas.worldCamera = newWorldCamera
  else
    self.canvas.worldCamera = CS.UnityEngine.Camera.main
  end
  cs_UIManager:SetNotchTransfrom(self.transform)
end

function UIBaseWindow:SetWindows2TreeDCanvas(layerID)
  local function coroutineFunc(objCanvas)
    self.treeDCanvas = objCanvas
    
    local canvasScale = objCanvas:FindComponent(eUnityComponentID.CanvasScaler)
    local treeDCanvas = objCanvas:FindComponent(eUnityComponentID.Canvas)
    treeDCanvas.worldCamera = cs_UIManager.UICamera
    treeDCanvas.renderMode = cs_ScreenSpaceCamera
    cs_UIManager:AdaptationCanvasScaler(canvasScale, true)
    self.transform:SetParent(treeDCanvas.transform, false)
    cs_Canvas.ForceUpdateCanvases()
    treeDCanvas.renderMode = cs_WorldSpace
    treeDCanvas.worldCamera = cs_UIManager.UICamera
    treeDCanvas.sortingLayerName = UIManager:GetSortingLayerName(layerID + 1)
    cs_UIManager:SetNotchTransfrom(self.transform)
  end
  
  UIManager:CreateThreeDCanvas(self.__typeID, coroutineFunc, self.gameObject.name)
end

function UIBaseWindow:WinNextWithoutSound()
  self._nextWithoutSound = true
end

function UIBaseWindow:OnShow()
  base.OnShow(self)
  if self.winTween ~= nil then
    self.winTween:SetEase(cs_Ease.OutExpo)
    self.winTween:Restart()
  else
    self:__InitTween()
  end
  local uiconfig = UIWindowGlobalConfig[self.__typeID]
  if uiconfig.ShowWinAuId ~= nil and not self._nextWithoutSound then
    AudioManager:PlayAudioById(uiconfig.ShowWinAuId)
  end
  self._nextWithoutSound = nil
end

function UIBaseWindow:OnHide()
  if not UIManager:InDeleteAllWindow() then
    local uiconfig = UIWindowGlobalConfig[self.__typeID]
    if uiconfig.HideWinAuId ~= nil and not self._nextWithoutSound then
      AudioManager:PlayAudioById(uiconfig.HideWinAuId)
    end
  end
  self._nextWithoutSound = nil
  base.OnHide(self)
end

local function GetWindowCoverId(self)
  local coverId = "wid_" .. tostring(self.__typeID)
  return coverId
end

local WindowAnimaFuncs = {
  [EUIAnimaType.Fade] = function(self)
    self.winTween:Append(self.ui.canvasGroup:DOFade(0, 0.5):From())
  end,
  [EUIAnimaType.FadeScaleUp] = function(self)
    self.winTween:Append(self.ui.canvasGroup:DOFade(0, 0.5):From())
    self.winTween:Join(self.transform:DOScale(1.2, 0.5):From())
  end,
  [EUIAnimaType.FadeScaleDown] = function(self)
    local coverId = GetWindowCoverId(self)
    self.__wcoverId = coverId
    UIUtil.AddOneCover(coverId)
    UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
    self.winTween:Append(self.ui.canvasGroup:DOFade(0, 0.5):From())
    self.winTween:Join(self.transform:DOScale(0.4, 0.5):From())
    self.winTween:OnComplete(function()
      UIUtil.CloseOneCover(coverId)
    end)
  end,
  [EUIAnimaType.ScaleUp] = function(self)
    self.winTween:Append(self.transform:DOScale(1.2, 0.5):From())
  end,
  [EUIAnimaType.SlowScaleUp] = function(self)
    self.winTween:Append(self.transform:DOScale(1.1, 0.5):From())
  end,
  [EUIAnimaType.FadeScaleBottomLeft] = function(self)
    local coverId = GetWindowCoverId(self)
    self.__wcoverId = coverId
    UIUtil.AddOneCover(coverId)
    self.transform.pivot = Vector2.zero
    self.winTween:Append(self.ui.canvasGroup:DOFade(0, 0.5):From())
    self.winTween:Join(self.transform:DOScale(0.2, 0.5):From())
    self.winTween:OnComplete(function()
      UIUtil.CloseOneCover(coverId)
    end)
  end,
  [EUIAnimaType.FadeScaleTopLeft] = function(self)
    local coverId = GetWindowCoverId(self)
    self.__wcoverId = coverId
    UIUtil.AddOneCover(coverId)
    self.transform.pivot = Vector2.New(0, 1)
    self.winTween:Append(self.ui.canvasGroup:DOFade(0, 0.5):From())
    self.winTween:Join(self.transform:DOScale(0.2, 0.5):From())
    self.winTween:OnComplete(function()
      UIUtil.CloseOneCover(coverId)
    end)
  end,
  [EUIAnimaType.FadeScaleBottomRight] = function(self)
    local coverId = GetWindowCoverId(self)
    self.__wcoverId = coverId
    UIUtil.AddOneCover(coverId)
    self.transform.pivot = Vector2.New(1, 0)
    self.winTween:Append(self.ui.canvasGroup:DOFade(0, 0.5):From())
    self.winTween:Join(self.transform:DOScale(0.2, 0.5):From())
    self.winTween:OnComplete(function()
      UIUtil.CloseOneCover(coverId)
    end)
  end
}

function UIBaseWindow:__PlayUITween(animaSpecialType)
  if self.__typeID == nil then
    return
  end
  local animaType = animaSpecialType or self.__winAnima
  if animaType == nil then
    return
  end
  local tween = self.winTween
  self.winTween = cs_DoTween.Sequence()
  local animaFunc = WindowAnimaFuncs[animaType]
  animaFunc(self)
  self.winTween:SetEase(cs_Ease.OutQuart)
  self.winTween:SetAutoKill(true)
  self.winTween:SetUpdate(true)
  self.winTween:SetLink(self.transform.gameObject)
  self.winTween.target = self.transform
  self.winTween = tween
end

function UIBaseWindow:__InitTween()
  if self.__typeID == nil then
    return
  end
  local animaType = self.__winAnima
  if animaType == nil then
    return
  end
  self.winTween = cs_DoTween.Sequence()
  local animaFunc = WindowAnimaFuncs[animaType]
  animaFunc(self)
  self.winTween:SetEase(cs_Ease.OutQuart)
  self.winTween:SetAutoKill(false)
  self.winTween:SetUpdate(true)
  self.winTween.target = self.transform
end

function UIBaseWindow:CloseTween(resloader)
  if self.ui.canvasGroup ~= nil then
    self.ui.canvasGroup.blocksRaycasts = false
  end
  self.winTween:SetEase(cs_Ease.InExpo)
  self.winTween:OnRewind(function()
    if self.__wcoverId ~= nil then
      UIUtil.CloseOneCover(self.__wcoverId)
    end
    self.winTween:Kill()
    self.winTween = nil
    self:OnCloseTween()
    UIManager:RecycleWindowEntity(resloader, self)
  end)
  if self.__wcoverId ~= nil then
    UIUtil.AddOneCover(self.__wcoverId)
  end
  self.winTween:Complete()
  self.winTween:PlayBackwards()
end

function UIBaseWindow:OnCloseTween()
end

function UIBaseWindow:SwitchFakeCanvasScreen()
  if self.canvas == nil then
    return
  end
  self.canvas.renderMode = cs_ScreenSpaceCamera
end

function UIBaseWindow:SwitchFakeCanvasWorld()
  if self.canvas == nil then
    return
  end
  self.canvas.renderMode = cs_WorldSpace
end

function UIBaseWindow:SetFromWhichUI(fromType)
  self.fromType = fromType
end

function UIBaseWindow:GenCoverJumpReturnCallback()
  return nil
end

function UIBaseWindow:SetWindowPermanent(isPermanent)
  self.__permanent = isPermanent
end

function UIBaseWindow:OnCloseWin()
  if self.fromType == nil or self.fromType <= 0 then
    return
  end
  if self.fromType & eBaseWinFromWhere.home == eBaseWinFromWhere.home then
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then
      homeWin:BackFromOtherWin()
    end
  end
  if self.fromType & eBaseWinFromWhere.homeCorver == eBaseWinFromWhere.homeCorver then
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then
      homeWin:BackFromOtherCoverWin()
    end
  end
  if self.fromType & eBaseWinFromWhere.jumpCorver == eBaseWinFromWhere.jumpCorver and self.jumpCorverArgs ~= nil then
    local hadledDic = {}
    local JumpManager = require("Game.Jump.JumpManager")
    for _, winTypeId in ipairs(CoverJumpReturnOrder) do
      for index, winData in pairs(self.jumpCorverArgs.hideWinList) do
        if winData.win ~= nil and winData.win.gameObject ~= nil and winData.win:GetUIWindowTypeId() == winTypeId then
          local notNeedShow = false
          if winData.returnCallback ~= nil then
            notNeedShow = winData.returnCallback()
          end
          if not notNeedShow then
            winData.win:Show()
          end
          hadledDic[index] = true
          break
        end
      end
    end
    for index, winData in pairs(self.jumpCorverArgs.hideWinList) do
      if not hadledDic[index] and winData.win ~= nil and winData.win.gameObject ~= nil then
        local notNeedShow = false
        if winData.returnCallback ~= nil then
          notNeedShow = winData.returnCallback()
        end
        if not notNeedShow then
          winData.win:Show()
        end
      end
    end
    if self.jumpCorverArgs.befroeJumpCouldUseItemJump ~= nil then
      JumpManager.couldUseItemJump = self.jumpCorverArgs.befroeJumpCouldUseItemJump
    end
  end
end

function UIBaseWindow:AutoDeleteTopStatus()
  return UIUtil.CheckTopWindowAndClear(self.__typeID)
end

function UIBaseWindow:OnDelete()
  if self.settedTopStatus and not self.isHandledTopStatus then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  UIBaseNode.OnDelete(self)
end

return UIBaseWindow
