_class("UIHomelandMinimapIconBase", UICustomWidget)
UIHomelandMinimapIconBase = UIHomelandMinimapIconBase

function UIHomelandMinimapIconBase:InternalInitialize(iconData, minimapStatus, isIconList)
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local uiHomelandModule = homelandModule:GetUIModule()
  local homelandClient = uiHomelandModule:GetClient()
  self._miniMapManager = homelandClient:GetMinimapManager()
  self._isIconList = isIconList and true
  if not self._isIconList then
    if self._addExpansionCallback == nil then
      self._addExpansionCallback = GameHelper:GetInstance():CreateCallback(self.AddIconMarkHandler, self)
      GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnAddMinimapIconMark, self._addExpansionCallback)
    end
    if self._initExpansionCallback == nil then
      self._initExpansionCallback = GameHelper:GetInstance():CreateCallback(self.InitIconMarkHandler, self)
      GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnInitMinimapIconMark, self._initExpansionCallback)
    end
    if self._removeExpansionCallback == nil then
      self._removeExpansionCallback = GameHelper:GetInstance():CreateCallback(self.RemoveIconMarkHandler, self)
      GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnRemoveMinimapIconMark, self._removeExpansionCallback)
    end
  end
  self.anim = self:GetUIComponent("Animation", "Anim")
  self.markEffect = self:GetGameObject("MarkEffect")
  self._iconData = iconData
  self:OnInitDone(minimapStatus)
  if self._isIconList then
    self:OnIconInListInit()
  end
  if not self._isIconList then
    local markType = self._iconData:GetMarkType()
    local markId = self._iconData:GetMarkId()
    if markType and markId and self:CanShowIconMark(markType, markId) then
      self:ShowMarkEffect()
    end
  end
end

function UIHomelandMinimapIconBase:Release()
  if not self._isIconList then
    if self._addExpansionCallback then
      GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnAddMinimapIconMark, self._addExpansionCallback)
      self._addExpansionCallback = nil
    end
    if self._initExpansionCallback then
      GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnInitMinimapIconMark, self._initExpansionCallback)
      self._initExpansionCallback = nil
    end
    if self._removeExpansionCallback then
      GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnRemoveMinimapIconMark, self._removeExpansionCallback)
      self._removeExpansionCallback = nil
    end
  end
end

function UIHomelandMinimapIconBase:AddIconMarkHandler(type, id)
  if self._isIconList then
    return
  end
  if not self:IsMarkSelf(type, id) then
    return
  end
  self._miniMapManager:SetIconMarkStatus(type, id, false)
  self:ShowMarkEffect()
  local minimap = self._iconData:GetMinimap()
  minimap:AddMarkIcon(self._iconData)
  self._iconData:SetMarkType(type)
  self._iconData:SetMarkId(id)
end

function UIHomelandMinimapIconBase:InitIconMarkHandler(type, id)
  if self._isIconList then
    return
  end
  if not self:IsMarkSelf(type, id) then
    return
  end
  if not self:CanShowIconMark(type, id) then
    self._iconData:SetMarkType(nil)
    self._iconData:SetMarkId(nil)
    return
  end
  self:ShowMarkEffect()
  local minimap = self._iconData:GetMinimap()
  minimap:InitMarkIcon(self._iconData)
  self._iconData:SetMarkType(type)
  self._iconData:SetMarkId(id)
end

function UIHomelandMinimapIconBase:RemoveIconMarkHandler(type, id)
  if self._isIconList then
    return
  end
  if not self:IsMarkSelf(type, id) then
    return
  end
  self._miniMapManager:SetIconMarkStatus(type, id, false)
  self:HideMarkEffect()
  local minimap = self._iconData:GetMinimap()
  minimap:RemoveMarkIcon(self._iconData)
  self._iconData:SetMarkType(nil)
  self._iconData:SetMarkId(nil)
end

function UIHomelandMinimapIconBase:ShowMarkEffect()
  if self.markEffect then
    self.markEffect:SetActive(true)
  end
end

function UIHomelandMinimapIconBase:HideMarkEffect()
  if self.markEffect then
    self.markEffect:SetActive(false)
  end
end

function UIHomelandMinimapIconBase:IsMarkSelf(type, id)
  return false
end

function UIHomelandMinimapIconBase:CanShowIconMark(type, id)
  return self._miniMapManager:GetIconMarkStatus(type, id) == false
end

function UIHomelandMinimapIconBase:GetIconData()
  return self._iconData
end

function UIHomelandMinimapIconBase:BtnOnClick()
  if self._isIconList then
    return
  end
  if not self._iconData:GetCanClick() then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapClickIcon, self)
  local markType = self._iconData:GetMarkType()
  local markId = self._iconData:GetMarkId()
  if markType and markId then
    self._miniMapManager:SetIconMarkStatus(markType, markId, true)
    self:HideMarkEffect()
  end
end

function UIHomelandMinimapIconBase:OnInitDone(minimapStatus)
end

function UIHomelandMinimapIconBase:Selected()
  local animation = self:GetAnimation()
  self:OnSelected()
  if animation then
    local animName = self:GetAnimationName(MinimapIconAnimationType.SELECT)
    if animName ~= nil and animName ~= "" then
      animation:Play(animName)
    end
  end
end

function UIHomelandMinimapIconBase:UnSelected()
  local animation = self:GetAnimation()
  if animation then
    local animName = self:GetAnimationName(MinimapIconAnimationType.UNSELECT)
    if animName ~= nil and animName ~= "" then
      animation:Play(animName)
    end
  else
    self:OnUnSelected()
  end
end

function UIHomelandMinimapIconBase:OnSelected()
  Log.error("选中")
end

function UIHomelandMinimapIconBase:OnUnSelected()
  Log.error("取消选中")
end

function UIHomelandMinimapIconBase:OnMutilSelected(minimap)
  minimap:SetMultiSelectCircleStatus(true, self:GetMutilSelectedPosition())
end

function UIHomelandMinimapIconBase:OnMutilUnSelected(minimap)
  minimap:SetMultiSelectCircleStatus(false, nil)
end

function UIHomelandMinimapIconBase:GetMutilSelectedPosition()
  local go = self:GetGameObject()
  return go.transform.position
end

function UIHomelandMinimapIconBase:GetIconMultiSelectPositionOffset()
  return Vector2(0, 0)
end

function UIHomelandMinimapIconBase:CanShow()
  return false
end

function UIHomelandMinimapIconBase:GetShowIconOffset()
  return Vector2(0, 0)
end

function UIHomelandMinimapIconBase:GetShowName()
  return self._iconData:GetShowName()
end

function UIHomelandMinimapIconBase:OnIconInListInit()
end

function UIHomelandMinimapIconBase:GetAnimation()
  return self.anim
end

function UIHomelandMinimapIconBase:GetAnimationName(animType)
  return ""
end
