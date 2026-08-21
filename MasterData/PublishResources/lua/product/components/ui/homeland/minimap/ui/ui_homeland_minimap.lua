local MinimapStatus = {
  None = 0,
  Mini = 1,
  Big = 2
}
_enum("MinimapStatus", MinimapStatus)
_class("UIHomelandMinimap", UICustomWidget)
UIHomelandMinimap = UIHomelandMinimap

function UIHomelandMinimap:OnShow(uiParams)
  self._updateFrame = 2
  self._perFrameUpdateCount = 5
  self._updateIndex = 1
  self._isPlaySwitchAnim = false
  self._markIconList = {}
  self._minimapWidth = 283
  self._minimapHeight = 283
  self._minimapOffset = Vector2(-29.8, -20.9)
  self._iconPoolCapacity = 50
  self._arrowCapacity = 10
  self._miniMapStatus = MinimapStatus.None
  self._currentSelectIcon = nil
  self._currentUseLoader = nil
  self._currentDetailUI = nil
  self._scaleStep = HomelandMinimapConst.GetMaxmapScaleSpeed()
  self._minScale = HomelandMinimapConst.GetMinScale()
  self._maxScale = HomelandMinimapConst.GetMaxScale()
  self._currentScale = HomelandMinimapConst.GetMinimapScale()
  self._playerContainer = nil
  self._scrollTran = self:GetUIComponent("RectTransform", "ScrollView")
  self._scrollMask = self:GetUIComponent("Mask", "ScrollView")
  self._scrollMaskImage = self:GetUIComponent("Image", "ScrollView")
  self._scroll = self:GetUIComponent("ScalableScrollRect", "ScrollView")
  self._btnOpenMapGo = self:GetGameObject("BtnOpenMap")
  self._btnCloseMapGo = self:GetGameObject("BtnCloseMap")
  self._bgTran = self:GetUIComponent("RectTransform", "BG")
  self._mapTran = self:GetUIComponent("RectTransform", "Map")
  self._bgLoader = self:GetUIComponent("RawImageLoader", "BG")
  self._mapLoader = self:GetUIComponent("RawImageLoader", "Map")
  self._contentTran = self:GetUIComponent("RectTransform", "Content")
  self._containers = self:GetUIComponent("UISelectObjectPath", "IconContainers")
  self._arrowsLoader = self:GetUIComponent("UISelectObjectPath", "Arrows")
  self._detailLoader1Loader = self:GetUIComponent("UISelectObjectPath", "DetailLoader1")
  self._detailLoader2Loader = self:GetUIComponent("UISelectObjectPath", "DetailLoader2")
  self._iconPools = {}
  self._icons = {}
  self._arrowPools = {}
  self._arrows = {}
  self._iconList = self:GetGameObject("IconList")
  self._iconList:SetActive(false)
  self._iconListLoader = self:GetUIComponent("UISelectObjectPath", "IconListLoader")
  self._circleOutline = self:GetGameObject("CircleOutline")
  self._multileSelectGo = self:GetGameObject("Circle")
  self._multileSelectGo:SetActive(false)
  self._isShowIconList = false
  self._multileTran = self:GetUIComponent("RectTransform", "Circle")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._anim2 = self:GetUIComponent("Animation", "Anim2")
  self._circleAnim = self:GetUIComponent("Animation", "CircleAnim")
  self._isPlayAddMarkIconAnim = false
  self._playAddMarkIconTimer = 0
  self._addMarkIconAnimLength = 850
  self._isPlayMarkIconAnim = false
  self._fx = self:GetGameObject("FX")
  self._markIconCountPanel = self:GetGameObject("MarkIconCountPanel")
  self._markIconMutile = self:GetGameObject("MarkIconMutile")
  self._markIconSingle = self:GetGameObject("MarkIconSingle")
  self._markIconCountLabel = self:GetUIComponent("UILocalizationText", "MarkIconCount")
  self._markIconCountPanel:SetActive(false)
  self:AttachEvent(GameEventType.MinimapClickIcon, self.IconClickedHandler)
  self:AttachEvent(GameEventType.MinimapAddIcon, self.AddIcon)
  self:AttachEvent(GameEventType.MinimapRemoveIcon, self.RemoveIcon)
  self:AttachEvent(GameEventType.MinimapCloseDetailUI, self.CloseDetailPanel)
  self:AttachEvent(GameEventType.MinimapUpdate, self.OnUpdate)
  self:Init()
  self:SwitchStatus(MinimapStatus.Mini)
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local uiHomelandModule = homelandModule:GetUIModule()
  self._homelandClient = uiHomelandModule:GetClient()
  local miniMapManager = self._homelandClient:GetMinimapManager()
  local datas = miniMapManager:GetIconData()
  if datas then
    for i = 1, #datas do
      local data = datas[i]
      self:AddIcon(data.id, data.index, data.transform, data.param)
    end
  end
  self._scroll:Init(Vector2(self._minScale, self._maxScale), self._scaleStep)
  if EDITOR or IsPc() then
    self:SetUIEventTrigger(self._mapTran.gameObject, UIEventTriggerType.Scroll, function(ped)
      if self._miniMapStatus == MinimapStatus.Big then
        local contentScale = Mathf.Clamp(self._currentScale + ped.scrollDelta.y * self._scaleStep * UnityEngine.Time.deltaTime, self._minScale, self._maxScale)
        self._scroll:UpdateContentScale(contentScale)
      end
    end)
  end
  
  function self._scroll.OnContentPosChanged()
    if self._scroll:IsDragging() then
      self:MapOnClick()
    end
    self:OnUpdate()
  end
  
  function self._scroll.onContentScaleChanged(scale)
    self._currentScale = scale
    if self._miniMapStatus == MinimapStatus.Big then
      HomelandMinimapConst.SetBigmapScale(scale)
      self:OnUpdate()
    end
    self:MapOnClick()
  end
  
  self:InitScale(self._currentScale)
  self:UpdatePosition()
end

function UIHomelandMinimap:OnHide()
  self:DetachEvent(GameEventType.MinimapUpdate, self.OnUpdate)
  self:DetachEvent(GameEventType.MinimapClickIcon, self.IconClickedHandler)
  self:DetachEvent(GameEventType.MinimapAddIcon, self.AddIcon)
  self:DetachEvent(GameEventType.MinimapRemoveIcon, self.RemoveIcon)
  self:DetachEvent(GameEventType.MinimapCloseDetailUI, self.CloseDetailPanel)
  for i = 1, #self._iconPools do
    self._iconPools[i]:Release()
  end
  for i = 1, #self._icons do
    self._icons[i]:GetIconContainer():Release()
  end
end

function UIHomelandMinimap:OnUpdate()
  if self._isPlayAddMarkIconAnim then
    self._playAddMarkIconTimer = self._playAddMarkIconTimer + UnityEngine.Time.deltaTime * 1000
    if self._playAddMarkIconTimer >= self._addMarkIconAnimLength then
      self._isPlayAddMarkIconAnim = false
      self:PlayIconMarkAnim()
    end
  end
  if not self._icons then
    return
  end
  self:UpdatePosition()
  if self._playerContainer then
    local data = self._playerContainer:GetIconData()
    data:Update()
    local widget = self._playerContainer:GetIconWidget()
    widget:UpdateArrow(self._miniMapStatus)
    local position = self._playerContainer:GetIconPosition()
    if self._miniMapStatus == MinimapStatus.Mini then
      if not self._isPlaySwitchAnim then
        self._contentTran.anchoredPosition = self._contentTran.anchoredPosition - position
      end
    elseif self._miniMapStatus == MinimapStatus.Big then
    end
  end
end

function UIHomelandMinimap:UpdatePosition()
  if self._miniMapStatus == MinimapStatus.Mini then
    local count = #self._icons
    if count < self._updateIndex then
      self._perFrameUpdateCount = math.ceil(count / self._updateFrame)
      self._updateIndex = 1
    end
    for i = 0, self._perFrameUpdateCount do
      if count < self._updateIndex then
        break
      end
      local iconData = self._icons[self._updateIndex]
      iconData:Update()
      self._updateIndex = self._updateIndex + 1
    end
    return
  end
  for i = 1, #self._icons do
    local iconData = self._icons[i]
    iconData:Update()
  end
end

function UIHomelandMinimap:Init()
  self._arrowsLoader:SpawnObjects("UIHomelandMinimapArrow", self._arrowCapacity)
  local arrowPools = self._arrowsLoader:GetAllSpawnList()
  self._arrowPools = {}
  for i = 1, #arrowPools do
    self._arrowPools[#self._arrowPools + 1] = arrowPools[i]
  end
  for i = 1, #self._arrowPools do
    self._arrowPools[i]:SetStatus(false)
  end
  self._containers:SpawnObjects("UIHomelandMinimapIconContainer", self._iconPoolCapacity)
  local pools = self._containers:GetAllSpawnList()
  self._iconPools = {}
  for i = 1, #pools do
    self._iconPools[#self._iconPools + 1] = pools[i]
  end
  for i = 1, #self._iconPools do
    self._iconPools[i]:Init(self)
  end
  self._bgTran.sizeDelta = HomelandMinimapConst.GetMapBackgroundSize()
  self._mapTran.sizeDelta = HomelandMinimapConst.GetMapSize()
  self._contentTran.sizeDelta = HomelandMinimapConst.GetMapSize()
  self._bgLoader:LoadImage(HomelandMinimapConst.GetMapBackgroundTextureName())
  self._mapLoader:LoadImage(HomelandMinimapConst.GetMapTextureName())
end

function UIHomelandMinimap:AddArrow(iconData)
  for i = 1, #self._arrows do
    if iconData == self._arrows[i] then
      return iconData:GetArrowItem()
    end
  end
  if #self._arrowPools <= 0 then
    self:AddArrowCapacity()
  end
  local arrowItem = self._arrowPools[#self._arrowPools]
  table.remove(self._arrowPools, #self._arrowPools)
  arrowItem:Refresh(iconData)
  self._arrows[#self._arrows + 1] = iconData
  return arrowItem
end

function UIHomelandMinimap:AddArrowCapacity()
  self._arrowCapacity = self._arrowCapacity + self._arrowCapacity
  self._arrowsLoader:SpawnObjects("UIHomelandMinimapArrow", self._arrowCapacity)
  local arrowPools = self._arrowsLoader:GetAllSpawnList()
  self._arrowPools = {}
  for i = 1, #arrowPools do
    self._arrowPools[#self._arrowPools + 1] = arrowPools[i]
  end
  for i = 1, #self._arrowPools do
    self._arrowPools[i]:SetStatus(false)
  end
  for i = 1, #self._arrows do
    local iconData = self._arrows[i]
    local arrowItem = self._arrowPools[#self._arrowPools]
    table.remove(self._arrowPools, #self._arrowPools)
    arrowItem:Refresh(iconData)
    iconData:UpdateArrowItem(arrowItem)
  end
end

function UIHomelandMinimap:RemoveArrow(iconData)
  if not iconData then
    return
  end
  for i = 1, #self._arrows do
    local data = self._arrows[i]
    if iconData == data then
      table.remove(self._arrows, i)
      local arrowItem = iconData:GetArrowItem()
      arrowItem:SetStatus(false)
      self._arrowPools[#self._arrowPools + 1] = arrowItem
      return
    end
  end
end

function UIHomelandMinimap:SetMultiSelectCircleStatus(status, pos)
  if status then
    self._multileSelectGo:SetActive(true)
    self._circleAnim:Play("UIHomelandMinimap_IconList_in")
    self._multileTran.position = pos
  else
    self._circleAnim:Play("UIHomelandMinimap_IconList_out")
  end
end

function UIHomelandMinimap:IconClickedHandler(iconBase)
  if self._miniMapStatus == MinimapStatus.Big then
    local icons = self:GetRangeIcons(iconBase)
    if 1 < #icons then
      if self._currentSelectIcon then
        self._currentSelectIcon:UnSelected()
        self._currentSelectIcon = nil
      end
      if self._currentDetailUI then
        self._currentDetailUI:OnClose()
        self._currentDetailUI = nil
      end
      self._currentUseLoader = nil
      if self._currentSelectMultiIcon == iconBase then
        return
      end
      if self._currentSelectMultiIcon then
        self._currentSelectMultiIcon:OnMutilUnSelected(self)
      end
      self._currentSelectMultiIcon = iconBase
      self:ShowIconList(icons)
      iconBase:OnMutilSelected(self)
      return
    end
    if self._currentSelectMultiIcon then
      self._currentSelectMultiIcon:OnMutilUnSelected(self)
      self._currentSelectMultiIcon = nil
    end
    self:PlayIconListHideAnim()
    if self._currentSelectIcon == iconBase then
      return
    end
    if self._currentSelectIcon then
      self._currentSelectIcon:UnSelected()
    end
    self._currentSelectIcon = iconBase
    if self._currentSelectIcon then
      self._currentSelectIcon:Selected()
    end
    self:OpenDetailPanel(self._currentSelectIcon:GetIconData())
  end
end

function UIHomelandMinimap:OnSelectIcon(iconData)
  self:PlayIconListHideAnim()
  if self._miniMapStatus == MinimapStatus.Big then
    if self._currentSelectMultiIcon then
      self._currentSelectMultiIcon:OnMutilUnSelected(self)
      self._currentSelectMultiIcon = nil
    end
    if self._currentSelectIcon then
      self._currentSelectIcon:UnSelected()
    end
    local container = iconData:GetIconContainer()
    local widget = container:GetIconWidget()
    widget:Selected()
    self._currentSelectIcon = widget
    self:OpenDetailPanel(iconData)
  end
end

function UIHomelandMinimap:GetRangeIcons(iconBase)
  local iconData = iconBase:GetIconData()
  local iconContainer = iconData:GetIconContainer()
  local pos = iconContainer:GetIconMultiSelectPosition()
  local result = {}
  local t = {}
  t.icon = iconBase
  t.dis = 0
  result[#result + 1] = t
  local range = HomelandMinimapConst.GetIconClickRange()
  for i = 1, #self._icons do
    local data = self._icons[i]
    if iconData ~= data and data:GetCanClick() and data:CanShow(self._currentScale) then
      local container = data:GetIconContainer()
      local tmpPos = container:GetIconMultiSelectPosition()
      local dis = Vector2.Distance(pos, tmpPos)
      if range >= dis then
        local t = {}
        t.icon = container:GetIconWidget()
        t.dis = dis
        result[#result + 1] = t
      end
    end
  end
  table.sort(result, function(a, b)
    if a.dis ~= b.dis then
      return a.dis < b.dis
    end
    return a.icon:GetIconData():GetSerializeId() > b.icon:GetIconData():GetSerializeId()
  end)
  return result
end

function UIHomelandMinimap:ShowIconList(icons)
  self:PlayIconListShowAnim()
  self._iconListLoader:SpawnObjects("UIHomelandMinimapIconListItem", #icons)
  local items = self._iconListLoader:GetAllSpawnList()
  for i = 1, #icons do
    items[i]:Init(icons[i].icon, self)
  end
end

function UIHomelandMinimap:CloseDetailPanel()
  self._currentUseLoader = nil
  if self._currentSelectIcon then
    self._currentSelectIcon:UnSelected()
    self._currentSelectIcon = nil
  end
  if self._currentDetailUI then
    self._currentDetailUI:OnClose()
  end
  self._currentDetailUI = nil
end

function UIHomelandMinimap:OpenDetailPanel(iconData)
  if self._currentDetailUI then
    self._currentDetailUI:OnClose()
  end
  local freeLoader = self._detailLoader1Loader
  if freeLoader == self._currentUseLoader then
    freeLoader = self._detailLoader2Loader
  end
  if freeLoader.uiCustomWidgets then
    local uiCustomWidgets = freeLoader.uiCustomWidgets
    for i = 1, #uiCustomWidgets do
      local uiCustomWidget = uiCustomWidgets[i]
      uiCustomWidget:UnLoad()
      uiCustomWidget:Dispose()
    end
    freeLoader.uiCustomWidgets = {}
  end
  freeLoader.dynamicInfoOfEngine:SetObjectName(iconData:GetDetailPrefab())
  self._currentDetailUI = freeLoader:SpawnObject(iconData:GetDetailScript())
  self._currentDetailUI:InternalInitialize(iconData)
  self._currentUseLoader = freeLoader
end

function UIHomelandMinimap:RemoveIcon(id, index)
  for i = 1, #self._icons do
    local iconData = self._icons[i]
    if iconData:GetId() == id and iconData:GetIndex() == index then
      self:RemoveArrow(iconData)
      table.remove(self._icons, i)
      local container = iconData:GetIconContainer()
      container:SetStatus(false)
      container:Release()
      self._iconPools[#self._iconPools + 1] = container
      if iconData:IsPlayer() then
        self._playerContainer = nil
      end
      return
    end
  end
end

function UIHomelandMinimap:AddIcon(id, index, transform, param)
  if self._homelandClient:IsVisit() then
    self:AddVisitIcon(id, index, transform, param)
    return
  end
  for i = 1, #self._icons do
    local iconData = self._icons[i]
    if iconData:GetId() == id and iconData:GetIndex() == index then
      return
    end
  end
  if #self._iconPools <= 0 then
    self:AddCapacity()
  end
  local iconContainer = self._iconPools[#self._iconPools]
  table.remove(self._iconPools, #self._iconPools)
  local data = UIHomelandMinimapIconData:New(self, id, index, transform, iconContainer, param)
  self._icons[#self._icons + 1] = data
  if data:IsPlayer() then
    self._playerContainer = iconContainer
  end
  if self._playerContainer then
    self._playerContainer:SetAsLastSibling()
  end
end

function UIHomelandMinimap:AddVisitIcon(id, index, transform, param)
  local active = false
  if id == HomelandMapIconType.BreedLand then
    local land = param
    local uiModule = GameGlobal.GetUIModule(HomelandModule)
    local info = uiModule:GetVisitInfo().cultivation_info
    if info.land_cultivation_infos[land:PstID()] and not land:IsMature() then
      active = true
    end
  elseif id == HomelandMapIconType.StorageBox then
    local building = param
    local uiModule = GameGlobal.GetUIModule(HomelandModule)
    local gifts = uiModule:GetVisitInfo().item_list
    if table.count(gifts) > 0 then
      active = true
    end
  elseif id == HomelandMapIconType.WhiteTower then
    local uiModule = GameGlobal.GetUIModule(HomelandModule)
    if 0 < table.count(uiModule:GetVisitInfo().forge_info.forge_list) then
      active = true
    end
  elseif id == HomelandMapIconType.Player then
    active = true
  end
  if not active then
    return
  end
  for i = 1, #self._icons do
    local iconData = self._icons[i]
    if iconData:GetId() == id and iconData:GetIndex() == index then
      return
    end
  end
  if 0 >= #self._iconPools then
    self:AddCapacity()
  end
  local iconContainer = self._iconPools[#self._iconPools]
  table.remove(self._iconPools, #self._iconPools)
  local data = UIHomelandMinimapIconData:New(self, id, index, transform, iconContainer, param)
  self._icons[#self._icons + 1] = data
  if data:IsPlayer() then
    self._playerContainer = iconContainer
  end
  if self._playerContainer then
    self._playerContainer:SetAsLastSibling()
  end
end

function UIHomelandMinimap:AddCapacity()
  self._iconPoolCapacity = self._iconPoolCapacity + self._iconPoolCapacity
  self._containers:SpawnObjects("UIHomelandMinimapIconContainer", self._iconPoolCapacity)
  local pools = self._containers:GetAllSpawnList()
  self._iconPools = {}
  for i = 1, #pools do
    self._iconPools[#self._iconPools + 1] = pools[i]
  end
  for i = 1, #self._iconPools do
    self._iconPools[i]:Init(self)
  end
  for i = 1, #self._icons do
    local iconContainer = self._iconPools[#self._iconPools]
    table.remove(self._iconPools, #self._iconPools)
    self._icons[i]:UpdateContainerItem(iconContainer)
    if self._icons[i]:IsPlayer() then
      self._playerContainer = iconContainer
    end
  end
end

function UIHomelandMinimap:SwitchStatus(status, playAnim)
  if self._miniMapStatus == status then
    return
  end
  self:StartTask(self.SwitchStatusCoro, self, status, playAnim)
end

function UIHomelandMinimap:SwitchStatusCoro(TT, status, playAnim)
  self._miniMapStatus = status
  if playAnim then
    self._isPlaySwitchAnim = true
    self:Lock("UIHomelandMinimap_SwitchStatusCoro")
    if self._miniMapStatus == MinimapStatus.Mini then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandSetMainCharReceiveMoveInput, true)
      self._anim2:Play("UIHomelandMinimap_bigmap_out")
      for i = 1, #self._icons do
        self._icons[i]:GetIconContainer():PlayIconHideAnim()
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TracePointInOutMiniMap, false)
      YIELD(TT, 400)
      self._btnOpenMapGo:SetActive(false)
      self._btnCloseMapGo:SetActive(false)
      for i = 1, #self._icons do
        self._icons[i]:GetIconContainer():PlayIconShowAnim()
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TracePointInOutMiniMap, true)
      self:SwitchMinimap()
    elseif self._miniMapStatus == MinimapStatus.Big then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandSetMainCharReceiveMoveInput, false)
      self._btnOpenMapGo:SetActive(false)
      self._btnCloseMapGo:SetActive(false)
      self:SwitchBigMap()
      self._anim2:Play("UIHomelandMinimap_bigmap_in")
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TracePointInOutMiniMap, true)
      YIELD(TT, 400)
    end
    self._isPlaySwitchAnim = false
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapSwitch, self._miniMapStatus)
    self:UnLock("UIHomelandMinimap_SwitchStatusCoro")
  else
    self._btnOpenMapGo:SetActive(false)
    self._btnCloseMapGo:SetActive(false)
    if self._miniMapStatus == MinimapStatus.Mini then
      self:SwitchMinimap()
    elseif self._miniMapStatus == MinimapStatus.Big then
      self:SwitchBigMap()
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapSwitch, self._miniMapStatus)
  end
  self:RefreshMarkIconStatus()
end

function UIHomelandMinimap:SwitchMinimap()
  self._scrollTran.anchorMin = Vector2(1, 1)
  self._scrollTran.anchorMax = Vector2(1, 1)
  self._scrollTran.sizeDelta = Vector2(self._minimapWidth, self._minimapHeight)
  self._scrollTran.anchoredPosition = Vector2(-self._minimapWidth / 2, -self._minimapHeight / 2) + self._minimapOffset
  self._scroll.enabled = false
  self._scrollMask.enabled = true
  self._scrollMaskImage.enabled = true
  self._btnOpenMapGo:SetActive(true)
  self._circleOutline:SetActive(true)
  if self._isPlayAddMarkIconAnim then
    self._fx:SetActive(true)
  else
    self._fx:SetActive(false)
  end
  self:OpenMinimap()
end

function UIHomelandMinimap:SwitchBigMap()
  self._scrollTran.anchorMin = Vector2(0, 0)
  self._scrollTran.anchorMax = Vector2(1, 1)
  self._scrollTran.offsetMin = Vector2(0, 0)
  self._scrollTran.offsetMax = Vector2(0, 0)
  self._scroll.enabled = true
  self._scrollMask.enabled = false
  self._scrollMaskImage.enabled = false
  self._btnCloseMapGo:SetActive(true)
  self._circleOutline:SetActive(false)
  self._fx:SetActive(false)
  self:OpenBigMap()
end

function UIHomelandMinimap:OpenBigMap()
  self:InitScale(HomelandMinimapConst.GetBigmapScale())
  for i = 1, #self._icons do
    local data = self._icons[i]
    local iconContainer = data:GetIconContainer()
    iconContainer:UpdateTransform()
    iconContainer:PlayIconShowAnim()
  end
  self:Focus()
end

function UIHomelandMinimap:Focus()
  local position = self._playerContainer:GetIconPosition()
  local targetPosition = self._contentTran.anchoredPosition - position
  targetPosition = self:ClampTargetPos(targetPosition)
  self._contentTran.anchoredPosition = targetPosition
end

function UIHomelandMinimap:FocusCoro(TT, iconData)
  self:Lock("UIHomelandMinimap_FocusCoro")
  for i = 1, #self._icons do
    local data = self._icons[i]
    local iconContainer = data:GetIconContainer()
    iconContainer:UpdateTransform()
    iconContainer:PlayIconShowAnim()
  end
  local speed = HomelandMinimapConst.GetFocusSpeed()
  local container = iconData:GetIconContainer()
  local targetPosition = self._contentTran.anchoredPosition - container:GetIconPosition()
  targetPosition = self:ClampTargetPos(targetPosition)
  local dis = Vector2.Distance(targetPosition, self._contentTran.anchoredPosition)
  if dis <= speed * UnityEngine.Time.deltaTime then
    self._contentTran.anchoredPosition = targetPosition
    self:UnLock("UIHomelandMinimap_FocusCoro")
    return
  end
  local dir = (targetPosition - self._contentTran.anchoredPosition).normalized
  while true do
    local length = speed * UnityEngine.Time.deltaTime
    YIELD(TT)
    self._contentTran.anchoredPosition = self._contentTran.anchoredPosition + dir * length
    dis = Vector2.Distance(targetPosition, self._contentTran.anchoredPosition)
    if length >= dis then
      self._contentTran.anchoredPosition = targetPosition
      break
    end
  end
  self:UnLock("UIHomelandMinimap_FocusCoro")
end

function UIHomelandMinimap:ClampTargetPos(target)
  local endPos = target
  if self._contentTran.sizeDelta.x ~= 0 then
    local width, height = self:GetScreenInfo()
    local limitX = (self._contentTran.sizeDelta.x * self._currentScale - width) / 2
    if limitX < 0 then
      limitX = 0
    end
    local limitY = (self._contentTran.sizeDelta.y * self._currentScale - height) / 2
    if limitY < 0 then
      limitY = 0
    end
    endPos.x = Mathf.Clamp(endPos.x, -limitX, limitX)
    endPos.y = Mathf.Clamp(endPos.y, -limitY, limitY)
  end
  return endPos
end

function UIHomelandMinimap:OpenMinimap()
  if self._detailLoader1Loader and self._detailLoader1Loader.uiCustomWidgets then
    local uiCustomWidgets = self._detailLoader1Loader.uiCustomWidgets
    for i = 1, #uiCustomWidgets do
      local uiCustomWidget = uiCustomWidgets[i]
      uiCustomWidget:UnLoad()
      uiCustomWidget:Dispose()
    end
    self._detailLoader1Loader.uiCustomWidgets = {}
  end
  if self._detailLoader2Loader and self._detailLoader2Loader.uiCustomWidgets then
    local uiCustomWidgets = self._detailLoader2Loader.uiCustomWidgets
    for i = 1, #uiCustomWidgets do
      local uiCustomWidget = uiCustomWidgets[i]
      uiCustomWidget:UnLoad()
      uiCustomWidget:Dispose()
    end
    self._detailLoader2Loader.uiCustomWidgets = {}
  end
  self:InitScale(HomelandMinimapConst.GetMinimapScale())
end

function UIHomelandMinimap:InitScale(scale)
  self._currentScale = scale
  self._scroll:UpdateContentScale(self._currentScale)
end

function UIHomelandMinimap:GetMapCenterPosition()
  return self._contentTran.anchoredPosition
end

function UIHomelandMinimap:GetMapScale()
  return self._currentScale
end

function UIHomelandMinimap:GetMapStatus()
  return self._miniMapStatus
end

function UIHomelandMinimap:GetScreenInfo()
  local width = self._scrollTran.rect.width
  local height = self._scrollTran.rect.height
  return width, height
end

function UIHomelandMinimap:BtnOpenMapOnClick()
  if self._homelandClient:IsVisit() then
    return
  end
  self:SwitchStatus(MinimapStatus.Big, true)
end

function UIHomelandMinimap:BtnCloseMapOnClick()
  self:SwitchStatus(MinimapStatus.Mini, true)
end

function UIHomelandMinimap:MapOnClick()
  self:PlayIconListHideAnim()
  if self._currentSelectMultiIcon then
    self._currentSelectMultiIcon:OnMutilUnSelected(self)
    self._currentSelectMultiIcon = nil
  end
  self:CloseDetailPanel()
end

function UIHomelandMinimap:PlayIconListShowAnim()
  if self._isShowIconList == false then
    self._iconList:SetActive(true)
    self._anim:Play("UIHomelandMinimap_IconListItem_in")
  end
  self._isShowIconList = true
end

function UIHomelandMinimap:PlayIconListHideAnim()
  if self._isShowIconList then
    self._anim:Play("UIHomelandMinimap_IconListItem_out")
  end
  self._isShowIconList = false
end

function UIHomelandMinimap:AddMarkIcon(iconData)
  for i = 1, #self._markIconList do
    if self._markIconList[i] == iconData then
      return
    end
  end
  self._markIconList[#self._markIconList + 1] = iconData
  self:PlayNewIconMarkAnim()
  self:RefreshMarkIconStatus()
end

function UIHomelandMinimap:InitMarkIcon(iconData)
  for i = 1, #self._markIconList do
    if self._markIconList[i] == iconData then
      return
    end
  end
  self._markIconList[#self._markIconList + 1] = iconData
  self:PlayIconMarkAnim()
  self:RefreshMarkIconStatus()
end

function UIHomelandMinimap:RemoveMarkIcon(iconData)
  for i = 1, #self._markIconList do
    if self._markIconList[i] == iconData then
      table.remove(self._markIconList, i)
      break
    end
  end
  if #self._markIconList <= 0 then
    self:StopIconMarkAnim()
  end
  self:RefreshMarkIconStatus()
end

function UIHomelandMinimap:PlayIconMarkAnim()
  if self._isPlayMarkIconAnim or self._isPlayAddMarkIconAnim then
    return
  end
  self._isPlayMarkIconAnim = true
  self._isPlayAddMarkIconAnim = false
  self._fx:SetActive(false)
  self._anim:Play("UIHomelandMinimap_respire")
end

function UIHomelandMinimap:StopIconMarkAnim()
  self._isPlayMarkIconAnim = false
  self._isPlayAddMarkIconAnim = false
  self._anim:Stop()
end

function UIHomelandMinimap:PlayNewIconMarkAnim()
  if self._isPlayAddMarkIconAnim then
    return
  end
  self._isPlayAddMarkIconAnim = true
  self._isPlayMarkIconAnim = false
  if self._miniMapStatus == MinimapStatus.Big then
    self._fx:SetActive(false)
  else
    self._fx:SetActive(true)
  end
  self._anim:Play("UIHomelandMinimap_expansion")
end

function UIHomelandMinimap:RefreshMarkIconStatus()
  local count = #self._markIconList
  self._markIconCountLabel.text = count
  if self._miniMapStatus == MinimapStatus.Big then
    self._markIconCountPanel:SetActive(false)
  elseif self._miniMapStatus == MinimapStatus.Mini then
    if 0 < count then
      self._markIconCountPanel:SetActive(true)
      if count == 1 then
        self._markIconMutile:SetActive(false)
        self._markIconSingle:SetActive(true)
      else
        self._markIconMutile:SetActive(true)
        self._markIconSingle:SetActive(false)
      end
    else
      self._markIconCountPanel:SetActive(false)
    end
  else
    self._markIconCountPanel:SetActive(false)
  end
end
