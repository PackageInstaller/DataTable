local TrinketUpdradeSuccessPanel, Super = System.NewClass("TrinketUpdradeSuccessPanel", UIBasePanel)
TrinketUpdradeSuccessPanel.uiResCls = UI_Michi_Popup_Strengthen_SucceedResource

function TrinketUpdradeSuccessPanel:ctor(uid, preLevel, curLevel, closeFunc)
  Super.ctor(self)
  self.uid = uid
  self.preLevel = preLevel
  self.curLevel = curLevel
  self.closeFunc = closeFunc
end

function TrinketUpdradeSuccessPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    if self.closeFunc then
      self.closeFunc()
    end
    self:Close()
  end)
  binder:SetText(self.ui.Text_Title, LT.Text("TrinketUpgradeLevelSuccess"))
  binder:SetText(self.ui.Text_Foundation_1, "+" .. self.preLevel)
  binder:SetText(self.ui.Text_Hoist_1, "+" .. self.curLevel)
  local targetItemData = ItemDataUtils.GetItemByUid(self.uid)
  local mainAttr
  for _, attr in pairs(targetItemData.attrs) do
    if 1 == attr.index then
      mainAttr = attr
      break
    end
  end
  if mainAttr then
    local tid = mainAttr.attrId
    local attrType = DT.ActorAttrType[tid]
    binder:BindToImage(self.ui.Image_Icon, function()
      return attrType.Icon
    end)
    binder:SetText(self.ui.Text_Main, LT.Text(attrType.Text))
    local preValue = AwakerTrinketDataUtils.GetTrinketMainAttrValue(self.preLevel, tid)
    local curValue = AwakerTrinketDataUtils.GetTrinketMainAttrValue(self.curLevel, tid)
    local preText, curText
    if AwakerTrinketDataUtils.IsTrinketBindBonusActive(targetItemData) then
      preText = AwakerTrinketDataUtils.GetAttrFmtStringByValue(AwakerTrinketDataUtils.GetBindBonusDisplayCount(preValue, attrType.Percentage), attrType.Percentage)
      curText = AwakerTrinketDataUtils.GetAttrFmtStringByValue(AwakerTrinketDataUtils.GetBindBonusDisplayCount(curValue, attrType.Percentage), attrType.Percentage)
      preText = AwakerTrinketDataUtils.GetBindBonusAttrText(preText)
      curText = AwakerTrinketDataUtils.GetBindBonusAttrText(curText)
    else
      preText = AwakerTrinketDataUtils.GetAttrFmtStringByValue(preValue, attrType.Percentage)
      curText = AwakerTrinketDataUtils.GetAttrFmtStringByValue(curValue, attrType.Percentage)
    end
    binder:SetText(self.ui.Text_Foundation_2, preText)
    binder:SetText(self.ui.Text_Hoist_2, curText)
  end
end

return TrinketUpdradeSuccessPanel
