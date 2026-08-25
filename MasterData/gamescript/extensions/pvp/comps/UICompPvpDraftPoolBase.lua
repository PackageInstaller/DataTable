local UICompPvpDraftPoolBase, Super = NewViewComponent("UICompPvpDraftPoolBase")

function UICompPvpDraftPoolBase:ctor(uiNode, view, collectionTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Item_RotationCardResource(uiNode)
  self._collectionTid = collectionTid
end

function UICompPvpDraftPoolBase:_GetCollectImage()
  Logger.Error("Please override UICompPvpDraftPoolBase:_GetCollectImage")
end

function UICompPvpDraftPoolBase:_GetCollectName()
  Logger.Error("Please override UICompPvpDraftPoolBase:_GetCollectName")
end

function UICompPvpDraftPoolBase:_RefreshQualityBg()
  Logger.Error("Please override UICompPvpDraftPoolBase:_RefreshQualityBg")
end

function UICompPvpDraftPoolBase:_GetAwakerTid()
  return nil
end

function UICompPvpDraftPoolBase:_IsCanNotSelect()
  Logger.Error("Please override UICompPvpDraftPoolBase:_IsCanNotSelect")
end

function UICompPvpDraftPoolBase:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
end

function UICompPvpDraftPoolBase:_OnPvpDraftDataUpdate()
  local isChoosingPlayerChanged = self:_IsChoosingPlayerChanged()
  if isChoosingPlayerChanged and PvpDraftModel.Instance:IsPlayerSelectingPhase() then
    local taretCollectionTid = PvpDraftModel.Instance:GetPlayerSelectCollectionTid()
    if taretCollectionTid == self._collectionTid then
      self:_OnClick()
    end
  end
end

function UICompPvpDraftPoolBase:_OnClick()
  if self:_IsCanNotSelect() or self:_IsPicked() then
    return
  end
  if not self:_IsChoosingPlayerChanged() and self:_IsSelected() then
    return
  end
  if PvpDraftModel.Instance:IsPlayerSelectingPhase() then
    PvpController.Instance:ReqDraftChooseCollect(self._collectionTid, false)
  end
  PvpDraftModel.Instance:SetPlayerSelectCollectionTid(self._collectionTid)
end

function UICompPvpDraftPoolBase:_IsPicked()
  do return PvpDraftModel.Instance.IsCollectionPicked, PvpDraftModel.Instance end
  return PvpDraftModel.Instance.IsCollectionPicked, PvpDraftModel.Instance, self._collectionTid
end

function UICompPvpDraftPoolBase:_IsSelected()
  do return PvpDraftModel.Instance.IsCollectionSelected, PvpDraftModel.Instance end
  return PvpDraftModel.Instance.IsCollectionSelected, PvpDraftModel.Instance, self._collectionTid
end

function UICompPvpDraftPoolBase:_IsChoosingPlayerChanged()
  local choosingUid = PvpDraftModel.Instance:GetChoosingUid()
  local lastChoosingUid = PvpDraftModel.Instance:GetLastChoosingUid()
  local isChoosingPlayerChanged = choosingUid ~= lastChoosingUid
  return isChoosingPlayerChanged
end

function UICompPvpDraftPoolBase:OnEnterComponent()
  self:BindEvent(EventMgr.Instance.PvpDraftDataUpdate, System.fn(self, self._OnPvpDraftDataUpdate))
  self:_RefreshView()
end

function UICompPvpDraftPoolBase:_RefreshView()
  if not self._collectionTid then
    self:SetActive(self.ui.Group_Ban, true)
    return
  end
  self:SetActive(self.ui.Group_Ban, false)
  self:_RefreshBaseInfo()
  self:_RefreshPickedState()
  self:_RefreshSelectedState()
  self:_RefreshCanNotSelectState()
end

function UICompPvpDraftPoolBase:_RefreshPickedState()
  self:SetActive(self.ui.Group_Ban, self:_IsPicked())
end

function UICompPvpDraftPoolBase:_RefreshSelectedState()
  self:SetActive(self.ui.Group_Select, self:_IsSelected() and not self:_IsPicked() and not self:_IsCanNotSelect())
end

function UICompPvpDraftPoolBase:_RefreshCanNotSelectState()
  self:SetActive(self.ui.Group_Selected, self:_IsCanNotSelect())
end

function UICompPvpDraftPoolBase:_RefreshBaseInfo()
  self:SetImage(self.ui.Image_Card, self:_GetCollectImage())
  self:SetText(self.ui.Text_Name, self:_GetCollectName())
  self:_RefreshQualityBg()
  self:_RefreshAwakerFavor()
end

function UICompPvpDraftPoolBase:_RefreshAwakerFavor()
  if not self.ui.Image_AwakerFavor then
    return
  end
  local awakerTid = self:_GetAwakerTid()
  local showFavor = nil ~= awakerTid and FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerTid, nil) or false
  self:SetActive(self.ui.Image_AwakerFavor, showFavor)
end

return UICompPvpDraftPoolBase
