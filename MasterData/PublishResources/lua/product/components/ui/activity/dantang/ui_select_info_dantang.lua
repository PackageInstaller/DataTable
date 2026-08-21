_class("UISelectInfoDantang", UICustomWidget)
UISelectInfoDantang = UISelectInfoDantang

function UISelectInfoDantang:OnShow()
  self._showName = self:GetUIComponent("UILocalizationText", "txt_item_name")
  self._showDes = self:GetUIComponent("UILocalizationText", "txt_item_simple_desc")
  self._showCount = self:GetUIComponent("UILocalizationText", "txt_item_own_count")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self._showItem = sop:SpawnObject("UIItemDanTang")
end

function UISelectInfoDantang:SetData(item_id)
  local itemConfig = Cfg.cfg_item[item_id]
  if not itemConfig then
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  if not itemModule then
    return
  end
  self._showName:SetText(StringTable.Get(itemConfig.Name))
  local roleModule = GameGlobal.GetModule(RoleModule)
  local c = roleModule:GetAssetCount(item_id)
  self._showCount:SetText(StringTable.Get("str_item_public_owned") .. self:_FormatItemCount(c))
  self._showDes:SetText(StringTable.Get(itemConfig.Intro))
  local icon = itemConfig.Icon
  local quality = itemConfig.Color
  local itemId = itemConfig.ID
  self._showItem:Flush(NewRoleAsset(itemId, ""), nil, true)
end

function UISelectInfoDantang:OnHide()
end

function UISelectInfoDantang:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end
