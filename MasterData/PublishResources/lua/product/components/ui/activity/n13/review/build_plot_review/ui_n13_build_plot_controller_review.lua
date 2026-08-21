_class("UIN13BuildPlotControllerReview", UIController)
UIN13BuildPlotControllerReview = UIN13BuildPlotControllerReview

function UIN13BuildPlotControllerReview:_PlayAnim(widgetName, animName, time, callback)
  local anim = self:GetUIComponent("Animation", widgetName)
  self:Lock(animName)
  anim:Play(animName)
  self:StartTask(function(TT)
    YIELD(TT, time)
    self:UnLock(animName)
    if callback then
      callback()
    end
  end, self)
end

function UIN13BuildPlotControllerReview:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, false, true)
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._side = self:GetUIComponent("Transform", "side")
  self._ext = self:GetUIComponent("Transform", "ext")
  self._type2icon = {
    [1] = {
      [1] = "n13_jqhg_btn03",
      [2] = "n13_jqhg_btn04"
    },
    [2] = {
      [1] = "n13_jqhg_btn05",
      [2] = "n13_jqhg_btn06"
    }
  }
  self._sideIcon = self:GetUIComponent("RawImageLoader", "side")
  self._extIcon = self:GetUIComponent("RawImageLoader", "ext")
  self._redPoint = self:GetGameObject("RedPoint")
end

function UIN13BuildPlotControllerReview:OnShow(uiParams)
  self._isOpen = true
  self._buildManager = uiParams[1]
  self._callBack = uiParams[2]
  if not self._buildManager then
    Log.error("UIN13BuildRewardController:OnShow() buildManager == nil")
    self:CloseDialog()
    return
  end
  self.playerID = GameGlobal.GameLogic():GetOpenId()
  self:InitWidget()
  self._idx = {1, 1}
  self:_FillUIData()
  self:_ChangeType(1)
  self._redPoint:SetActive(self:CheckRed())
  self:_Refresh()
end

function UIN13BuildPlotControllerReview:OnHide()
  self._isOpen = false
end

function UIN13BuildPlotControllerReview:_FillUIData()
  local reviewMap = {
    self._buildManager:GetBuildDataStoryReviewIdMap(),
    self._buildManager:GetPicnicDataStoryReviewIdMap()
  }
  self._data = {
    [1] = {},
    [2] = {}
  }
  local cfgs = Cfg.cfg_n13_plot_review({})
  for i, v in ipairs(cfgs) do
    local type = v.Type
    local map = reviewMap[type]
    if not map[i] then
      local cfgName = type == 1 and "cfg_component_build_item" or "cfg_component_picnic"
      Log.exception("UIN13BuildPlotControllerReview:_FillUIData()", " cfg_n13_plot_review [id] = " .. i, " has not found in " .. cfgName)
    end
    local storyId = 0
    local unlock = false
    local condition = ""
    if type == 1 then
      local buildItemId, status = map[i].buildItemId, map[i].status
      unlock = self._buildManager:CheckNextStatusComplete(buildItemId, status)
      storyId = self._buildManager:GetBuildStoryId(buildItemId, status)
      if not unlock then
        local step = self._buildManager:CalcBuildUnlockStep(buildItemId, status)
        condition = StringTable.Get("str_n13_build_plot_step_build", step)
      end
    else
      local seq = map[i].seq
      storyId = self._buildManager:GetPicnicStory(seq)
      unlock = self:CheckStory(map, i)
      if 10 < i then
        local lastUnlock = self:CheckStory(map, i - 1)
        if lastUnlock and not unlock and 10 < i and i < 15 then
          self._idx[type] = i - 10
        elseif lastUnlock and i == 15 then
          local lastTrueUnlock = self:CheckStory(map, i)
          local Seq = map[i].seq
          local lastStoryId = self._buildManager:GetPicnicStory(Seq)
          local value = LocalDB.GetInt(self.playerID .. lastStoryId .. "UIN13BuildReviewStoryEnd")
          if lastUnlock and lastTrueUnlock and value == 0 then
            self._idx[type] = i - 9
          elseif lastUnlock and lastTrueUnlock and value == 1 then
          else
            self._idx[type] = i - 10
          end
        end
      end
      condition = "none"
    end
    table.insert(self._data[type], {
      storyId = storyId,
      title = StringTable.Get(v.Title),
      desc = StringTable.Get(v.Desc),
      lock = not unlock,
      condition = condition
    })
  end
end

function UIN13BuildPlotControllerReview:CheckStory(map, i)
  local unlock, all = self._buildManager:CalcBuildUnlockProgress()
  if i == 10 and unlock == all then
    return true
  end
  if i ~= 10 then
    local lastSeq = map[i - 1].seq
    local lastStoryId = self._buildManager:GetPicnicStory(lastSeq)
    local value = LocalDB.GetInt(self.playerID .. lastStoryId .. "UIN13BuildReviewStoryEnd")
    if value == 1 then
      return true
    end
  end
  return false
end

function UIN13BuildPlotControllerReview:CheckRed()
  local unlock, all = self._buildManager:CalcBuildUnlockProgress()
  local value = LocalDB.GetInt(self.playerID .. "UIN13BuildPlotControllerReviewExtOnClickTrue")
  if unlock == all and value ~= 1 then
    return true
  else
    return false
  end
end

function UIN13BuildPlotControllerReview:_ChangeType(type, playAni)
  if type == self._type then
    return
  end
  if playAni then
    self:_PlayAnim("_ani_Root", "uieff_n13_build_plot_switch", 500)
    self:_PlayAnim("_ani_TabBtn", "uieff_n13_build_plot_tab", 1433)
  end
  self._type = type
  local sideIcon, extIcon
  if self._type == 1 then
    sideIcon = self._type2icon[1][1]
    extIcon = self._type2icon[2][2]
    self._side:SetAsLastSibling()
  else
    sideIcon = self._type2icon[1][2]
    extIcon = self._type2icon[2][1]
    self._ext:SetAsLastSibling()
  end
  self._sideIcon:LoadImage(sideIcon)
  self._extIcon:LoadImage(extIcon)
  self:_Refresh()
end

function UIN13BuildPlotControllerReview:_Refresh()
  self:_RefreshInfo()
  self:_SetDynamicList(true)
  local idx = self._idx[self._type]
  self._dynamicList:MovePanelToItemIndex(idx - 1, 0)
end

function UIN13BuildPlotControllerReview:_Refresh_Select()
  self:_RefreshInfo()
  self:_SetDynamicList(false)
end

function UIN13BuildPlotControllerReview:_RefreshInfo()
  local idx = self._idx[self._type]
  local data = self._data[self._type][idx]
  if data and not data.lock then
    self._title:SetText(data.title)
    self._desc:SetText(data.desc)
    self:GetGameObject("PlayBtn"):SetActive(true)
    self:GetGameObject("_lock"):SetActive(false)
  else
    self._title:SetText("")
    self._desc:SetText("")
    self:GetGameObject("PlayBtn"):SetActive(false)
    self:GetGameObject("_lock"):SetActive(true)
  end
end

function UIN13BuildPlotControllerReview:_SetDynamicListData()
  self._dynamicListInfo = self._data[self._type]
  self._dynamicListSize = table.count(self._dynamicListInfo)
  self._itemCountPerRow = 1
  self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
end

function UIN13BuildPlotControllerReview:_SetDynamicList(resetPos, noAnim)
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "list")
    self._dynamicList:InitListView(self._dynamicListRowSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListRowSize, self._dynamicList, resetPos)
  end
end

function UIN13BuildPlotControllerReview:_RefreshList(count, list, resetPos)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  if not resetPos then
    list.ScrollRect.content.localPosition = contentPos
  end
end

function UIN13BuildPlotControllerReview:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIN13BuildPlotListItemReview", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._dynamicListSize then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UIN13BuildPlotControllerReview:_SetListItemData(listItem, index)
  local idx = self._idx[self._type]
  local data = self._data[self._type][index]
  listItem:SetData(index, idx == index, data.lock, data.title, data.condition, function(idx)
    self:ListItemOnClick(idx)
  end)
end

function UIN13BuildPlotControllerReview:ListItemOnClick(idx)
  if self._idx[self._type] == idx then
    return
  end
  local data = self._data[self._type][idx]
  if self._type == 2 and data.lock then
    ToastManager.ShowToast(StringTable.Get("str_n13_review_tips_2"))
  end
  self._idx[self._type] = idx
  self:_Refresh_Select()
end

function UIN13BuildPlotControllerReview:SideOnClick(go)
  self:_ChangeType(1, true)
end

function UIN13BuildPlotControllerReview:ExtOnClick(go)
  local unlock, all = self._buildManager:CalcBuildUnlockProgress()
  if unlock == all then
    LocalDB.SetInt(self.playerID .. "UIN13BuildPlotControllerReviewExtOnClickTrue", 1)
    if self._callBack then
      self._callBack()
    end
    self._redPoint:SetActive(false)
    self:_ChangeType(2, true)
  else
    ToastManager.ShowToast(StringTable.Get("str_n13_review_tips_1"))
  end
end

function UIN13BuildPlotControllerReview:PlayBtnOnClick()
  local idx = self._idx[self._type]
  local data = self._data[self._type][idx]
  if data and not data.lock then
    self:ShowDialog("UIStoryController", data.storyId, function()
      self:OnStoryEnd(data.storyId, idx)
    end)
  end
end

function UIN13BuildPlotControllerReview:OnStoryEnd(storyId, idx)
  if self._type == 2 then
    LocalDB.SetInt(self.playerID .. storyId .. "UIN13BuildReviewStoryEnd", 1)
    self:_FillUIData()
    self:_Refresh()
  end
end
