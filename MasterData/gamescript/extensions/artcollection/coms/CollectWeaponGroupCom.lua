local CollectWeaponGroupCom, Super = NewViewComponent("CollectWeaponGroupCom")

function CollectWeaponGroupCom:ctor(uiNode, view, feature, key)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Panel_EquipResource(uiNode)
  self:_InitViewData(feature, key)
end

function CollectWeaponGroupCom:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:_UpdateShowCollectionTidList()
  self:CreateTableView()
end

function CollectWeaponGroupCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RefreshView()
end

function CollectWeaponGroupCom:RegisterEvents()
end

function CollectWeaponGroupCom:_InitViewData(feature, key)
  self._feature = feature
  self._key = key
  self._showCollectionTidList = {}
end

function CollectWeaponGroupCom:_UpdateShowCollectionTidList()
  local showCollectionTidList = ArtCollectionModel.Instance:GetWeaponCollectionTidList()
  table.sort(showCollectionTidList, CollectionHallSortUtils.SortWeaponBySchool)
  self._showCollectionTidList = showCollectionTidList
end

function CollectWeaponGroupCom:_RefreshView()
  self:_UpdateShowCollectionTidList()
  self:_RefreshListView()
end

function CollectWeaponGroupCom:_RefreshListView()
  self._showWeaponListView:ReloadData()
  self:SetActive(self.ui.Group_Null_Black, not self._showCollectionTidList or #self._showCollectionTidList <= 0)
end

function CollectWeaponGroupCom:CreateTableView()
  local sizeDelta = self.ui.UI_Collection_Item_Weapon.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._showWeaponListView = self:CreateTableview(self.ui.ScrollView, function()
    return self._showCollectionTidList and #self._showCollectionTidList or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Collection_Item_Weapon)
    self:_FillWeaponCell(cell.gameObject, index)
    return cell
  end, function()
    return w, h
  end)
end

function CollectWeaponGroupCom:_FillWeaponCell(cellGO, index)
  local cellUI = UI_Collection_Item_WeaponResource(cellGO)
  local collectTid = self._showCollectionTidList[index]
  local isUnlock = ArtCollectionModel.Instance:IsUnlock(collectTid)
  local weaponItemCfg = CollectionHallCfgUtils.GetCollectionItemCfg(collectTid)
  assert(weaponItemCfg, "Collection item cfg is nil, tid:" .. index .. " " .. collectTid)
  local showName = LT.Text(weaponItemCfg.Name)
  if not isUnlock then
    showName = StrUtils.Fix2ConfuseText("      ")
  end
  self:SetActive(cellUI.Image_Weapon, isUnlock)
  self:SetActive(cellUI.Image_Mask, not isUnlock)
  self:SetImage(cellUI.Image_Weapon, weaponItemCfg.SpIcon)
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
    UIManager.Instance:Show(Urls.ArtCollectionWeaponDetailView, collectTid)
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, collectTid)
  end)
end

return CollectWeaponGroupCom
