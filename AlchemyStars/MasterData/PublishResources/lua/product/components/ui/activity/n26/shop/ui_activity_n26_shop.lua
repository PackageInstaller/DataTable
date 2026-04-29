_class("UIActivityN26Shop", UIController)
UIActivityN26Shop = UIActivityN26Shop

function UIActivityN26Shop:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._activityConst = UIActivityN26Const:New()
  self._activityConst:LoadData(TT, res)
  local shopComponent, shopComponentInfo = self._activityConst:GetShopComponent()
  self._shopComponent = shopComponent
  self._shopCmpInfo = shopComponentInfo
end

function UIActivityN26Shop:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    self:Close()
  end, nil, nil, false)
  self._isShowPetSpeek = false
  self._showTime = 5
  self._showTimer = 0
  self._petSpeek = self:GetGameObject("PetSpeek")
  self._petSpeekAnim = self:GetUIComponent("Animation", "PetSpeek")
  self._petSpeekLabel = self:GetUIComponent("UILocalizationText", "Speek")
  self._iconInfo = self:GetGameObject("IconInfo")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._timeDownLabel = self:GetUIComponent("UILocalizationText", "TimeDown")
  self._smallLoader = self:GetUIComponent("UISelectObjectPath", "SmallList")
  self._bigLoader = self:GetUIComponent("UISelectObjectPath", "Big")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._iconInfoAnim = self:GetUIComponent("Animation", "IconInfo")
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
  self:InitUI()
  GameGlobal.TaskManager():StartTask(self._PlayIn, self)
end

function UIActivityN26Shop:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
  if self._isShowPetSpeek then
    self._showTimer = self._showTimer + deltaTimeMS / 1000
    if self._showTimer >= self._showTime then
      self._isShowPetSpeek = false
      self._petSpeekAnim:Play("uieff_N26_Shop_PetSpeek_out")
    end
  end
end

function UIActivityN26Shop:OnHide()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
end

function UIActivityN26Shop:Close()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN26ActivityMainRedStatusRefresh)
  GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
end

function UIActivityN26Shop:_SetSpine()
  self._spine = UIWidgetHelper.SetSpineLoad(self, "spine", "kalianyuhun_n20_spine_idle")
  UIWidgetHelper.SetSpineAnimation(self._spine, 0, "Story_norm", true)
  self._spine.skeleton.color = Color(1, 1, 1, 0)
end

function UIActivityN26Shop:_PlayIn(TT)
  self:Lock("UIActivityN26Shop_PlayIn")
  self._playin = true
  self._anim:Play("uieff_N26_Shop")
  YIELD(TT, 1000)
  self._playin = false
  self:UnLock("UIActivityN26Shop_PlayIn")
end

function UIActivityN26Shop:CloseCoro(TT)
  self:Lock("UIActivityN20Shop_CloseCoro")
  self:CloseDialog()
  self:UnLock("UIActivityN20Shop_CloseCoro")
end

function UIActivityN26Shop:InitUI()
  self:RefreshGoodList(true)
  self:RefreshItemStatus()
  self:RefreshActivityRemainTime()
end

function UIActivityN26Shop:RefreshUI()
  self:RefreshGoodList(false)
  self:RefreshItemStatus()
end

function UIActivityN26Shop:RefreshItemStatus()
  local icon, count = self._shopComponent:GetCostItemIconText()
  self._iconLoader:LoadImage(icon)
  self._countLabel:SetText(UIActivityN26Helper.GetItemCountStr(6, count, "#ece6df", "#edad23"))
end

function UIActivityN26Shop:RefreshActivityRemainTime()
  local status, seconds = self._activityConst:GetShopComponentStatus()
  local timeStr = UIActivityN26Helper.GetTimeString(seconds)
  local timeTips = StringTable.Get("str_n26_shop_close_time_tips", timeStr)
  self._timeDownLabel:SetText(timeTips)
end

function UIActivityN26Shop:RefreshGoodList(playAnim)
  local bigList = {}
  local smallList = {}
  for _, itemInfo in ipairs(self._shopCmpInfo.m_exchange_item_list) do
    local isSpecial = itemInfo.m_is_special
    if isSpecial then
      bigList[#bigList + 1] = itemInfo
    else
      smallList[#smallList + 1] = itemInfo
    end
  end
  if playAnim then
    self:StartTask(self.CreateItemAnim, self, bigList, smallList, self._shopComponent)
  else
    self._bigLoader:SpawnObjects("UIActivityN26ShopItem", #bigList)
    local items = self._bigLoader:GetAllSpawnList()
    for i = 1, #items do
      items[i]:Refresh(bigList[i], self._shopComponent, function(itemInfo)
        self:StartTask(self.ExchangeItem, self, itemInfo)
      end)
    end
    self._smallLoader:SpawnObjects("UIActivityN26ShopItem", #smallList)
    local items = self._smallLoader:GetAllSpawnList()
    for i = 1, #items do
      items[i]:Refresh(smallList[i], self._shopComponent, function(itemInfo)
        self:StartTask(self.ExchangeItem, self, itemInfo)
      end)
    end
  end
end

function UIActivityN26Shop:CreateItemAnim(TT, bigList, smallList, shopCom)
  self:Lock("UIActivityN20Shop_CreateItemAnim")
  self._bigLoader:SpawnObjects("UIActivityN26ShopItem", #bigList)
  local items = self._bigLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetVisible(false)
  end
  for i = 1, #items do
    items[i]:Refresh(bigList[i], shopCom, function(itemInfo)
      self:StartTask(self.ExchangeItem, self, itemInfo)
    end)
    YIELD(TT, 50)
  end
  self._smallLoader:SpawnObjects("UIActivityN26ShopItem", #smallList)
  local items = self._smallLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetVisible(false)
  end
  for i = 1, #items do
    items[i]:Refresh(smallList[i], shopCom, function(itemInfo)
      self:StartTask(self.ExchangeItem, self, itemInfo)
    end)
    YIELD(TT, 50)
  end
  self:UnLock("UIActivityN20Shop_CreateItemAnim")
end

function UIActivityN26Shop:ExchangeItem(TT, itemInfo)
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

function UIActivityN26Shop:IconInfoOnClick()
  self:StartTask(self.PlayIconInfoOutAnim, self)
end

function UIActivityN26Shop:PlayIconInfoOutAnim(TT)
  self:Lock("UIActivityN26Shop_PlayIconInfoOutAnim")
  self._iconInfoAnim:Play("uieff_N26_Shop_IconInfo_out")
  YIELD(TT, 500)
  self._iconInfo:SetActive(false)
  self:UnLock("UIActivityN26Shop_PlayIconInfoOutAnim")
end

function UIActivityN26Shop:CountBGOnClick()
  self._iconInfo:SetActive(true)
end

function UIActivityN26Shop:PetBtnOnClick()
  if self._isShowPetSpeek then
    return
  end
  self._petSpeek:SetActive(false)
  self._petSpeek:SetActive(true)
  self._isShowPetSpeek = true
  local index = math.random(1, 5)
  local str = StringTable.Get("str_n26_shop_pet_des" .. index)
  self._petSpeekLabel:SetText(str)
  self._showTimer = 0
end
