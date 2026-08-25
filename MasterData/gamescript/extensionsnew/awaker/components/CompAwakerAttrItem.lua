local CompAwakerAttrItem, Super = NewViewComponent("CompAwakerAttrItem")

function CompAwakerAttrItem:ctor(res, view, data)
  Super.ctor(self, res, view)
  self.ui = data.resourceCls(res)
  self._showAdd = data.showAdd
  self._clientAttr = data.clientAttr
  self._useDefaultIcon = data.useDefaultIcon
  self._specialShowText = data.specialShowText
  self._showAttr = data.showAttr
  self._useOriginDemical = data.useOriginDemical
  self._getAttrValue = data.getAttrValue
  if data.level then
    self._level = data.level
  end
  self._awakerData = data.awakerData
  self._awakerTid = data.awakerTid
  self._isPreview = data.isPreview
  self._previewLevel = data.previewLevel
end

function CompAwakerAttrItem:OnEnterComponent()
  self:_RefreshDiffPart()
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
end

function CompAwakerAttrItem:RegisterEvents()
  if self.ui.Btn_Icon then
    self:AddButtonClickListener(self.ui.Btn_Icon, function()
      self:_OnClickTip(self.ui.Btn_Icon)
    end)
  end
end

function CompAwakerAttrItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CompAwakerAttrItem:_RefreshDiffPart()
end

function CompAwakerAttrItem:_RefreshText()
  local textName = self:_GetTextName()
  self:SetText(self.ui.Text_Name, textName)
  local textCount = self:_GetTextCount()
  self:SetText(self.ui.Text_Count, textCount)
  if self.ui.Text_Prop_Level then
    local level = self._level or AwakerTrinketDataUtils.GetTrinketSubAttrLevel(self._clientAttr)
    self:SetText(self.ui.Text_Prop_Level, level)
  end
end

function CompAwakerAttrItem:_RefreshImage()
  local imageIcon = self:_GetImageIcon()
  self:SetImage(self.ui.Image_Icon, imageIcon)
end

function CompAwakerAttrItem:_RefreshVisible()
  if self.ui.Group_Icon then
    local isActive = self:_GroupTipVisibleFunc()
    self:SetActive(self.ui.Group_Icon, isActive)
  end
end

function CompAwakerAttrItem:_GetTextName()
  if self._showAttr then
    return self._showAttr.textName or ""
  end
  if self._specialShowText then
    return self._specialShowText
  end
  if not self._clientAttr then
    return ""
  end
  local tid = self._clientAttr.tid
  if not tid or 0 == tid then
    return ""
  end
  do return LT.Text end
  return LT.Text, DT.ActorAttrType[tid].Text
end

function CompAwakerAttrItem:_GetTextCount()
  if self._isPreview then
    local attrName = DT.ActorAttrType[self._clientAttr.tid].Name
    local val = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(self._awakerTid, self._previewLevel, attrName, self._awakerData)
    do return LT.Textf, "MaxLvPreview_Txt" end
    return LT.Textf, "MaxLvPreview_Txt", val, self._awakerData, nil, nil, nil
  end
  if self._showAttr then
    return self._showAttr.textCount or ""
  end
  if self._specialShowText then
    return ""
  end
  local attrData = self._clientAttr
  local value = self:_GetAttrValue()
  if not self._useOriginDemical then
    value = tonumber(AwakerTrinketDataUtils.GetAttrValueString(value))
  end
  local valueStr = AttrUtils.GetAttrShowVal(value)
  if attrData and attrData.isPercent then
    valueStr = valueStr .. "%"
  else
    local attrCfg = DT.ActorAttrType[self.tid]
    if attrCfg and attrCfg.Percentage then
      valueStr = valueStr .. "%"
    end
  end
  if self._showAdd then
    valueStr = string.format("+%s", valueStr)
  end
  if attrData and attrData.perAddCount and attrData.perAddCount > 0 then
    local perVal = attrData.perAddCount / 100
    local perAddValue = self:_GetAttrValue() * perVal
    if not self._useOriginDemical then
      perAddValue = math.ceil(perAddValue)
    end
    valueStr = string.format("%s <AttrGreen:+ %s>", valueStr, perAddValue)
  end
  return valueStr
end

function CompAwakerAttrItem:_GetImageIcon()
  if self._showAttr then
    return self._showAttr.imageIcon or ""
  end
  if self._useDefaultIcon then
    return ""
  end
  if not self._clientAttr then
    return ""
  end
  local tid = self._clientAttr.tid
  if not tid or 0 == tid then
    return ""
  end
  return DT.ActorAttrType[tid].Icon
end

function CompAwakerAttrItem:_GetAttrValue()
  if self._getAttrValue then
    do return end
    return self._getAttrValue
  else
    return self._clientAttr and self._clientAttr.count or 0
  end
end

function CompAwakerAttrItem:_ShowAddValue()
  return false
end

function CompAwakerAttrItem:_GroupTipVisibleFunc()
  return self._clientAttr.attrDesc ~= nil and self._clientAttr.attrDesc ~= ""
end

function CompAwakerAttrItem:_OnClickTip(root)
  if not root then
    return
  end
  local tipData = {
    title = self._clientAttr.name,
    desc = self._clientAttr.attrDesc
  }
  Alert.ShowToolTipsByData(tipData, root)
end

return CompAwakerAttrItem
