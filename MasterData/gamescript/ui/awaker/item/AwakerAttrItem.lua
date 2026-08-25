local AwakerAttrItem, Super = System.NewComponent("AwakerAttrItem")

function AwakerAttrItem:ctor(res, data)
  Super.ctor(self)
  self.ui = data.resourceCls(res)
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
  self.awakerData = data.awakerData
  self.awakerTid = data.awakerTid
  self.isPreview = data.isPreview
  self.previewLevel = data.previewLevel
end

function AwakerAttrItem:_GetAttrValue()
  if self.getAttrValue then
    do return end
    return self.getAttrValue
  else
    return self.clientAttr and self.clientAttr.count or 0
  end
end

function AwakerAttrItem:OnBind(binder)
  self.binder = binder
  self:_OnBindDiffPart()
  binder:BindToText(self.ui.Text_Name, function()
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
  end)
  binder:BindToText(self.ui.Text_Count, function()
    if self.isPreview then
      local attrName = DT.ActorAttrType[self.clientAttr.tid].Name
      local val = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(self.awakerTid, self.previewLevel, attrName, self.awakerData)
      do return LT.Textf, "MaxLvPreview_Txt" end
      return LT.Textf, "MaxLvPreview_Txt", val, self.awakerData, nil, nil, nil
    end
    if self.showAttr then
      return self.showAttr.textCount or ""
    end
    if self.specialShowText then
      return ""
    end
    local attrData = self.clientAttr
    local value = self:_GetAttrValue()
    if not self.useOriginDemical then
      value = tonumber(AwakerTrinketDataUtils.GetAttrValueString(value))
    end
    if self:_ShowAddValue() and attrData and attrData.addCount and attrData.addCount > 0 then
      value = value - attrData.addCount
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
  end)
  if self.ui.Text_Prop_Level then
    binder:BindToText(self.ui.Text_Prop_Level, function()
      return self.level or AwakerTrinketDataUtils.GetTrinketSubAttrLevel(self.clientAttr)
    end)
  end
  binder:BindToImage(self.ui.Image_Icon, function()
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
  end)
  if self.ui.Group_Icon then
    binder:BindToVisible(self.ui.Group_Icon, System.fn(self, self._GroupTipVisibleFunc))
  end
  if self.ui.Btn_Icon then
    binder:BindButtonClick(self.ui.Btn_Icon, function()
      self:_OnClickTip(self.ui.Btn_Icon)
    end)
  end
end

function AwakerAttrItem:_ShowAddValue()
  return false
end

function AwakerAttrItem:_GroupTipVisibleFunc()
  return self.clientAttr.attrDesc ~= nil and self.clientAttr.attrDesc ~= ""
end

function AwakerAttrItem:_OnBindDiffPart()
end

function AwakerAttrItem:_OnClickTip(root)
  if not root then
    return
  end
  local tipData = {
    title = self.clientAttr.name,
    desc = self.clientAttr.attrDesc
  }
  Alert.ShowToolTipsByData(tipData, root)
end

return AwakerAttrItem
