_class("UISerialAutoFightSweepResultTargetItem", UICustomWidget)
UISerialAutoFightSweepResultTargetItem = UISerialAutoFightSweepResultTargetItem

function UISerialAutoFightSweepResultTargetItem:OnShow()
end

function UISerialAutoFightSweepResultTargetItem:OnHide()
end

function UISerialAutoFightSweepResultTargetItem:SetStyleUI(styleName)
  self._styleName = styleName
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "line01", self, "_line")
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "kuang01", self, "_kuang")
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "titleColor", self, "_txtTitle")
end

function UISerialAutoFightSweepResultTargetItem:SetData(uiType, itemId, itemCondition, tipsCallback)
  self._uiType = uiType
  self._itemId = itemId
  self._itemCondition = itemCondition
  self._tipsCallback = tipsCallback
  self:Refresh()
end

function UISerialAutoFightSweepResultTargetItem:Refresh()
  local progress = self:_GetProgress(self._itemId, self._itemCondition)
  local topText = StringTable.Get("str_battle_set_auto_fight_stat_title")
  if self._uiType == 1 then
    self:_SetItem(self._itemId, topText, progress)
  else
    self:_SetItem(self._itemId)
    self:_SetTitle(topText)
    self:_SetProgress(progress)
  end
  local preNot = self._enough == false
  self._enough = self:_CheckCountEnough(self._itemId, self._itemCondition)
  return self._enough and preNot
end

function UISerialAutoFightSweepResultTargetItem:_GetItemCount(itemId)
  local roleModule = self:GetModule(RoleModule)
  local count = roleModule:GetAssetCount(itemId)
  count = math.max(0, count)
  return count
end

function UISerialAutoFightSweepResultTargetItem:_CheckCountEnough(itemId, itemCondition)
  local count = self:_GetItemCount(itemId)
  return itemCondition <= count
end

function UISerialAutoFightSweepResultTargetItem:_GetProgress(itemId, itemCondition)
  local count = self:_GetItemCount(itemId)
  local showCount = 9999 < count and "9999+" or tostring(count)
  local isEnough = self:_CheckCountEnough(itemId, itemCondition)
  local styleKey = self._uiType == 1 and "optionColor" or "titleColor"
  local styleColor = UISerialAutoFightStyleHelper.GetStyleInfo(self._styleName, styleKey)
  local colorNormal = self._uiType == 1 and "#F4F4F4" or "#2A2A2C"
  local colorRed = "#DE3233"
  local str = UIStyleHelper.ChangeColorStr_Style(styleColor, colorNormal, colorRed, not isEnough, showCount, itemCondition)
  return str
end

function UISerialAutoFightSweepResultTargetItem:_SetTitle(str)
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle", str)
end

function UISerialAutoFightSweepResultTargetItem:_SetProgress(str)
  UIWidgetHelper.SetLocalizationText(self, "_txtProgress", str)
end

function UISerialAutoFightSweepResultTargetItem:_SetItem(itemId, topText, text1)
  local cfg = Cfg.cfg_item[itemId]
  local icon = cfg.Icon
  local quality = cfg.Color
  local obj = UIWidgetHelper.SpawnObject(self, "_item", "UIItem")
  obj:SetForm(UIItemForm.Stage)
  obj:SetData({
    icon = icon,
    quality = quality,
    itemId = itemId,
    topText = topText,
    text1 = text1
  })
  obj:EnableNode(UIItemNode.Award, false)
  obj:SetClickCallBack(function(go)
    self._tipsCallback(itemId, go.transform.position)
  end)
end
