_class("UISailingRewardBannerItem", UICustomWidget)
UISailingRewardBannerItem = UISailingRewardBannerItem

function UISailingRewardBannerItem:OnShow()
end

function UISailingRewardBannerItem:OnHide()
  self._matRes = {}
end

function UISailingRewardBannerItem:SetData(cfg, callbcak, begindrag, drag, enddrag)
  self._cfg = cfg
  self._callback = callbcak
  self._beginDrag = begindrag
  self._drag = drag
  self._endDrag = enddrag
  self._btn = self:GetGameObject("btn")
  self._icon = self:GetUIComponent("RawImageLoader", "ad")
  self._icon:LoadImage(self._cfg.data.Icon)
  self._module = self:GetModule(SailingMissionModule)
  self._totalProgressNum = self:GetUIComponent("UILocalizedTMP", "progressNum")
  self._matRes = {}
  self:SetFontMat(self._totalProgressNum, "sailing_reward_progress_num_mat.mat")
  local progress = self._module:GetHistoryProgress()
  if self._totalProgressNum then
    self._totalProgressNum:SetText(tostring(progress))
  end
  self._unlockInfoAreaGo = self:GetGameObject("unlockInfoArea")
  self._unlockInfoText = self:GetUIComponent("UILocalizationText", "unlockInfoText")
  self._descGo = self:GetGameObject("descGo")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._titleGo = self:GetGameObject("titleGo")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._checkDetailBtnGo = self:GetGameObject("checkDetailBtn")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.BeginDrag, self._beginDrag)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.Drag, self._drag)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn), UIEvent.EndDrag, self._endDrag)
  self:AttachEvent(GameEventType.SailingGetProgressReward, self.OnSailingGetProgressReward)
  local unlockInfo = self._cfg.data.UnlockInfo
  if unlockInfo then
    self._unlockInfoText:SetText(StringTable.Get(unlockInfo))
    self._unlockInfoAreaGo:SetActive(true)
  else
    self._unlockInfoAreaGo:SetActive(false)
  end
  if self._cfg.data.Title then
    self._titleGo:SetActive(true)
    self._title:SetText(StringTable.Get(self._cfg.data.Title))
  else
    self._title:SetActive(false)
  end
  if self._cfg.data.Desc then
    self._descGo:SetActive(true)
    self._desc:SetText(StringTable.Get(self._cfg.data.Desc))
  else
    self._descGo:SetActive(false)
  end
  if self._cfg.data.ItemID then
    self._checkDetailBtnGo:SetActive(true)
    self._curDetailItemID = self._cfg.data.ItemID
  else
    self._checkDetailBtnGo:SetActive(false)
    self._curDetailItemID = 0
  end
end

function UISailingRewardBannerItem:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  table.insert(self._matRes, res)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UISailingRewardBannerItem:OnSailingGetProgressReward(cfgIDList)
end

function UISailingRewardBannerItem:BtnOnClick()
end

function UISailingRewardBannerItem:Dispose()
  self._cfg = nil
  self._callback = nil
  self._icon = nil
end

function UISailingRewardBannerItem:CheckRewardBtnOnClick()
  if self._callback then
    self._callback(self._cfg.data.RewardID)
  end
end

function UISailingRewardBannerItem:CheckDetailBtnOnClick(go)
  if self._curDetailItemID and self._curDetailItemID > 0 then
    local petModule = GameGlobal.GetModule(PetModule)
    if petModule:IsPetSkinID(self._curDetailItemID) then
      local skinId = petModule:GetSkinIDFromItemID(self._curDetailItemID)
      GameGlobal.UIStateManager():ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, skinId)
      return
    end
    if petModule:IsPetID(self._curDetailItemID) then
      GameGlobal.UIStateManager():ShowDialog("UIShopPetDetailController", self._curDetailItemID)
      return
    end
  end
end
