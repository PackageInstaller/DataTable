_class("UIChangeTitleController", UIController)
UIChangeTitleController = UIChangeTitleController

function UIChangeTitleController:OnShow(uiParams)
  self._playerInfo = uiParams[1]
  self._timeEvents = {}
  self:_GetComponents()
  self:_OnValue()
end

function UIChangeTitleController:_GetComponents()
  self._anim = self:GetUIComponent("Animation", "anim")
  self._unlockText = self:GetUIComponent("UILocalizationText", "unlockText")
  self._LockIcon = self:GetGameObject("LockIcon")
  self._changeBtn = self:GetGameObject("changeBtn")
  self._condition = self:GetGameObject("condition")
  self._showLine = self:GetGameObject("showLine")
  self._showTitleIcon = self:GetUIComponent("RawImageLoader", "showTitleIcon")
  self._showTitleIconObj = self:GetGameObject("showTitleIconObj")
  self._noTitleIconObj = self:GetGameObject("noTitleIconObj")
  self._UsingIconObj = self:GetGameObject("UsingIcon")
  self._noTitleShow = self:GetGameObject("noTitleShow")
  self._titleScrollView = self:GetUIComponent("UIDynamicScrollView", "titleScrollView")
  local _leftUpper = self:GetUIComponent("UISelectObjectPath", "LeftUpper")
  self._backBtns = _leftUpper:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self._anim:Play("uieff_UIChangeTitle_out")
    self:_LockAnim(167)
    GameGlobal.Timer():AddEvent(167, function()
      self:CloseDialog()
    end)
  end, nil)
end

function UIChangeTitleController:_OnValue()
  self._titleHoldCount = 15
  self._noTitleItemID = 0
  self._itemCountPerRow = 3
  self._itemModule = self:GetModule(ItemModule)
  self._roleModule = self:GetModule(RoleModule)
  local datas = {}
  local noTitleItemData = self:GetNoTitleItemData()
  datas[self._noTitleItemID] = noTitleItemData
  local idx = 1
  local cfgTitle = Cfg.cfg_item_title({})
  local cfg_Title = {}
  for k, v in pairs(cfgTitle) do
    cfg_Title[v.Order] = v
  end
  if cfg_Title and next(cfg_Title) then
    for k, v in pairs(cfg_Title) do
      local title = v
      local data = {}
      if title then
        local lock = true
        local itemid = title.ID
        idx = idx + 1
        local itemcount = self._itemModule:GetItemCount(itemid)
        if itemcount and 0 < itemcount then
          lock = false
        end
        if GameSingle then
          lock = false
        end
        data.itemid = itemid
        data.icon = Cfg.cfg_item_title_extend[itemid].ChangeTitleIcon
        data.Order = idx
        data.lock = lock
        data.desc = Cfg.cfg_item_title[itemid].Desc
        data.using = self._playerInfo.m_title_used == itemid
        
        function data.callback(itemid)
          self:_ChooseOneTitle(itemid)
        end
        
        datas[itemid] = data
      end
    end
    if idx < self._titleHoldCount then
      for i = 1, self._titleHoldCount - idx do
        local data = {}
        data.itemid = -i
        data.Order = idx + i
        datas[-i] = data
      end
    end
  end
  self._itemTotalCount = math.max(self._titleHoldCount, idx)
  self._datas = datas
  self:_LockAnim(100 * self:GetRowCount())
  self:_InitTitleSrollView()
  if self._playerInfo.m_title_used ~= -1 then
    self:_ChooseOneTitle(self._playerInfo.m_title_used)
  end
end

function UIChangeTitleController:_InitTitleSrollView()
  self._titleScrollView:InitListView(self:GetRowCount(), function(scrollView, index)
    return self:InitTitleList(scrollView, index)
  end)
end

function UIChangeTitleController:_GetItemFromOrder(order)
  for _, v in pairs(self._datas) do
    if v.Order == order then
      return v
    end
  end
  return nil
end

function UIChangeTitleController:GetRowCount()
  local row = math.ceil(self._itemTotalCount / self._itemCountPerRow)
  return row
end

function UIChangeTitleController:InitTitleList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    GameGlobal.Timer():AddEvent(index * 100, function()
      rowPool:SpawnObjects("UITitleItem", self._itemCountPerRow)
      local rowList = rowPool:GetAllSpawnList()
      for i = 1, self._itemCountPerRow do
        local heartItem = rowList[i]
        local itemIndex = index * self._itemCountPerRow + i
        self:ShowTitleItem(heartItem, itemIndex)
      end
    end)
  else
    rowPool:SpawnObjects("UITitleItem", self._itemCountPerRow)
    local rowList = rowPool:GetAllSpawnList()
    for i = 1, self._itemCountPerRow do
      local heartItem = rowList[i]
      local itemIndex = index * self._itemCountPerRow + i
      self:ShowTitleItem(heartItem, itemIndex)
    end
  end
  return item
end

function UIChangeTitleController:ShowTitleItem(item, index)
  local itemData = self:_GetItemFromOrder(index)
  if itemData then
    item:GetGameObject():SetActive(true)
    item:SetData(self:_GetItemFromOrder(index))
  else
    item:GetGameObject():SetActive(false)
  end
end

function UIChangeTitleController:OnHide()
  for key, value in pairs(self._timeEvents) do
    GameGlobal.Timer():CancelEvent(value)
  end
end

function UIChangeTitleController:GetNoTitleItemData()
  local data = {}
  data.itemid = self._noTitleItemID
  data.lock = false
  data.Order = 1
  data.using = self._playerInfo.m_title_used == self._noTitleItemID
  
  function data.callback(itemid)
    self:_ChooseOneTitle(itemid)
  end
  
  return data
end

function UIChangeTitleController:_ChooseOneTitle(itemid)
  if self._currentChooseItemID == itemid then
    return
  end
  self._currentChooseItemID = itemid
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTitleItemSelect, self._currentChooseItemID)
  self._noTitleShow:SetActive(false)
  self._condition:SetActive(true)
  self._showLine:SetActive(true)
  if self._currentChooseItemID == self._noTitleItemID then
    self._noTitleIconObj:SetActive(true)
    self._showTitleIconObj:SetActive(false)
  else
    self._noTitleIconObj:SetActive(false)
    self._showTitleIconObj:SetActive(true)
    local PreviewTitleIcon = Cfg.cfg_item_title_extend[itemid].ChangeTitleIcon
    self._showTitleIcon:LoadImage(PreviewTitleIcon)
  end
  self:RefreshChangeBtnStatus(itemid)
end

function UIChangeTitleController:RefreshChangeBtnStatus(itemid)
  local isUsing = self._playerInfo.m_title_used == itemid
  local isLock = self._datas[itemid].lock
  self._LockIcon:SetActive(isLock)
  self._changeBtn:SetActive(not isUsing and not isLock)
  self._UsingIconObj:SetActive(isUsing and not isLock)
  self._unlockText:SetText(StringTable.Get(self._datas[itemid].desc))
end

function UIChangeTitleController:backOnClick()
  self:CloseDialog()
end

function UIChangeTitleController:changeBtnOnClick()
  self:Lock("UIChangeTitleController:changeBtnOnClick")
  self:StartTask(self._ChangeTitleTask, self)
end

function UIChangeTitleController:_ChangeTitleTask(TT)
  local res = self._roleModule:Request_TitleAndFifure(TT, 1, self._currentChooseItemID)
  self:UnLock("UIChangeTitleController:changeBtnOnClick")
  if res and res:GetSucc() then
    ToastManager.ShowToast(StringTable.Get("str_player_info_change_title_succ"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPlayerTitleInfoChanged, self._currentChooseItemID)
    self._playerInfo = self._roleModule:UI_GetPlayerInfo()
    self:RefreshChangeBtnStatus(self._currentChooseItemID)
  else
    ToastManager.ShowToast("###[UIChangeTitleController] changeBtnOnClick fail ! result --> ", res:GetResult())
    Log.error("###[UIChangeTitleController] changeBtnOnClick fail ! result --> ", res:GetResult())
  end
end

function UIChangeTitleController:_LockAnim(timeLen)
  self:Lock("UIChangeTitleController_LockAnim")
  local te = GameGlobal.Timer():AddEvent(timeLen, function()
    self:UnLock("UIChangeTitleController_LockAnim")
  end)
  table.insert(self._timeEvents, te)
end
