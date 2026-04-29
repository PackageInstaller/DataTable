_class("UISeasonMusicCollectionController", UIController)
UISeasonMusicCollectionController = UISeasonMusicCollectionController

function UISeasonMusicCollectionController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMusicCollectionController:OnShow(uiParams)
  self.closeCb = uiParams[1]
  self._itemCountPerRow = 2
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._pauseIndex = -1
  self._playIndex = -1
  self:InitWidget()
  self:OnValue()
end

function UISeasonMusicCollectionController:InitWidget()
  local topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtns = topBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
    if self.closeCb then
      self.closeCb()
    end
  end, nil, nil, true)
  self.txtCollectionCount = self:GetUIComponent("UILocalizationText", "txtCollectionCount")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._scrollRt = self:GetUIComponent("RectTransform", "ScrollView")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  local controlPool = self:GetUIComponent("UISelectObjectPath", "playControl")
  self.playControlGo = self:GetGameObject("playControl")
  self.playControl = controlPool:SpawnObject("UISeasonMusicControlView")
  self:_InitPlayControl()
end

function UISeasonMusicCollectionController:OnValue()
  self._cfgs = UISeasonExploreHelper:GetSeasonMusicCfgs()
  self._curMainMusic = self._roleModule:UI_GetMusic(EnumBgmType.E_Bgm_Main)
  local defaultPlayIndex
  for i, cfg in ipairs(self._cfgs) do
    if cfg.ID == self._curMainMusic then
      defaultPlayIndex = i
      break
    end
  end
  if not defaultPlayIndex then
    defaultPlayIndex = 1
    self._curMainMusic = 0
  end
  local count = #self._cfgs
  self.playControlGo:SetActive(0 < count)
  if 0 < count then
    self:Sort()
    self:PlayCell(defaultPlayIndex)
    self.txtCollectionCount:SetText(count)
    self._collectionCount = count
    self._listShowItemCount = math.ceil(self._collectionCount / self._itemCountPerRow)
    self:_InitSrollView()
    self:FocusPlayingItem()
  end
  self:RefreshSetBtn()
end

function UISeasonMusicCollectionController:_InitPlayControl()
  self.playControl:SetData(function()
    if self._playIndex > 1 then
      self:PlayCell(self._playIndex - 1, true)
      self:FocusPlayingItem()
    end
  end, function()
    if self._playIndex < #self._cfgs then
      local cfg = self._cfgs[self._playIndex + 1]
      local isUnlock = not self._roleModule:UI_CheckMusicLock(cfg)
      if isUnlock then
        self:PlayCell(self._playIndex + 1, true)
        self:FocusPlayingItem()
      end
    end
  end, function(index)
    self._pauseIndex = index
    self._scrollView:RefreshAllShownItem()
  end, function(index)
    self._pauseIndex = -1
    self._scrollView:RefreshAllShownItem()
  end, function(index, cfg)
    local id = 0
    if self._curMainMusic ~= cfg.ID then
      id = cfg.ID
    end
    self:StartTask(self.ReqChangeBgm, self, EnumBgmType.E_Bgm_Main, id)
  end)
end

function UISeasonMusicCollectionController:FocusPlayingItem()
  local itemIndex = math.floor((self._playIndex - 1) / self._itemCountPerRow)
  self._scrollView:MovePanelToItemIndex(itemIndex, 0)
  self._scrollView:FinishSnapImmediately()
end

function UISeasonMusicCollectionController:ReqChangeBgm(TT, type, id)
  local lockName = "UISeasonMusicCollectionController_ReqChangeBgm"
  self:Lock(lockName)
  local res = self._roleModule:RequestRole_Music(TT, type, id)
  if res:GetSucc() then
    self._curMainMusic = self._roleModule:UI_GetMusic(EnumBgmType.E_Bgm_Main)
    self:RefreshSetBtn(type)
    if type == EnumBgmType.E_Bgm_Main then
      if id == 0 then
        ToastManager.ShowToast(StringTable.Get("str_album_main_default"))
      else
        ToastManager.ShowToast(StringTable.Get("str_album_main_changed"))
      end
    elseif type == EnumBgmType.E_Bgm_AirCraft then
    end
  else
    ToastManager.ShowToast("unkown error:", res:GetResult())
  end
  self:UnLock(lockName)
end

function UISeasonMusicCollectionController:Sort()
  table.sort(self._cfgs, function(a, b)
    local k, isUnLockA = not self._roleModule:UI_CheckMusicLock(a)
    local a1 = 0
    if isUnLockA then
      a1 = 1
    end
    local m, isUnLockB = not self._roleModule:UI_CheckMusicLock(b)
    local b1 = 0
    if isUnLockB then
      b1 = 1
    end
    if a1 ~= b1 then
      return a1 > b1
    end
    return a.ID < b.ID
  end)
end

function UISeasonMusicCollectionController:_InitSrollView()
  self._scrollView:InitListView(self._listShowItemCount, function(scrollView, index)
    return self:InitCellList(scrollView, index)
  end)
  self._inited = true
end

function UISeasonMusicCollectionController:InitCellList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonMusicCollectionCell", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local cellItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._collectionCount then
      cellItem:GetGameObject():SetActive(false)
    else
      self:ShowCellItem(cellItem, itemIndex)
    end
  end
  return item
end

function UISeasonMusicCollectionController:ShowCellItem(cellItem, index)
  cellItem:GetGameObject():SetActive(true)
  local cfg = self._cfgs[index]
  if cfg ~= nil then
    cellItem:SetData(cfg, index, self._playIndex, self._pauseIndex, function(idx, isUnlock)
      self:OnClickCell(idx, isUnlock)
    end)
  end
end

function UISeasonMusicCollectionController:OnClickCell(index, isUnlock)
  if isUnlock then
    local cfg = self._cfgs[index]
    self:PlayCell(index, true)
  end
end

function UISeasonMusicCollectionController:PlayCell(index, refreshScrollView)
  self._pauseIndex = -1
  if self._playIndex and self._playIndex == index then
    return
  end
  self._playIndex = index
  self.playControl:Play(self._playIndex, self._cfgs[self._playIndex])
  if refreshScrollView then
    self._scrollView:RefreshAllShownItem()
  end
end

function UISeasonMusicCollectionController:RefreshSetBtn()
  if self._curMainMusic == 0 then
    self.playControl:SetMainMusicName(StringTable.Get("str_album_main"))
  else
    local cfg = Cfg.cfg_role_music[self._curMainMusic]
    self.playControl:SetMainMusicName(StringTable.Get(cfg.Name))
  end
end
