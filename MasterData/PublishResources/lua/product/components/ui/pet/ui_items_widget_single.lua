_class("UIItemsWidgetSingle", UICustomWidget)
UIItemsWidgetSingle = UIItemsWidgetSingle

function UIItemsWidgetSingle:OnShow()
  self.clickCallBack = nil
  self.matID = -1
end

function UIItemsWidgetSingle:OnShowItem()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIAsset")
  if not self.eventComponent then
    self.uiItem:SetData(self.matID)
    self.eventComponent = self.uiItem:AddComponent(UIAssetComponentEvent)
    self.eventComponent:SetClickCallBack(function(go)
      self:UIItemsWidgetOnClick(go)
    end)
  end
end

function UIItemsWidgetSingle:OnHide()
end

function UIItemsWidgetSingle:SetData(_id, _needCount, _clickCallback, scale)
  self.matID = _id
  local cfgData = Cfg.cfg_item[_id]
  if cfgData == nil then
    Log.fatal("item id not found", _id)
  end
  local text1 = _needCount
  local icon = cfgData.Icon
  local quality = cfgData.Color
  self._scale = scale
  self.clickCallBack = _clickCallback
  self:OnShowItem()
  self.uiItem:SetItemData({
    showBG = true,
    icon = icon,
    text = text1,
    quality = quality
  })
  self.uiItem:SetScale(scale)
end

function UIItemsWidgetSingle:UIItemsWidgetOnClick(go)
  if self.clickCallBack then
    self.clickCallBack(self.matID, go.transform.position)
  end
end
