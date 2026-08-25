local ItemIconCompBase, _ = System.NewComponent("ItemIconCompBase")

function ItemIconCompBase.CreateFromConfigData(binder, uiNode, configData)
  local itemcomp
  if configData.Type == CommonDefine.ItemType.Weapon then
    itemcomp = binder:BindComponent(Item2IconComp(uiNode, CommonDefine.ItemDataSourceType.Config, configData))
  end
  return itemcomp
end

function ItemIconCompBase.CreateFromRuntimeData(binder, uiNode, runtimeData)
  local itemcomp
  local configData = DT.Item[runtimeData.tid]
  if configData.Type == CommonDefine.ItemType.Weapon then
    itemcomp = binder:BindComponent(Item2IconComp(uiNode, CommonDefine.ItemDataSourceType.Runtime, runtimeData))
  end
  return itemcomp
end

function ItemIconCompBase:ctor(uiNode, uiRes, dataSourceType, data)
  self.ui = uiRes(uiNode)
  self.data = data
  self.dataSourceType = dataSourceType
  if dataSourceType == CommonDefine.ItemDataSourceType.Config then
    self.configData = data
    self.runtimeData = Vue.reactive({})
  else
    self.configData = DT.Item[data.tid]
    self.runtimeData = Vue.reactive(data)
  end
  self.showDetailinfo = true
  self.selected = Vue.ref(false)
end

function ItemIconCompBase:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Icon_Article, function()
    local iconPath = ItemDataUtils.GetItemIcon(self.configData.ID)
    return iconPath
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    return DT.ItemQuality[self.configData.Quality].ItemQualityColor
  end)
  self.ui.Group_New:SetActive(false)
  self.ui.Image_Tick:SetActive(false)
  binder:BindToRaw(function(_, selected)
    self.ui.Image_Select:SetActive(selected)
  end, function()
    return self.selected.value
  end)
  binder:BindLongPressButton(self.ui.Btn_Click, System.fn(self, self.OnLongPressedCallback), System.fn(self, self.OnClick), tonumber(DT.GetConstant("Role_Press_Time")))
  if self.dataSourceType == CommonDefine.ItemDataSourceType.Runtime then
    binder:BindToVisible(self.ui.Group_New, function()
      local redData = RedPointDataUtils.GetRedDataByTid(RedPointDataUtils.RedType.Item, self.runtimeData.uid)
      if nil == redData then
        return false
      end
      return 1 == redData.isNew
    end)
  else
    self.ui.Group_New:SetAcitve(false)
  end
  self:BindNumSource(self.runtimeData)
end

function ItemIconCompBase:ConfigDetailInfo(showDetailinfo)
  self.showDetailinfo = showDetailinfo
end

function ItemIconCompBase:ShowCheckMark(showCheckMark)
  self.ui.Image_Tick:SetActive(showCheckMark)
end

function ItemIconCompBase:SetClickCallback(onClick)
  self.onClick = onClick
end

function ItemIconCompBase:ToggleSelectionState()
  self.selected.value = not self.selected.value
end

function ItemIconCompBase:SetSelectionState(selected)
  self.selected.value = selected
end

function ItemIconCompBase:IsSelected()
  return self.selected.value
end

function ItemIconCompBase:BindNumSource(_)
end

function ItemIconCompBase:OnLongPressedCallback()
  if self.longPressedCallback then
    self.longPressedCallback()
  end
  self:RemoveRedPoint()
end

function ItemIconCompBase:RemoveRedPoint()
  local redData = RedPointDataUtils.GetRedDataByTid(RedPointDataUtils.RedType.Item, self.runtimeData.uid)
  if redData and 1 == redData.isNew then
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Item, RedPointDataUtils.RedAttrType.IsNew, self.runtimeData.uid)
  end
end

function ItemIconCompBase:OnClick()
  if self.onClick then
    self.onClick(self.dataSourceType, self.data)
  end
  Logger.Info("OnClick")
  if self.dataSourceType == CommonDefine.ItemDataSourceType.Runtime then
    self:RemoveRedPoint()
  end
  if self.showDetailinfo then
    ItemDetailTipBase.Create(self.binder, self.dataSourceType, self.data, self.ui.uiNode)
  end
end

function ItemIconCompBase:OnClickSubBtn()
  if self.subCallback then
    self.subCallback(self.itemTid.value)
  end
end

function ItemIconCompBase:SetLongPressedCallback(longPressedCb)
  self.longPressedCallback = longPressedCb
end

function ItemIconCompBase:SetLongPressedSubCallback(longPressedSubCb)
  self.longPressedSubCallback = longPressedSubCb
end

function ItemIconCompBase:SetSubCallback(subCallback)
  self.subCallback = subCallback
end

function ItemIconCompBase:SetItemTid(tid)
  self.itemTid.value = tid
end

function ItemIconCompBase:SetNumText(text)
  self.botText.value = text
end

function ItemIconCompBase:GetNumText()
  return self.botText.value
end

function ItemIconCompBase:SetSubBtnShow(ifSub)
  self.ifSub.value = ifSub
end

function ItemIconCompBase:SetIsShowDesc(isShowDesc, isShowAppear)
  self.ifShowDesc = isShowDesc
  self.ifShowAppr = isShowAppear
end

function ItemIconCompBase:SetVisible(show)
  self.binder:SetActive(self.ui.uiNode, show)
end

return ItemIconCompBase
