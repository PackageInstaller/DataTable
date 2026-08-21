_class("UIActivityBattlePassItemIcon", UICustomWidget)
UIActivityBattlePassItemIcon = UIActivityBattlePassItemIcon

function UIActivityBattlePassItemIcon:OnShow(uiParams)
  self._lvIcon = self:GetGameObject("lvIcon")
end

function UIActivityBattlePassItemIcon:SetData_LvIcon(index, lv)
  self._lvIcon:SetActive(true)
  local txt = self:GetUIComponent("UILocalizationText", "txt")
  local formatStr = "+Lv.%s"
  txt:SetText(string.format(formatStr, lv))
end

function UIActivityBattlePassItemIcon:SetData(index, roleAsset, callback, scale)
  self._lvIcon:SetActive(false)
  self._scale = scale or UIItemScale.Level3
  self:_GetComponents()
  self._index = index
  self._roleAsset = roleAsset
  self._callback = callback
  local cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  if cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._roleAsset.assetid)
    return
  end
  self._cg = cfg_item.Icon
  self._colorEnum = cfg_item.Color
  self:_OnValue()
end

function UIActivityBattlePassItemIcon:OnHide()
  self._cg = nil
  self._index = nil
  self._callback = nil
end

function UIActivityBattlePassItemIcon:_GetComponents()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base, self._scale)
  self.uiItem:SetClickCallBack(function(go)
    self:bgOnClick(go)
  end)
end

function UIActivityBattlePassItemIcon:_OnValue()
  local icon = self._cg
  local quality = self._colorEnum
  local text1 = self._roleAsset.count
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = self._roleAsset.assetid
  })
end

function UIActivityBattlePassItemIcon:bgOnClick(go)
  if self._callback then
    self._callback(self._roleAsset.assetid, go.transform.position)
  end
end
