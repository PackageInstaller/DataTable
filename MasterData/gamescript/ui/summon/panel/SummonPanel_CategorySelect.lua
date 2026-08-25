local SummonPanel_CategorySelect = {}

function SummonPanel_CategorySelect:OnBind(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.OnChooseCategorySelectAwaker, System.fn(self, SummonPanel_CategorySelect._OnChooseCategorySelectAwaker))
end

function SummonPanel_CategorySelect:_OnChooseCategorySelectAwaker(summonId, _)
  if self._categorySelectPoolCfg and self._categorySelectPoolCfg.ID == summonId then
    SummonPanel_CategorySelect.RefreshPanel(self)
    self:RefreshShow(self.binder, self._categorySelectPoolCfg)
    self:_RefreshOnceSummonBtn()
    if self._categorySelectComp then
      self._categorySelectComp:RefreshSelected()
    end
  end
end

function SummonPanel_CategorySelect:BeginPoolShow(_, poolCfg, poolData)
  self._categorySelectPoolCfg = poolCfg
  SummonPanel_CategorySelect.RefreshPanel(self)
end

function SummonPanel_CategorySelect:HideCategorySelectComp()
  if self._categorySelectComp then
    self._categorySelectComp:Hide()
  end
end

function SummonPanel_CategorySelect:RefreshPanel()
  if not self._categorySelectPoolCfg or self._categorySelectPoolCfg.Type ~= CommonDefine.SummonPoolType.CategorySelect then
    SummonPanel_CategorySelect.HideCategorySelectComp(self)
    return
  end
  if not self._categorySelectComp then
    local compCls = SummonCategorySelectComp
    local uiResCls = compCls.uiResCls
    local comp = self.binder:BindNewComponent(self.ui.Image_D_Bg, compCls, uiResCls, self._categorySelectPoolCfg)
    self._categorySelectComp = comp
  else
    self._categorySelectComp.poolCfg = self._categorySelectPoolCfg
    self._categorySelectComp:RefreshSelected()
  end
  self._categorySelectComp:Show()
end

function SummonPanel_CategorySelect:GetCategorySelectDesc(poolId, desc1)
  if SummonDataUtils.HasConfirmedSelection(poolId) then
    return desc1 or ""
  end
  do return LT.Text end
  return LT.Text, "SummonType_17SummonDesc2"
end

function SummonPanel_CategorySelect:GetTypeDesc(poolId, showText)
  if SummonDataUtils.HasConfirmedSelection(poolId) then
    return showText
  end
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  do return LT.Textf, "SummonType_17SummonDesc1" end
  return LT.Textf, "SummonType_17SummonDesc1", selectNum
end

return SummonPanel_CategorySelect
