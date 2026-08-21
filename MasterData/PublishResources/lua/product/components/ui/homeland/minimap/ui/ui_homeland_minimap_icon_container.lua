local MinimapIconAnimationType = {
  IN = 1,
  OUT = 2,
  SELECT = 3,
  UNSELECT = 4,
  EXPANSION = 5
}
_enum("MinimapIconAnimationType", MinimapIconAnimationType)
_class("UIHomelandMinimapIconContainer", UICustomWidget)
UIHomelandMinimapIconContainer = UIHomelandMinimapIconContainer

function UIHomelandMinimapIconContainer:OnShow(uiParams)
  self._go = self:GetGameObject()
  self._tran = self._go.transform
  self._iconLoader = self:GetUIComponent("UISelectObjectPath", "IconLoader")
  self._iconTran = self:GetUIComponent("RectTransform", "IconLoader")
  self._iconWidget = nil
  self._isShow = false
  self._cachePosition = nil
  self._cacheMapPosition = nil
  self._cacheRotate = nil
  self._cacheScale = nil
end

function UIHomelandMinimapIconContainer:OnHide()
  self:Release()
end

function UIHomelandMinimapIconContainer:Update()
  self:UpdateTransform()
end

function UIHomelandMinimapIconContainer:UpdateTransform()
  if not self._iconData then
    return
  end
  if self._iconData:CanShow(self._miniMap:GetMapScale()) == false then
    self:SetStatus(false, true)
  else
    self:SetStatus(true, true)
  end
  local tran = self._iconData:GetTransform()
  if not tran or tran == null then
    return
  end
  local pos = tran.position
  if self._cachePosition == pos and self._cacheScale == self._miniMap:GetMapScale() then
    self._iconTran.anchoredPosition = self._cacheMapPosition
    if self._iconData:GetCanRotate() then
      self._iconTran.eulerAngles = self._cacheRotate
    end
    return
  end
  self._cachePosition = pos
  local len = HomelandMinimapConst.RealMapMaxPosition() - HomelandMinimapConst.RealMapMinPosition()
  local dis = pos - HomelandMinimapConst.RealMapMinPosition()
  local xPercent = dis.x / len.x
  local yPercent = dis.z / len.z
  local uiMapSize = HomelandMinimapConst.GetMapSize()
  local mapSizeX = uiMapSize.x * self._miniMap:GetMapScale()
  local mapSizeY = uiMapSize.y * self._miniMap:GetMapScale()
  self._cacheMapPosition = self._miniMap:GetMapCenterPosition() + Vector2(-mapSizeX / 2 + mapSizeX * xPercent, -mapSizeY / 2 + mapSizeY * yPercent)
  self._iconTran.anchoredPosition = self._cacheMapPosition
  if self._iconData:GetCanRotate() then
    self._cacheRotate = Vector3(0, 0, -tran.eulerAngles.y + 180)
    self._iconTran.eulerAngles = self._cacheRotate
  end
end

function UIHomelandMinimapIconContainer:CanShow()
  return self._iconWidget:CanShow()
end

function UIHomelandMinimapIconContainer:Init(minimap)
  self._miniMap = minimap
  self:SetStatus(false)
end

function UIHomelandMinimapIconContainer:SetStatus(status, playAnim)
  if self._isShow == status then
    return
  end
  if playAnim then
    local animation = self:GetAnimation()
    if not animation then
      self:GetGameObject():SetActive(status)
    else
      local animName = ""
      if status then
        animName = self:GetAnimationName(MinimapIconAnimationType.IN)
      else
        animName = self:GetAnimationName(MinimapIconAnimationType.OUT)
      end
      if animName ~= nil and animName ~= "" then
        if self._isShow ~= status then
          self:GetGameObject():SetActive(true)
          animation:Play(animName)
        end
      else
        self:GetGameObject():SetActive(status)
      end
    end
  else
    self:GetGameObject():SetActive(status)
  end
  self._isShow = status
end

function UIHomelandMinimapIconContainer:PlayIconShowAnim()
  if self._iconData:CanShow(self._miniMap:GetMapScale()) == false then
    self:SetStatus(false, false)
    return
  end
  local animation = self:GetAnimation()
  if animation then
    local animName = self:GetAnimationName(MinimapIconAnimationType.IN)
    if animName ~= nil and animName ~= "" then
      self:GetGameObject():SetActive(true)
      animation:Play(animName)
    end
  end
end

function UIHomelandMinimapIconContainer:PlayIconHideAnim()
  if self._iconData:CanShow(self._miniMap:GetMapScale()) == false then
    self:SetStatus(false, false)
    return
  end
  local animation = self:GetAnimation()
  if animation then
    local animName = self:GetAnimationName(MinimapIconAnimationType.OUT)
    if animName ~= nil and animName ~= "" then
      self:GetGameObject():SetActive(true)
      animation:Play(animName)
    end
  end
end

function UIHomelandMinimapIconContainer:Refresh(iconData)
  self._iconData = iconData
  self:Release()
  self._iconLoader.dynamicInfoOfEngine:SetObjectName(iconData:GetPrefabName())
  self._iconWidget = self._iconLoader:SpawnObject(iconData:GetScriptName())
  self._iconWidget:InternalInitialize(self._iconData, self._miniMap:GetMapStatus())
  self:SetStatus(true)
  self:UpdateTransform()
end

function UIHomelandMinimapIconContainer:Release()
  if self._iconWidget then
    self._iconWidget:Release()
  end
  self._isShow = false
  if self._iconLoader.uiCustomWidgets then
    local uiCustomWidgets = self._iconLoader.uiCustomWidgets
    for i = 1, #uiCustomWidgets do
      local uiCustomWidget = uiCustomWidgets[i]
      uiCustomWidget:UnLoad()
      uiCustomWidget:Dispose()
    end
    self._iconLoader.uiCustomWidgets = {}
  end
  self._iconWidget = nil
end

function UIHomelandMinimapIconContainer:GetIconPosition()
  return self._iconTran.anchoredPosition
end

function UIHomelandMinimapIconContainer:GetIconMultiSelectPosition()
  return self._iconTran.anchoredPosition + self:GetIconMultiSelectPositionOffset()
end

function UIHomelandMinimapIconContainer:GetIconMultiSelectPositionOffset()
  return self._iconWidget:GetIconMultiSelectPositionOffset()
end

function UIHomelandMinimapIconContainer:GetIconWorldPosition()
  return self._iconTran.position
end

function UIHomelandMinimapIconContainer:GetIconRotation()
  return self._iconTran.eulerAngles
end

function UIHomelandMinimapIconContainer:GetIconWidget()
  return self._iconWidget
end

function UIHomelandMinimapIconContainer:GetAnimation()
  return self._iconWidget:GetAnimation()
end

function UIHomelandMinimapIconContainer:GetAnimationName(animType)
  return self._iconWidget:GetAnimationName(animType)
end

function UIHomelandMinimapIconContainer:SetAsFirstSibling()
  self._tran:SetAsFirstSibling()
end

function UIHomelandMinimapIconContainer:SetAsLastSibling()
  self._tran:SetAsLastSibling()
end

function UIHomelandMinimapIconContainer:SetSiblingIndex(index)
  self._tran:SetSiblingIndex(index)
end

function UIHomelandMinimapIconContainer:GetIconData()
  return self._iconData
end
