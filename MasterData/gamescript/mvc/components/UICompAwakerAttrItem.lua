local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions
local UICompAwakerAttrItem, Super = NewViewComponent("UICompAwakerAttrItem")

function UICompAwakerAttrItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = data.resourceCls(uiNode)
  self.showAdd = data.showAdd
  self.clientAttr = data.clientAttr
  self.useDefaultIcon = data.useDefaultIcon
  self.specialShowText = data.specialShowText
  self.showAttr = data.showAttr
  self.useOriginDemical = data.useOriginDemical
  self.getAttrValue = data.getAttrValue
  if data.level then
    self.level = data.level
  end
end

function UICompAwakerAttrItem:_GetAttrValue()
  if self.getAttrValue then
    do return end
    return self.getAttrValue
  else
    return self.clientAttr and self.clientAttr.count or 0
  end
end

function UICompAwakerAttrItem:_GetAttrName()
  if self.showAttr then
    return self.showAttr.textName or ""
  end
  if self.specialShowText then
    return self.specialShowText
  end
  if not self.clientAttr then
    return ""
  end
  local tid = self.clientAttr.tid
  if not tid or 0 == tid then
    return ""
  end
  do return LT.Text end
  return LT.Text, DT.ActorAttrType[tid].Text
end

function UICompAwakerAttrItem:_GetAttrCount()
  if self.showAttr then
    return self.showAttr.textCount or ""
  end
  if self.specialShowText then
    return ""
  end
  local attrData = self.clientAttr
  local value = self:_GetAttrValue()
  if not self.useOriginDemical then
    local _, demical = math.modf(value)
    if 0 ~= demical then
      value = math.ceil(value)
    end
  end
  if self:_ShowAddValue() and attrData and attrData.addCount and attrData.addCount > 0 then
    value = value - attrData.addCount
  end
  local valueStr = value
  if attrData and attrData.isPercent then
    valueStr = valueStr .. "%"
  else
    local attrCfg = DT.ActorAttrType[self.tid]
    if attrCfg and attrCfg.Percentage then
      valueStr = valueStr .. "%"
    end
  end
  if self.showAdd then
    valueStr = string.format("+%s", valueStr)
  end
  if attrData and attrData.perAddCount and attrData.perAddCount > 0 then
    local perVal = attrData.perAddCount / 100
    local perAddValue = self:_GetAttrValue() * perVal
    if not self.useOriginDemical then
      perAddValue = math.ceil(perAddValue)
    end
    valueStr = string.format("%s <AttrGreen:+ %s>", valueStr, perAddValue)
  end
  if self:_ShowAddValue() and attrData and attrData.addCount and attrData.addCount > 0 then
    if attrData and attrData.isPercent then
      valueStr = string.format("%s <AttrGreen:+ %s>" .. "<AttrGreen:%%>", valueStr, attrData.addCount)
    else
      valueStr = string.format("%s <AttrGreen:+ %s>", valueStr, attrData.addCount)
    end
  end
  return valueStr
end

function UICompAwakerAttrItem:_GetAttrIcon()
  if self.showAttr then
    return self.showAttr.imageIcon or ""
  end
  if self.useDefaultIcon then
    return ""
  end
  if not self.clientAttr then
    return ""
  end
  local tid = self.clientAttr.tid
  if not tid or 0 == tid then
    return ""
  end
  return DT.ActorAttrType[tid].Icon
end

function UICompAwakerAttrItem:_GetAttrLevel()
  local attrData = self.clientAttr
  do return AwakerTrinketDataUtils.GetTrinketSubAttrLevel end
  return AwakerTrinketDataUtils.GetTrinketSubAttrLevel, attrData
end

function UICompAwakerAttrItem:OnEnterComponent()
  self:SetText(self.ui.Text_Name, self:_GetAttrName())
  self:_InitNameAutoAdaption()
  self:SetText(self.ui.Text_Count, self:_GetAttrCount())
  if self.ui.Text_Prop_Level then
    self:SetText(self.ui.Text_Prop_Level, self.level or self:_GetAttrLevel())
  end
  self:SetImage(self.ui.Image_Icon, self:_GetAttrIcon())
  if self.ui.Group_Icon then
    self.ui.Group_Icon:SetActive(self:_GroupTipVisibleFunc())
  end
  if self.ui.Btn_Icon then
    self:AddButtonClickListener(self.ui.Btn_Icon, function()
      self:_OnClickTip(self.ui.Btn_Icon)
    end)
  end
end

function UICompAwakerAttrItem:_InitNameAutoAdaption()
  if not self.ui.Text_Name then
    return
  end
  if not self._nameAutoAdaptionComp then
    self._nameAutoAdaptionComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name, 0, 0, 0, nil, true)
  end
  if self._nameAutoAdaptionComp then
    local rect = self.ui.Text_Name.transform.rect
    local w = rect.width
    local h = rect.height
    local cfg_adaption = {
      fontSize = 32,
      autoSizeCN = true,
      autoSizeOther = true,
      alignmentCN = TextAlignmentOptions.Left,
      alignmentOther = TextAlignmentOptions.Left,
      widthCN = w,
      widthOther = w,
      height = h,
      x = 0,
      y = 0,
      pivotX = 0,
      pivotY = 0.5,
      anchorX = 0,
      anchorY = 0.5,
      contentSize = h
    }
    local cfg_init = {
      fontSize = 32,
      autoSizeCN = true,
      autoSizeOther = true,
      alignmentCN = TextAlignmentOptions.Left,
      alignmentOther = TextAlignmentOptions.Left,
      widthCN = w,
      widthOther = w,
      height = h,
      x = 0,
      y = 0,
      pivotX = 0,
      pivotY = 0.5,
      anchorX = 0,
      anchorY = 0.5,
      contentSize = h
    }
    self._nameAutoAdaptionComp:ForceUpdate({
      limitPercent = 1,
      lineLimit = 1,
      miniFontSize = 18,
      maxFontSize = 32,
      initCfg = cfg_init,
      adaptionCfg = cfg_adaption
    })
  end
end

function UICompAwakerAttrItem:_ShowAddValue()
  return false
end

function UICompAwakerAttrItem:_GroupTipVisibleFunc()
  return self.clientAttr.attrDesc ~= nil and self.clientAttr.attrDesc ~= ""
end

function UICompAwakerAttrItem:_OnClickTip(root)
  if not root then
    return
  end
  local tipData = {
    title = self.clientAttr.name,
    desc = self.clientAttr.attrDesc
  }
  Alert.ShowToolTipsByData(tipData, root)
end

return UICompAwakerAttrItem
