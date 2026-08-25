local CollectTrinketGroupCom, Super = NewViewComponent("CollectTrinketGroupCom")

function CollectTrinketGroupCom:ctor(uiNode, view, feature, key)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Panel_EquipResource(uiNode)
  self:_InitViewData(feature, key)
end

function CollectTrinketGroupCom:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:_UpdateShowCollectionTidList()
  self:CreateTableView()
end

function CollectTrinketGroupCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RefreshView()
end

function CollectTrinketGroupCom:RegisterEvents()
end

function CollectTrinketGroupCom:_InitViewData(feature, key)
  self._feature = feature
  self._key = key
  self._showCollectionTidList = {}
end

function CollectTrinketGroupCom:_UpdateShowCollectionTidList()
  local showCollectionTidList = ArtCollectionModel.Instance:GetTrinketCollectionTidList()
  table.sort(showCollectionTidList, CollectionHallSortUtils.CommonSort)
  self._showCollectionTidList = showCollectionTidList
end

function CollectTrinketGroupCom:_RefreshView()
  self:_UpdateShowCollectionTidList()
  self:_RefreshListView()
end

function CollectTrinketGroupCom:_RefreshListView()
  self._showTrinketListView:ReloadData()
  self:SetActive(self.ui.Group_Null_Black, not self._showCollectionTidList or #self._showCollectionTidList <= 0)
end

function CollectTrinketGroupCom:CreateTableView()
  local sizeDelta = self.ui.UI_Collection_Item_Trinket.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._showTrinketListView = self:CreateTableview(self.ui.ScrollView, function()
    return self._showCollectionTidList and #self._showCollectionTidList or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Collection_Item_Trinket)
    self:_FillTrinketCell(cell.gameObject, index)
    return cell
  end, function()
    return w, h
  end)
end

function CollectTrinketGroupCom:_FillTrinketCell(cellGO, index)
  local cellUI = UI_Collection_Item_TrinketResource(cellGO)
  local collectTid = self._showCollectionTidList[index]
  local isUnlock = ArtCollectionModel.Instance:IsUnlock(collectTid)
  local trinketItemCfg = CollectionHallCfgUtils.GetCollectionItemCfg(collectTid)
  assert(trinketItemCfg, "Collection item cfg is nil, tid:" .. index .. " " .. collectTid)
  local trinketSuitCfg = ItemCfgUtils.GetTrinketSuitCfg(trinketItemCfg.ID)
  local showName = LT.Text(trinketSuitCfg.Name)
  if not isUnlock then
    showName = StrUtils.Fix2ConfuseText("      ")
  end
  self:SetActive(cellUI.Group_Trinket, isUnlock)
  self:SetActive(cellUI.Image_Mask, not isUnlock)
  self:SetImage(cellUI.Image_Trinket, trinketSuitCfg.Icon)
  self:SetText(cellUI.Text_Name, showName)
  self:AddViewComponentOnce(cellUI.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    if not isUnlock then
      return false
    end
    do return RedPointDataUtils.IsShowCollectionItem end
    return RedPointDataUtils.IsShowCollectionItem, collectTid
  end)
  self:AddButtonClickListener(cellUI.uiNode, function()
    if not isUnlock then
      Alert.ShowStr(LT.Text("ResonanceUnlockText"))
      return
    end
    UIManager.Instance:Show(Urls.ArtCollectionTrinketDetailView, collectTid)
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, collectTid)
  end)
end

return CollectTrinketGroupCom
