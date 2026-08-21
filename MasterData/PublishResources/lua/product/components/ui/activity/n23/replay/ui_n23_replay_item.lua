_class("UIN23ReplayItem", UICustomWidget)
UIN23ReplayItem = UIN23ReplayItem

function UIN23ReplayItem:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN23Data()
end

function UIN23ReplayItem:OnShow(uiParams)
  self.normal = self:GetGameObject("normal")
  self.lock = self:GetGameObject("lock")
  self.imgClip = self:GetUIComponent("RawImageLoader", "imgClip")
end

function UIN23ReplayItem:OnHide()
  self.imgClip:DestoryLastImage()
end

function UIN23ReplayItem:Flush(index, id, ui)
  self.index = index
  self.id = id
  self.ui = ui
  self.replay = self.data:GetReplayById(id)
  if self.replay:IsUnlock() then
    self.normal:SetActive(true)
    self.lock:SetActive(false)
    self.imgClip:LoadImage(self.replay.icon)
  else
    self.normal:SetActive(false)
    self.lock:SetActive(true)
  end
end

function UIN23ReplayItem:BtnOnClick(go)
  self.replay = self.data:GetReplayById(self.id)
  if self.replay:IsUnlock() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityShopBuySuccess, self.replay.exchangeId)
    self.ui:CloseDialog()
  else
    ToastManager.ShowToast(StringTable.Get("str_n23_replay_not_unlock"))
  end
end
