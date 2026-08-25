local CollectRelicGroupCom, Super = NewViewComponent("CollectRelicGroupCom")

function CollectRelicGroupCom:ctor(uiNode, view, feature, key)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Panel_RelicResource(uiNode)
  self:_InitViewData(feature, key)
end

function CollectRelicGroupCom:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:CreateTableView()
end

function CollectRelicGroupCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_UpdateShowCollectionTidList()
  self:_SetSelectCollectTid(self._showCollectionTidList[1])
  self:_RefreshView()
end

function CollectRelicGroupCom:RegisterEvents()
end

function CollectRelicGroupCom:_InitViewData(feature, key)
  self._feature = feature
  self._key = key
  self._showCollectionTidList = {}
  self._selectCollectTid = nil
end

function CollectRelicGroupCom:_SetSelectCollectTid(tid)
  self._selectCollectTid = tid
  self:_RefreshView()
end

function CollectRelicGroupCom:_UpdateShowCollectionTidList()
  local showCollectionTidList = ArtCollectionModel.Instance:GetRelicCollectionTidList()
  table.sort(showCollectionTidList, CollectionHallSortUtils.CommonSort)
  self._showCollectionTidList = showCollectionTidList
end

function CollectRelicGroupCom:_RefreshView()
  self:_RefreshListView()
  self:_RefreshSelectRelicDetail()
end

function CollectRelicGroupCom:_RefreshSelectRelicDetail()
  local targetCollectTid = self._selectCollectTid
  local isUnlock = ArtCollectionModel.Instance:IsUnlock(targetCollectTid)
  self:SetActive(self.ui.Text_C_Title, isUnlock)
  self:SetActive(self.ui.Relic_Icon, isUnlock)
  self:SetActive(self.ui.Text_Desc, isUnlock)
  local collectionHallCfg = CollectionHallCfgUtils.GetCfg(targetCollectTid)
  local showName = LT.Text(collectionHallCfg.Title)
  if not isUnlock then
    showName = StrUtils.Fix2ConfuseText(showName)
    self:SetText(self.ui.Text_Name, showName)
    return
  end
  self:SetText(self.ui.Text_Name, LT.Text(showName))
  self:SetText(self.ui.Text_Desc, LT.Text(collectionHallCfg.Desc))
  self:SetImage(self.ui.Relic_Icon, collectionHallCfg.Picture)
end

function CollectRelicGroupCom:_RefreshListView()
  if not self.view then
    return
  end
  self._showRelicListView:ReloadData()
end

function CollectRelicGroupCom:CreateTableView()
  local sizeDelta = self.ui.UI_Collection_Item_Relic.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._showRelicListView = self:CreateTableview(self.ui.ScrollView_Relic, function()
    return #self._showCollectionTidList
  end, function(view, index)
    local cell = self.view:DequeueCell(view, self.ui.UI_Collection_Item_Relic)
    self:_FillRelicCell(cell.gameObject, index)
    return cell
  end, function()
    return w, h
  end)
end

function CollectRelicGroupCom:_FillRelicCell(cellGO, index)
  local cellUI = UI_Collection_Item_RelicResource(cellGO)
  local collectTid = self._showCollectionTidList[index]
  local isUnlock = ArtCollectionModel.Instance:IsUnlock(collectTid)
  self:SetImage(cellUI.Image_Relic, CollectionHallCfgUtils.GetCfgField("Picture", collectTid))
  self:SetActive(cellUI.Image_Relic, isUnlock)
  self:SetActive(cellUI.Image_Select, collectTid == self._selectCollectTid)
  self:SetActive(cellUI.Text_Lock, not isUnlock)
  self:AddViewComponentOnce(cellUI.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    if not isUnlock then
      return false
    end
    do return RedPointDataUtils.IsShowCollectionItem end
    return RedPointDataUtils.IsShowCollectionItem, collectTid
  end)
  self:AddButtonClickListener(cellUI.Btn_Click, function()
    if not isUnlock then
      local collectionHallCfg = CollectionHallCfgUtils.GetCfg(collectTid)
      if collectionHallCfg and collectionHallCfg.LockTip then
        local lockTip = LT.Text(collectionHallCfg.LockTip)
        Alert.ShowStr(lockTip)
      else
        Alert.Show(10843)
      end
      return
    end
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, collectTid)
    self:_SetSelectCollectTid(collectTid)
    self:Notify(NotifyId.CollectionRewardGet)
  end)
end

return CollectRelicGroupCom
