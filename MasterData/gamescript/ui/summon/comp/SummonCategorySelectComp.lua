local SummonCategorySelectComp, Super = System.NewComponent("SummonCategorySelectComp")
SummonCategorySelectComp.uiResCls = UI_Summon_Panel_SelectLimitResource

function SummonCategorySelectComp:ctor(uiNode, poolCfg)
  Super.ctor(self)
  self.ui = SummonCategorySelectComp.uiResCls(uiNode)
  self._awakerItemList = {}
  self.poolCfg = poolCfg
end

function SummonCategorySelectComp:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.Btn_Choose, System.fn(self, self._OnClickChoose), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "SummonSelectAwakeBtnTips"
  end)
  binder:BindToVisible(self.ui.Btn_Choose, function()
    return not self:IsChoosedAwaker()
  end)
  binder:BindToRaw(function(_, _)
    self:_RefreshSelectedAwakerBySlot(self.poolCfg and self.poolCfg.ID)
  end, function()
    if not self.poolCfg then
      return nil
    end
    do return SummonDataUtils.GetId2SummonData end
    return SummonDataUtils.GetId2SummonData, self.poolCfg.ID
  end)
  if self.ui.Group_SelectedAwaker then
    binder:BindToVisible(self.ui.Group_SelectedAwaker, function()
      do return self.IsChoosedAwaker end
      return self.IsChoosedAwaker, self
    end)
  end
  self:BindDesc()
end

function SummonCategorySelectComp:BindDesc()
  if self.ui.Group_SelectTip then
    self.binder:BindToVisible(self.ui.Group_SelectTip, function()
      return not self:IsChoosedAwaker()
    end)
  end
  if not self.ui.Text_SelectAwake then
    return
  end
  self.binder:BindToText(self.ui.Text_SelectAwake, function()
    local selectNum = SummonCategorySelectDataUtils.GetSelectNum(self.poolCfg and self.poolCfg.ID)
    if not self:IsChoosedAwaker() then
      do return LT.Textf, "SummonType_17SelectTips" end
      return LT.Textf, "SummonType_17SelectTips", selectNum
    end
    return ""
  end)
  self.binder:BindToText(self.ui.Text_C_Title, function()
    do return LT.Text end
    return LT.Text, "SummonType_17SelectedDesc"
  end)
end

function SummonCategorySelectComp:_RefreshSelectedAwakerBySlot(poolId)
  if not poolId or not self:IsChoosedAwaker() then
    self.binder:SetActive(self.ui.Group_SelectedAwaker, false)
    return
  end
  self.binder:SetActive(self.ui.Group_SelectedAwaker, true)
  self.binder:SetActive(self.ui.UI_Summon_Item_SelectLimit, false)
  local itemGo = self.ui.UI_Summon_Item_SelectLimit
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  for slot = 1, selectNum do
    local itemTid = SummonCategorySelectDataUtils.GetConfirmedSlotItemTid(poolId, slot)
    local item = self._awakerItemList[slot]
    if not item then
      local gameObj = self.binder:Instantiate(itemGo, itemGo.transform.parent)
      self.binder:SetActive(gameObj, true)
      item = self.binder:BindComponent(SummonSelectLimitItemComp(gameObj, itemTid, true))
      self._awakerItemList[slot] = item
    else
      self.binder:SetActive(item.ui.uiNode, true)
      item:UpdateItemTid(itemTid)
    end
  end
  for slot = selectNum + 1, #self._awakerItemList do
    local item = self._awakerItemList[slot]
    if item and item.ui then
      self.binder:SetActive(item.ui.uiNode, false)
    end
  end
end

function SummonCategorySelectComp:Show()
  self.binder:SetActive(self.ui.uiNode, true)
end

function SummonCategorySelectComp:Hide()
  self.binder:SetActive(self.ui.uiNode, false)
end

function SummonCategorySelectComp:_OnClickChoose()
  SummonCategorySelectController.Instance:OnOpenSelectPopup(self.poolCfg and self.poolCfg.ID)
end

function SummonCategorySelectComp:IsChoosedAwaker()
  do return SummonDataUtils.HasConfirmedSelection end
  return SummonDataUtils.HasConfirmedSelection, self.poolCfg and self.poolCfg.ID
end

function SummonCategorySelectComp:RefreshSelected()
  self:_RefreshSelectedAwakerBySlot(self.poolCfg and self.poolCfg.ID)
end

return SummonCategorySelectComp
