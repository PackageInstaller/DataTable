_class("UIActivityN28Shop", UIController)
UIActivityN28Shop = UIActivityN28Shop

function UIActivityN28Shop:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIActivityN28Const:New()
  self._activityConst:LoadData(TT, res)
  local shopComponent, shopComponentInfo = self._activityConst:GetShopComponent()
  self._shopComponent = shopComponent
  self._shopCmpInfo = shopComponentInfo
end

function UIActivityN28Shop:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    self:Close()
  end, nil, nil, false)
  self._isShowPetSpeek = false
  self._showTime = 5
  self._showTimer = 0
  self._petSpeekLabel = self:GetUIComponent("UILocalizationText", "Speek")
  self._iconInfo = self:GetGameObject("IconInfo")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._timeDownLabel = self:GetUIComponent("UILocalizationText", "TimeDown")
  self._smallLoader = self:GetUIComponent("UISelectObjectPath", "SmallList")
  self._bigLoader = self:GetUIComponent("UISelectObjectPath", "Big")
  self._specialPrice = self:GetUIComponent("UILocalizationText", "specialPrice")
  self._specialMaskObj = self:GetGameObject("mask")
  self._specialCount = self:GetUIComponent("UILocalizationText", "specialCount")
  self._maskAnim = self:GetUIComponent("Animation", "mask")
  self._petSpeekAnim = self:GetUIComponent("Animation", "PetSpeek")
  self._iconInfoAnim = self:GetUIComponent("Animation", "IconInfo")
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
  self:InitUI()
  self:_SetSpine()
  GameGlobal.TaskManager():StartTask(self._PlayIn, self)
end

function UIActivityN28Shop:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
  if self._isShowPetSpeek then
    self._showTimer = self._showTimer + deltaTimeMS / 1000
    if self._showTimer >= self._showTime then
      self._isShowPetSpeek = false
      self._petSpeekAnim:Play("uieff_N28_Shop_PetSpeek_out")
    end
  end
end

function UIActivityN28Shop:OnHide()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
end

function UIActivityN28Shop:Close()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN28ActivityMainRedStatusRefresh)
  GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
end

function UIActivityN28Shop:_SetSpine()
  self._spine = UIWidgetHelper.SetSpineLoad(self, "spine", "dina_n27_spine_idle")
  UIWidgetHelper.SetSpineAnimation(self._spine, 0, "Story_norm", true)
end

function UIActivityN28Shop:_PlayIn(TT)
  self:Lock("UIActivityN28Shop_PlayIn")
  self._playin = true
  YIELD(TT, 1000)
  self._playin = false
  self:UnLock("UIActivityN28Shop_PlayIn")
end

function UIActivityN28Shop:CloseCoro(TT)
  self:Lock("UIActivityN20Shop_CloseCoro")
  local campModule = GameGlobal.GetModule(CampaignModule)
  local campaign = self._activityConst:GetCampaign()
  CutsceneManager.ExcuteCutsceneIn_Shot()
  campModule:CampaignSwitchState(true, UIStateType.UIActivityN28MainController, UIStateType.UIMain, nil, campaign._id)
  self:UnLock("UIActivityN20Shop_CloseCoro")
end

function UIActivityN28Shop:InitUI()
  self:RefreshSpecialGood()
  self:RefreshGoodList(true)
  self:RefreshItemStatus()
  self:RefreshActivityRemainTime()
end

function UIActivityN28Shop:RefreshUI(goodID)
  self:RefreshSpecialGood(goodID)
  self:RefreshGoodList(false, goodID)
  self:RefreshItemStatus()
end

function UIActivityN28Shop:RefreshItemStatus()
  local icon, count = self._shopComponent:GetCostItemIconText()
  self._iconLoader:LoadImage(icon)
  self._countLabel:SetText(UIActivityN28Helper.GetItemCountStr(7, count, "#b07f08", "#ffffff"))
end

function UIActivityN28Shop:RefreshActivityRemainTime()
  local status, seconds = self._activityConst:GetShopComponentStatus()
  local timeStr = UIActivityN28Helper.GetTimeString(seconds)
  local timeTips = StringTable.Get("str_n28_activity_remain_time_shop", timeStr)
  self._timeDownLabel:SetText(timeTips)
end

function UIActivityN28Shop:RefreshSpecialGood(goodID)
  local specialItem = self._shopCmpInfo.m_exchange_item_list[1]
  self._specialPrice:SetText(specialItem.m_cost_count)
  self._specialCount:SetText(StringTable.Get("str_n28_shop_special_item_count") .. " " .. specialItem.m_can_exchange_count)
  if specialItem.m_can_exchange_count == 0 then
    self._specialMaskObj:SetActive(true)
    self._specialPrice.color = Color(0.49019607843137253, 0.3607843137254902, 0.13333333333333333, 1.0)
    if goodID and goodID == specialItem.m_id then
      self._maskAnim:Play("uieff_UIN28shop_mask_Finish")
    end
  else
    local icon, count = self._shopComponent:GetCostItemIconText()
    if count >= specialItem.m_cost_count then
      self._specialPrice.color = Color(0.49019607843137253, 0.3607843137254902, 0.13333333333333333, 1.0)
    else
      self._specialPrice.color = Color(1.0, 0 / 255, 0 / 255, 1.0)
    end
    self._specialMaskObj:SetActive(false)
  end
end

function UIActivityN28Shop:RefreshGoodList(playAnim, goodID)
  local itemList = self._shopCmpInfo.m_exchange_item_list
  if playAnim then
    self:StartTask(self._CreateItemAnim, self, itemList, self._shopComponent, goodID)
  else
    self._smallLoader:SpawnObjects("UIActivityN28ShopItem", #itemList - 1)
    local items = self._smallLoader:GetAllSpawnList()
    for i = 1, #items do
      items[i]:Refresh(itemList[i + 1], self._shopComponent, goodID, function(itemInfo)
        self:StartTask(self.ExchangeItem, self, itemInfo, goodID)
      end)
    end
  end
end

function UIActivityN28Shop:_CreateItemAnim(TT, itemList, shopCom, goodID)
  self:Lock("UIActivityN20Shop_CreateItemAnim")
  self._smallLoader:SpawnObjects("UIActivityN28ShopItem", #itemList - 1)
  local items = self._smallLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetVisible(false)
  end
  for i = 1, #items do
    items[i]:Refresh(itemList[i + 1], shopCom, goodID, function(itemInfo)
      self:StartTask(self.ExchangeItem, self, itemInfo)
    end)
    YIELD(TT, 50)
  end
  self:UnLock("UIActivityN20Shop_CreateItemAnim")
end

function UIActivityN28Shop:ExchangeItem(TT, itemInfo)
  local uiItemData = DCampaignShopItemBase:New()
  uiItemData:Refresh(itemInfo, self._shopComponent)
  local useNormalDlg = false
  if not uiItemData:IsUnLimit() then
    local remainCount = uiItemData:GetRemainCount()
    if remainCount <= 0 then
      return
    end
    if remainCount == 1 then
      useNormalDlg = true
    end
  end
  if useNormalDlg then
    self:ShowDialog("UICampaignShopConfirmNormalController", uiItemData)
  else
    self:ShowDialog("UICampaignShopConfirmDetailController", uiItemData)
  end
end

function UIActivityN28Shop:IconInfoOnClick()
  self:StartTask(self.PlayIconInfoOutAnim, self)
end

function UIActivityN28Shop:PlayIconInfoOutAnim(TT)
  self:Lock("UIActivityN28Shop_PlayIconInfoOutAnim")
  self._iconInfoAnim:Play("uieff_N28_Shop_IconInfo_out")
  YIELD(TT, 500)
  self._iconInfo:SetActive(false)
  self:UnLock("UIActivityN28Shop_PlayIconInfoOutAnim")
end

function UIActivityN28Shop:CountBGOnClick()
  self._iconInfo:SetActive(true)
end

function UIActivityN28Shop:PetBtnOnClick()
  if self._isShowPetSpeek then
    return
  end
  self._petSpeekAnim:Play("uieff_N28_Shop_PetSpeek_in")
  self._isShowPetSpeek = true
  local index = math.random(1, 5)
  local str = StringTable.Get("str_n28_shop_pet_des" .. index)
  self._petSpeekLabel:SetText(str)
  self._showTimer = 0
end

function UIActivityN28Shop:SpecialBtnOnClick()
  local itemInfo = self._shopCmpInfo.m_exchange_item_list[1]
  if itemInfo.m_exchange_limit_count ~= -1 and itemInfo.m_can_exchange_count == 0 then
    ToastManager.ShowToast(StringTable.Get("str_n26_item_has_empty_tips"))
    return
  end
  self:StartTask(self.ExchangeItem, self, itemInfo)
end
