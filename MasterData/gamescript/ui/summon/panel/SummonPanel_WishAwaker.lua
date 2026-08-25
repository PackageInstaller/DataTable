local SummonPanel_WishAwaker = {}

function SummonPanel_WishAwaker:OnBind(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.OnChooseWishAwaker, System.fn(self, SummonPanel_WishAwaker._OnChooseWishAwaker))
end

function SummonPanel_WishAwaker:_OnChooseWishAwaker(summonId, awakerTidList)
  if self._wishAwakerPoolCfg and self._wishAwakerPoolCfg.ID == summonId then
    SummonPanel_WishAwaker.RefreshPanel(self)
    self:RefreshShow(self.binder, self._wishAwakerPoolCfg)
    self:_RefreshOnceSummonBtn()
  end
end

function SummonPanel_WishAwaker:BeginPoolShow(_, poolCfg, poolData)
  self._wishAwakerPoolCfg = poolCfg
  SummonPanel_WishAwaker.RefreshPanel(self)
end

function SummonPanel_WishAwaker:HideWishAwakerComp()
  if self._wishAwakerComp then
    self._wishAwakerComp:Hide()
  end
end

function SummonPanel_WishAwaker:RefreshPanel()
  if not self._wishAwakerPoolCfg or self._wishAwakerPoolCfg.Type ~= CommonDefine.SummonPoolType.WishPool then
    SummonPanel_WishAwaker.HideWishAwakerComp(self)
    return
  end
  if not self._wishAwakerComp then
    local compCls = SummonWishAwakerComp
    local uiResCls = compCls.uiResCls
    local comp = self.binder:BindNewComponent(self.ui.Image_D_Bg, compCls, uiResCls, self._wishAwakerPoolCfg)
    self._wishAwakerComp = comp
  end
  self._wishAwakerComp:Show()
end

function SummonPanel_WishAwaker:IsChoosedAwaker()
  local id2SummonData = SummonDataUtils.GetId2SummonData(self._wishAwakerPoolCfg.ID)
  return nil ~= id2SummonData
end

function SummonPanel_WishAwaker:GetWishAwakerDesc(poolId, desc1)
  if SummonDataUtils.GetId2SummonData(poolId) ~= nil then
    return desc1
  end
  do return LT.Text end
  return LT.Text, "SummonType_14SummonDesc2"
end

function SummonPanel_WishAwaker:GetTypeDesc(poolId, showText)
  if SummonDataUtils.GetId2SummonData(poolId) ~= nil then
    return showText
  end
  local selectNum = SummonDataUtils.GetWishAwakerSelectNum(poolId)
  do return LT.Textf, "SummonType_14SummonDesc1" end
  return LT.Textf, "SummonType_14SummonDesc1", selectNum
end

function SummonPanel_WishAwaker.MergeInto(targetClass)
  for k, v in pairs(SummonPanel_WishAwaker) do
    if "MergeInto" ~= k and type(v) == "function" and rawget(targetClass, k) == nil then
      targetClass[k] = v
    end
  end
end

SummonPanel_WishAwaker.MergeInto(SummonPanel)
return SummonPanel_WishAwaker
