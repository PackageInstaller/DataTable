local UICompPvpDraftAdjustItemBase, Super = NewViewComponent("UICompPvpDraftAdjustItemBase")

function UICompPvpDraftAdjustItemBase:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Item_RotationCardResource(uiNode)
  self._collectionTid = data.collectionTid
  self._clickCb = data.clickCb
end

function UICompPvpDraftAdjustItemBase:_GetCollectImage()
  Logger.Error("Please override UICompPvpDraftAdjustItemBase:_GetCollectImage")
end

function UICompPvpDraftAdjustItemBase:_RefreshQualityBg()
  Logger.Error("Please override UICompPvpDraftAdjustItemBase:_GetCollectImage")
end

function UICompPvpDraftAdjustItemBase:_GetAwakerTid()
  return nil
end

function UICompPvpDraftAdjustItemBase:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
  self:BindEvent(EventMgr.Instance.PvpAdjustCollectionChanged, System.fn(self, self._OnPvpAdjustCollectionChanged))
end

function UICompPvpDraftAdjustItemBase:_OnPvpAdjustCollectionChanged()
  self:_RefreshSelectState()
end

function UICompPvpDraftAdjustItemBase:_OnClick()
  if self._clickCb then
    self._clickCb(self._collectionTid)
  end
end

function UICompPvpDraftAdjustItemBase:OnEnterComponent()
  self:_RefreshView()
end

function UICompPvpDraftAdjustItemBase:_RefreshSelectState()
  self:SetActive(self.ui.Group_Select, PvpDraftModel.Instance:GetAdjustCollectionTid() == self._collectionTid)
end

function UICompPvpDraftAdjustItemBase:_RefreshView()
  self:_RefreshBaseInfo()
  self:_RefreshVisible()
end

function UICompPvpDraftAdjustItemBase:_RefreshVisible()
  self:SetActive(self.ui.Group_Mask, true)
end

function UICompPvpDraftAdjustItemBase:_RefreshBaseInfo()
  self:SetImage(self.ui.Image_Card, self:_GetCollectImage(), false)
  self:SetText(self.ui.Text_Name, PvpCollectCfgUtils.GetCollectionName(self._collectionTid))
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name)
  if comp then
    comp:SetBtn(self.ui.Btn_Click)
  end
  self:_RefreshQualityBg()
  self:_RefreshAwakerFavor()
end

function UICompPvpDraftAdjustItemBase:_RefreshAwakerFavor()
  if not self.ui.Image_AwakerFavor then
    return
  end
  local awakerTid = self:_GetAwakerTid()
  local showFavor = nil ~= awakerTid and FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerTid, nil) or false
  self:SetActive(self.ui.Image_AwakerFavor, showFavor)
end

return UICompPvpDraftAdjustItemBase
