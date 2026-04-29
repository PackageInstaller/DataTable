_class("UISignInTotalAwardsItem", UICustomWidget)
UISignInTotalAwardsItem = UISignInTotalAwardsItem

function UISignInTotalAwardsItem:OnShow(uiParams)
end

function UISignInTotalAwardsItem:SetData(index, data, callback, showName, hideNumber)
  self._itemid = data.assetid
  self._itemCount = data.count
  local sop = self:GetUIComponent("UISelectObjectPath", "pool")
  self.item = sop:SpawnObject("UIAsset")
  self._callback = callback
  self._showName = showName
  self._hideNumber = hideNumber
  self:_OnValue()
end

function UISignInTotalAwardsItem:_OnValue()
  local cfg_item = Cfg.cfg_item[self._itemid]
  local params = {}
  params.quality = cfg_item.Color
  params.icon = cfg_item.Icon
  local text1
  if self._hideNumber then
    text1 = ""
  else
    text1 = self._itemCount
  end
  params.text = text1
  self.item:SetItemData(params)
  self.item:SetData(self._itemid)
end

function UISignInTotalAwardsItem:BtnOnClick(go)
  if self._callback then
    self._callback(self._itemid, go.transform.position)
  end
end
