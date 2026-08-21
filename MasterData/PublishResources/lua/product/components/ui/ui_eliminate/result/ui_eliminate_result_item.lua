_class("UIEliminateResultItem", UICustomWidget)
UIEliminateResultItem = UIEliminateResultItem

function UIEliminateResultItem:Constructor()
end

function UIEliminateResultItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIEliminateResultItem:_GetComponents()
  self._assetContent = self:GetUIComponent("UISelectObjectPath", "Asset")
end

function UIEliminateResultItem:SetData(itemInfo, clickCallback)
  self._itemInfo = itemInfo
  self._clickCallback = clickCallback
  self:_InitComponents()
end

function UIEliminateResultItem:_InitComponents()
  self._asset = self._assetContent:SpawnObject("UIAsset")
  local cfg = Cfg.cfg_item[self._itemInfo.ID]
  local param = {}
  param.text = self._itemInfo.Count
  param.quality = cfg.Color
  param.icon = cfg.Icon
  param.showBG = true
  self._asset:SetData(self._itemInfo.ID)
  self._asset:SetItemData(param)
end

function UIEliminateResultItem:FullBtnOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._itemInfo.ID, go.transform.position)
  end
end
