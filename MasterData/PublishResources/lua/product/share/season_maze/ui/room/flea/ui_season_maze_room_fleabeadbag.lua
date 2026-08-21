_class("UISeasonMazeRoomFleaBeadBag", UIController)
UISeasonMazeRoomFleaBeadBag = UISeasonMazeRoomFleaBeadBag

function UISeasonMazeRoomFleaBeadBag:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomFleaBeadBag:OnShow(uiParams)
  self._component = uiParams[1]
  self._componentInfo = self._component:GetComponentInfo()
  self._fromClickBead = uiParams[2]
  self._beadData = uiParams[3]
  self._callBack = uiParams[4]
  self._perRowCount = 9
  self._data = {}
  self._widgets = {}
  self._preWidget = nil
  self:_InitWidget()
  self:_OnValue()
end

function UISeasonMazeRoomFleaBeadBag:_InitWidget()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self.tipBtn = self:GetGameObject("TipBtn")
  self.tipBtn:SetActive(false)
  self.beadTips = self:GetGameObject("BeadTips")
  self.tipsTitle = self:GetUIComponent("UILocalizationText", "TipsTitle")
  self.tipsDesc = self:GetUIComponent("UILocalizationText", "TipsDesc")
  self.tipsBgRect = self:GetUIComponent("RectTransform", "Tips")
  self.canvasGroup = self:GetUIComponent("CanvasGroup", "TipBtn")
  self:AttachEvent(GameEventType.OnSeasonMazeShowRewardsFinish, self.OnSeasonMazeShowRewardsFinish)
end

function UISeasonMazeRoomFleaBeadBag:_OnValue()
  self:_BeadDataTrim()
  self:_InitDynamicScrollView()
end

function UISeasonMazeRoomFleaBeadBag:_BeadDataTrim()
  table.clear(self._data)
  for key, value in pairs(self._componentInfo.m_auto_bead_map) do
    table.insert(self._data, SeasonMazeBeadData:New(key, value))
  end
  table.sort(self._data, function(a, b)
    return a.index < b.index
  end)
end

function UISeasonMazeRoomFleaBeadBag:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UISeasonMazeRoomFleaBeadBag:_InitDynamicScrollView()
  self._scrollView:InitListView(math.ceil(table.count(self._data) / self._perRowCount), function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UISeasonMazeRoomFleaBeadBag:_OnGetItemByIndex(scrollview, index)
  local item = scrollview:NewListViewItem("FleaBeadRow")
  local view = item.gameObject:GetComponent(typeof(UIView))
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", view:GetGameObject("Beads"))
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UISeasonMazeBeadItem", self._perRowCount)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  for i = 1, self._perRowCount do
    local itemWidget = itemWidgets[i]
    if itemWidget then
      local index = index * self._perRowCount + i
      local data = self:_GetBeadData(index)
      itemWidget:SetData(index, data, function(uid, id, position)
        self:_OnClickBead(uid, id, position)
      end)
    end
    if not self._widgets[itemWidget] then
      self._widgets[itemWidget] = itemWidget
    end
  end
  return item
end

function UISeasonMazeRoomFleaBeadBag:_GetBeadData(index)
  return self._data[index] and self._data[index].data
end

function UISeasonMazeRoomFleaBeadBag:_OnClickBead(uid, id, position)
  self.tipBtn:SetActive(false)
  if self._preWidget then
    self._preWidget:OnSelect(false)
  end
  self._preWidget = self:GetWidgetByUID(uid)
  if self._preWidget then
    self._preWidget:OnSelect(true)
  end
  if self._fromClickBead then
    local function okFunc()
      self:Lock("HandleSeasonMazeOperaMarket")
      
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        self._component:HandleSeasonMazeOperaMarket(TT, res, self._beadData.pstid, uid)
        if not res:GetSucc() then
          Log.error("Season maze room flea bead fail.")
          self:UnLock("HandleSeasonMazeOperaMarket")
          if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
            return
          end
          return
        end
        self:UnLock("HandleSeasonMazeOperaMarket")
        
        function self._waitGetRewardsFinishCb()
          self:CloseDialog()
          if self._callBack then
            self._callBack()
          end
        end
        
        local showRewards = {}
        local beadId = self._beadData.roleInfo.bead_id
        local data = SeasonMazeEffect:New()
        data.type = SeasonMazeEffectType.SMET_Bead
        data.id = self:_GetCfgID(uid, beadId)
        data.value_min = 1
        data.value_max = 1
        table.insert(showRewards, data)
        SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
      end)
    end
    
    local contentStr = StringTable.Get("str_season_maze_room_flea_tips1")
    if self:InSlot(uid) then
      contentStr = StringTable.Get("str_season_maze_room_flea_tips2")
    end
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", contentStr, okFunc, nil)
  end
end

function UISeasonMazeRoomFleaBeadBag:GetWidgetByUID(uid)
  if self._widgets then
    for _, widget in pairs(self._widgets) do
      if widget then
        local data = widget:Data()
        if data and data.bead_info.unique_id == uid then
          return widget
        end
      end
    end
  end
  return nil
end

function UISeasonMazeRoomFleaBeadBag:InSlot(uid)
  if uid <= 0 then
    return false
  end
  if self._componentInfo and self._componentInfo.m_auto_bead_fit_list then
    for _, _uid in pairs(self._componentInfo.m_auto_bead_fit_list) do
      if _uid == uid then
        return true
      end
    end
  end
  return false
end

function UISeasonMazeRoomFleaBeadBag:IsLock(data, itemType)
  return false
end

function UISeasonMazeRoomFleaBeadBag:IsMark(data, itemType)
  return false
end

function UISeasonMazeRoomFleaBeadBag:OnSeasonMazeShowRewardsFinish(flag)
  if self._waitGetRewardsFinishCb then
    self._waitGetRewardsFinishCb()
    self._waitGetRewardsFinishCb = nil
  end
end

function UISeasonMazeRoomFleaBeadBag:OnLongPress(go, data)
  if data then
    local cfg = Cfg.cfg_component_season_maze_autobead[data.bead_info.cfg_id]
    if cfg then
      self:Lock("UISeasonMazeRoomFleaBeadBagTips")
      self:StartTask(function(TT)
        self:ShowBeadTips(TT, go.transform.position, cfg.Name, cfg.Desc)
        self:UnLock("UISeasonMazeRoomFleaBeadBagTips")
      end)
    end
  end
end

function UISeasonMazeRoomFleaBeadBag:ShowBeadTips(TT, position, titleStr, descStr)
  self.tipBtn:SetActive(true)
  self.tipsTitle:SetText(StringTable.Get(titleStr))
  self.tipsDesc:SetText(StringTable.Get(descStr))
  self.canvasGroup.alpha = 0
  YIELD(TT)
  local controllName = self:GetName()
  local camera = GameGlobal.UIStateManager():GetControllerCamera(controllName)
  local controller = GameGlobal.UIStateManager():GetController(controllName)
  local gameObject = controller:GetGameObject()
  local transform = gameObject.transform:Find("UICanvas")
  local rectTransform = transform:GetComponent(typeof(UnityEngine.RectTransform))
  local point = camera:WorldToScreenPoint(position)
  local res, position = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, point, camera, nil)
  if position.x + self.tipsBgRect.sizeDelta.x > rectTransform.sizeDelta.x * 0.5 then
    position.x = rectTransform.sizeDelta.x * 0.5 - self.tipsBgRect.sizeDelta.x
  end
  if position.y + rectTransform.sizeDelta.y * 0.5 < self.tipsBgRect.sizeDelta.y then
    position.y = self.tipsBgRect.sizeDelta.y - rectTransform.sizeDelta.y * 0.5
  end
  self.beadTips.transform.localPosition = position
  self.canvasGroup.alpha = 1
end

function UISeasonMazeRoomFleaBeadBag:TipBtnOnClick(go)
  self.tipBtn:SetActive(false)
end

function UISeasonMazeRoomFleaBeadBag:_GetCfgID(uid, oldCfgID)
  if self._componentInfo.m_auto_bead_map then
    for _, value in pairs(self._componentInfo.m_auto_bead_map) do
      local data = value
      if data and data.bead_info.unique_id == uid then
        local rawCfgID = data.bead_info.cfg_id
        local rawLevel = rawCfgID % 10
        local a, b = math.modf(oldCfgID / 10)
        local newCfgID = a * 10 + rawLevel
        return newCfgID
      end
    end
  end
  return oldCfgID
end
