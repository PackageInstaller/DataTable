local CollectEventGroupCom, Super = NewViewComponent("CollectEventGroupCom")

function CollectEventGroupCom:ctor(uiNode, view, feature, key)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Panel_EventResource(uiNode)
  self:_InitViewData(feature, key)
end

function CollectEventGroupCom:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:CreateTableView()
end

function CollectEventGroupCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_UpdateShowCollectionTidList()
  self:_SetSelectCollectTid(self._showCollectionTidList[1])
  self:_RefreshView()
  if self._showEventListView.isReady then
    self._showEventListView:SetOffset(1, true)
  else
    function self._showEventListView.reloadFinishCallback()
      self._showEventListView.reloadFinishCallback = nil
      
      self._showEventListView:SetOffset(1, true)
    end
  end
end

function CollectEventGroupCom:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Search, System.fn(self, self._OnClickSearch))
end

function CollectEventGroupCom:_OnClickSearch()
  local searchStr = self.view:GetInputText(self.ui.InputField_Course)
  self:_SetSearchStr(searchStr)
  self:_SetInSearchingState("" ~= searchStr)
  self:_UpdateShowCollectionTidList()
  self:_SetSelectCollectTid(self._showCollectionTidList[1])
  self:_RefreshView()
end

function CollectEventGroupCom:_InitViewData(feature, key)
  self._feature = feature
  self._key = key
  self._showCollectionTidList = {}
  self._selectCollectTid = nil
  self._inSearchingState = false
  self._searchStr = ""
end

function CollectEventGroupCom:_SetInSearchingState(boolVal)
  self._inSearchingState = boolVal
end

function CollectEventGroupCom:_SetSearchStr(str)
  self._searchStr = str
end

function CollectEventGroupCom:_SetSelectCollectTid(tid)
  self._selectCollectTid = tid
end

function CollectEventGroupCom:_UpdateShowCollectionTidList()
  local showCollectionTidList = ArtCollectionModel.Instance:GetEventCollectionTidList()
  table.sort(showCollectionTidList, CollectionHallSortUtils.CommonSort)
  if not self._inSearchingState then
    self._showCollectionTidList = showCollectionTidList
    return
  end
  local rst = {}
  for _, tid in ipairs(showCollectionTidList) do
    local title = LT.Text(CollectionHallCfgUtils.GetCfgField("Title", tid) or "")
    local isUnlock = ArtCollectionModel.Instance:IsUnlock(tid)
    if not isUnlock then
      title = StrUtils.Fix2ConfuseText(title)
    end
    if StrUtils.SearchByKeyStr(self._searchStr, title) then
      table.insert(rst, tid)
    end
  end
  self._showCollectionTidList = rst
end

function CollectEventGroupCom:_RefreshView()
  self:_RefreshListView()
  self:_RefreshSelectEventDetail()
  self:_RefreshSearchGroup()
end

function CollectEventGroupCom:_RefreshSearchGroup()
  self:SetActive(self.ui.Group_InputNum, self._inSearchingState)
  if self._inSearchingState then
    self:SetText(self.ui.Text_Result, LT.Textf("TutorialSearchResult", #self._showCollectionTidList))
  end
end

function CollectEventGroupCom:_OnSelectCollectTidChanged()
  self:_RefreshListView()
  self:_RefreshSelectEventDetail()
end

function CollectEventGroupCom:_RefreshSelectEventDetail()
  local targetCollectTid = self._selectCollectTid
  local collectCfg = CollectionHallCfgUtils.GetCfg(targetCollectTid)
  if not collectCfg then
    self:SetActive(self.ui.Image_EventIcon, false)
    self:SetActive(self.ui.Text_Name, false)
    return
  end
  local isUnlock = ArtCollectionModel.Instance:IsUnlock(targetCollectTid)
  self:SetActive(self.ui.Text_Name, true)
  self:SetActive(self.ui.Image_EventIcon, isUnlock)
  local showName = LT.Text(collectCfg.Title)
  if not isUnlock then
    showName = StrUtils.Fix2ConfuseText(showName)
    self:SetText(self.ui.Text_Name, showName)
    return
  end
  self:SetText(self.ui.Text_Name, showName)
  self:SetImage(self.ui.Image_EventIcon, collectCfg.Picture)
end

function CollectEventGroupCom:_RefreshListView()
  self._showEventListView:ReloadData()
end

function CollectEventGroupCom:CreateTableView()
  local sizeDelta = self.ui.UI_Collection_Item_Event.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._showEventListView = self:CreateTableview(self.ui.ScrollView_Toturial_Item, function()
    return #self._showCollectionTidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Collection_Item_Event)
    self:_FillEventCell(cell.gameObject, index)
    return cell
  end, function()
    return w, h
  end)
end

function CollectEventGroupCom:_FillEventCell(cellGO, index)
  local cellUI = UI_Collection_Item_EventResource(cellGO)
  local collectTid = self._showCollectionTidList[index]
  local collectCfg = CollectionHallCfgUtils.GetCfg(collectTid)
  local isUnlock = ArtCollectionModel.Instance:IsUnlock(collectTid)
  local showName = LT.Text(collectCfg.Title)
  if not isUnlock then
    showName = StrUtils.Fix2ConfuseText(showName)
  end
  self:SetActive(cellUI.Com_RedDot, false)
  self:SetActive(cellUI.Group_Mask, not isUnlock)
  self:SetActive(cellUI.Image_Icon, isUnlock)
  self:SetActive(cellUI.Group_Sel, collectTid == self._selectCollectTid)
  self:SetText(cellUI.Text_Name, showName)
  if isUnlock then
    self:SetImage(cellUI.Image_Icon, collectCfg.Picture)
  end
  self:AddViewComponentOnce(cellUI.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    if not isUnlock then
      return false
    end
    do return RedPointDataUtils.IsShowCollectionItem end
    return RedPointDataUtils.IsShowCollectionItem, collectTid
  end)
  self:AddButtonClickListener(cellUI.Btn_Click, function()
    if isUnlock then
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, collectTid)
      self:LocalNotify(NotifyId.OnSelectCommonConcept, collectTid)
      self:Notify(NotifyId.CollectionRewardGet)
      self:_SetSelectCollectTid(collectTid)
      self:_OnSelectCollectTidChanged()
    elseif collectCfg and collectCfg.LockTip then
      local lockTip = LT.Text(collectCfg.LockTip)
      Alert.ShowStr(lockTip)
    else
      Alert.Show(10843)
    end
  end)
end

return CollectEventGroupCom
