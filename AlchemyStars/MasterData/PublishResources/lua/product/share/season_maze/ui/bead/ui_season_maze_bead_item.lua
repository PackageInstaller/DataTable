_class("UISeasonMazeBeadItem", UICustomWidget)
UISeasonMazeBeadItem = UISeasonMazeBeadItem

function UISeasonMazeBeadItem:OnShow(uiParams)
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self._controller = self.uiOwner
  self:InitWidget()
end

function UISeasonMazeBeadItem:InitWidget()
  self._gameObject = self.view:GetGameObject()
  self._transform = self._gameObject.transform
  self._bg = self:GetUIComponent("Image", "Bg")
  self._root = self:GetGameObject("Type")
  self._type = self:GetUIComponent("Image", "Type")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._lock = self:GetUIComponent("Image", "Lock")
  self._state = self:GetGameObject("State")
  self._stateText = self:GetUIComponent("UILocalizationText", "StateText")
  self._star = self:GetGameObject("Star")
  self._starGO = {}
  self._starGO[1] = self:GetGameObject("Star1")
  self._starGO[2] = self:GetGameObject("Star2")
  self._starGO[3] = self:GetGameObject("Star3")
  self._new = self:GetGameObject("New")
  self._iconGO = self:GetGameObject("Icon")
  self._selected = self:GetGameObject("Selected")
  self._white = self:GetUIComponent("Image", "White")
  self._mark = self:GetUIComponent("Image", "Mark")
  self._tagLock = self:GetUIComponent("Image", "TagLock")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self:_RegisterUIEventListener()
  self._animation = self._gameObject:GetComponent(typeof(UnityEngine.Animation))
  self._bgCanvasGroup = self:GetUIComponent("CanvasGroup", "Bg")
end

function UISeasonMazeBeadItem:SetData(index, data, callBack, itemType)
  self._index = index
  self._data = data
  self._callBack = callBack
  self._itemType = itemType or SeasonMazeBeadItemType.Normal
  if self._data then
    self._cfg = Cfg.cfg_component_season_maze_autobead[self._data.bead_info.cfg_id]
    if self._cfg then
      self._type.sprite = self._atlas:GetSprite(self:_GetTypeSprite(self._cfg))
      self._icon.gameObject:SetActive(true)
      self._icon:LoadImage(self._cfg.Icon)
      self._icon:SetColor(Color(1, 1, 1, 1))
      self._state:SetActive(self:IsEquiped())
      self._new:SetActive(self:IsNew())
      self._name:SetText(StringTable.Get(self._cfg.Name))
      for key, value in ipairs(self._starGO) do
        value:SetActive(key < self._cfg.Lv)
      end
    end
    self._root:SetActive(true)
  else
    self._root:SetActive(false)
  end
  self._selected:SetActive(false)
  if not self._data and self._itemType == SeasonMazeBeadItemType.Normal then
    self._bg.enabled = false
  else
    self._bg.enabled = true
  end
  if self._itemType == SeasonMazeBeadItemType.SynthesisSlot or self._itemType == SeasonMazeBeadItemType.SynthesisList then
    self._bg.sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di11")
  else
    self._bg.sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di01")
  end
  self._white.enabled = self:IsWhite()
  if self._itemType == SeasonMazeBeadItemType.SynthesisList then
    self._white.sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di11")
  else
    self._white.sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di02")
  end
  self._name.enabled = self._itemType == SeasonMazeBeadItemType.Reward
  self:RefreshMark()
  self:RefreshLock()
end

function UISeasonMazeBeadItem:IsWhite()
  return self._itemType == SeasonMazeBeadItemType.EquipSlot or self._itemType == SeasonMazeBeadItemType.SynthesisList
end

function UISeasonMazeBeadItem:IsNew()
  if self._data and self._itemType and self._itemType == SeasonMazeBeadItemType.Normal and self._data.bead_info.b_new then
    return self._controller.IsTempClear and not self._controller:IsTempClear(self._data.bead_info.unique_id)
  end
  return false
end

function UISeasonMazeBeadItem:IsEquiped()
  if self._data and self._controller and self._controller:InSlot(self._data.bead_info.unique_id) and (self._itemType == SeasonMazeBeadItemType.Normal or self._itemType == SeasonMazeBeadItemType.SynthesisList) then
    return true
  end
  return false
end

function UISeasonMazeBeadItem:IconOnClick(go)
  if self._data then
    if self._callBack then
      self._callBack(self._data.bead_info.unique_id, self._data.bead_info.cfg_id, go.transform.position)
    end
  elseif self._unKnownTipsCallBack then
    self._unKnownTipsCallBack(go)
  end
end

function UISeasonMazeBeadItem:_RegisterUIEventListener()
  if self._controller:GetName() == "UISeasonMazeBead" then
    self._eventListener = UICustomUIEventListener.Get(self._iconGO)
    self:AddUICustomEventListener(self._eventListener, UIEvent.BeginDrag, function(eventData)
      self:_OnBeginDrag(eventData)
    end)
    self:AddUICustomEventListener(self._eventListener, UIEvent.Drag, function(eventData)
      self:_OnDrag(eventData)
    end)
    self:AddUICustomEventListener(self._eventListener, UIEvent.EndDrag, function(eventData)
      self:_OnEndDrag(eventData)
    end)
    self:AddUICustomEventListener(self._eventListener, UIEvent.Release, function(eventData)
      self:_OnRelease(eventData)
    end)
  elseif self._controller:GetName() == "UISeasonMazeRoomFleaBeadBag" then
    self._longPressEventListener = UILongPressTriggerListener.Get(self._iconGO)
    self:AddUICustomEventListener(self._longPressEventListener, UIEvent.LongPress, function(go)
      self:_OnLongPress(go)
    end)
  end
end

function UISeasonMazeBeadItem:_OnBeginDrag(eventData)
  if self._lock.enabled then
    return
  end
  self._isCanDrag = self._controller:CanDrag(self._data.bead_info.unique_id, self._itemType) and not self:IsSynthesisPreView()
  if self._isCanDrag then
    self._controller:OnBeginDrag(eventData, self, self._index, self._data, self._gameObject.transform.position)
  end
end

function UISeasonMazeBeadItem:_OnDrag(eventData)
  if self._lock.enabled then
    return
  end
  if self._isCanDrag then
    self._controller:OnDrag(eventData)
  end
end

function UISeasonMazeBeadItem:_OnEndDrag(eventData)
  if self._lock.enabled then
    return
  end
  if self._isCanDrag then
    self._controller:OnDragEnd(eventData)
  end
end

function UISeasonMazeBeadItem:_OnRelease()
  self._controller:OnReleased()
end

function UISeasonMazeBeadItem:_OnLongPress(go)
  if self._controller.OnLongPress then
    self._controller:OnLongPress(go, self._data)
  end
end

function UISeasonMazeBeadItem:_GetTypeSprite(cfg)
  if cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
    return "thread_junei_zdz01"
  elseif cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
    return "thread_junei_zdz02"
  elseif cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
    return "thread_junei_zdz03"
  end
  return "cn14_sjmj_xdjmk_di12"
end

function UISeasonMazeBeadItem:IsSynthesisPreView()
  return self._index == 3 and self._itemType == SeasonMazeBeadItemType.SynthesisSlot
end

function UISeasonMazeBeadItem:Transform()
  return self._transform
end

function UISeasonMazeBeadItem:Index()
  return self._index
end

function UISeasonMazeBeadItem:Data()
  return self._data
end

function UISeasonMazeBeadItem:Level()
  if self._cfg then
    return self._cfg.Lv
  end
  return 0
end

function UISeasonMazeBeadItem:RefreshNew(show)
  self._new:SetActive(self:IsNew())
end

function UISeasonMazeBeadItem:TagLock(lock)
  self._tagLock.enabled = lock
end

function UISeasonMazeBeadItem:Hide(hide)
  if self._data then
    self._gameObject:SetActive(not hide)
  end
end

function UISeasonMazeBeadItem:RefreshLock()
  if self._controller.IsLock then
    self:Lock(self._controller:IsLock(self._data, self._itemType))
  else
    self:Lock(false)
  end
end

function UISeasonMazeBeadItem:Lock(lock)
  if self._data then
    self._lock.enabled = lock
  end
end

function UISeasonMazeBeadItem:RefreshMark()
  if self._controller.IsMark then
    self:Mark(self._controller:IsMark(self._data, self._itemType))
  else
    self:Mark(false)
  end
end

function UISeasonMazeBeadItem:Mark(isMark)
  self._mark.enabled = isMark
end

function UISeasonMazeBeadItem:ShowUnknown(level, unKnownTipsCallBack, beadType)
  self._data = nil
  self._white.enabled = false
  self._bg.enabled = true
  local typeSpriteName = "cn14_sjmj_xdjmk_di12"
  if beadType then
    if beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
      typeSpriteName = "thread_junei_zdz04"
    elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
      typeSpriteName = "thread_junei_zdz06"
    elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
      typeSpriteName = "thread_junei_zdz07"
    end
  end
  self._type.sprite = self._atlas:GetSprite(typeSpriteName)
  self._icon:SetColor(Color(0, 0, 0, 0))
  self._state:SetActive(false)
  self._new:SetActive(false)
  for key, value in ipairs(self._starGO) do
    value:SetActive(level > key)
  end
  self._root:SetActive(true)
  self._selected:SetActive(false)
  self:Mark(false)
  self._name.enabled = self._itemType == SeasonMazeBeadItemType.Reward
  self._unKnownTipsCallBack = unKnownTipsCallBack
end

function UISeasonMazeBeadItem:OnSelect(select)
  self._selected:SetActive(select)
end

function UISeasonMazeBeadItem:SetScale(scale)
  self._gameObject.transform.localScale = Vector3(scale, scale, 1)
end

function UISeasonMazeBeadItem:SetActive(active)
  self._gameObject:SetActive(active)
end

function UISeasonMazeBeadItem:IconGO()
  return self._iconGO
end

function UISeasonMazeBeadItem:Alpha(alpha)
  self._bgCanvasGroup.alpha = alpha
end

function UISeasonMazeBeadItem:PlayAnimation()
  self._animation:Play("uianim_UISeasonMazeBeadItem_in")
end
