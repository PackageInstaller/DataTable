_class("UIActivityN31Shop", UIController)
UIActivityN31Shop = UIActivityN31Shop

function UIActivityN31Shop:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self._activityConst:LoadData(TT, res)
  local shopComponent, shopComponentInfo = self._activityConst:GetComponent(ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP)
  self._shopComponent = shopComponent
  self._shopCmpInfo = shopComponentInfo
  local lineComponent, lineComponentInfo = self._activityConst:GetComponent(ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION)
  local simpleCloseTime = lineComponentInfo.m_close_time
  local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
  self.lineClose = false
  if simpleCloseTime < now then
    self.lineClose = true
  end
end

function UIActivityN31Shop:OnShow(uiParams)
  self.line = uiParams[4]
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
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._iconInfoAnim = self:GetUIComponent("Animation", "IconInfo")
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
  self:InitUI()
  self._petSpeekGo = self:GetGameObject("PetSpeek")
  self:_SetSpine()
  self._petSpeekGo:SetActive(false)
  GameGlobal.TaskManager():StartTask(self._PlayIn, self)
end

function UIActivityN31Shop:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
  if self._isShowPetSpeek then
    self._showTimer = self._showTimer + deltaTimeMS / 1000
    if self._showTimer >= self._showTime then
      self._isShowPetSpeek = false
      self._petSpeekAnim:Play("uieff_UIActivityN31Shop_PetSpeek_out")
      self._petSpeekGo:SetActive(false)
    end
  end
end

function UIActivityN31Shop:OnHide()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
end

function UIActivityN31Shop:Close()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN31ActivityMainRedStatusRefresh)
  GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
end

function UIActivityN31Shop:_SetSpine()
  self._spine = UIWidgetHelper.SetSpineLoad(self, "spine", "miyasp1_n31_spine_idle")
  UIWidgetHelper.SetSpineAnimation(self._spine, 0, "Story_norm", true)
end

function UIActivityN31Shop:_PlayIn(TT)
  self:Lock("uieff_UIActivityN31Shop_in")
  self._playin = true
  self._anim:Play("uieff_UIActivityN31Shop_in")
  YIELD(TT, 550)
  self._playin = false
  self:UnLock("uieff_UIActivityN31Shop_in")
end

function UIActivityN31Shop:CloseCoro(TT)
  if self.line and self.lineClose then
    self:SwitchState(UIStateType.UIActivityN31MainController)
    return
  end
  self:Lock("UIActivityN31Shop_CloseCoro")
  self._anim:Play("uieff_UIActivityN31Shop_out")
  YIELD(TT, 200)
  local campModule = GameGlobal.GetModule(CampaignModule)
  local campaign = self._activityConst:GetCampaign()
  if self.line then
    self:CloseDialog()
  else
    campModule:CampaignSwitchState(true, UIStateType.UIActivityN31MainController, UIStateType.UIMain, {nil, false}, campaign._id)
  end
  self:UnLock("UIActivityN31Shop_CloseCoro")
end

function UIActivityN31Shop:InitUI()
  self:RefreshSpecialGood()
  self:RefreshGoodList(true)
  self:RefreshItemStatus()
  self:RefreshActivityRemainTime()
end

function UIActivityN31Shop:RefreshUI(goodID)
  self:RefreshSpecialGood(goodID)
  self:RefreshGoodList(false, goodID)
  self:RefreshItemStatus()
end

function UIActivityN31Shop:RefreshItemStatus()
  local icon, count = self._shopComponent:GetCostItemIconText()
  self._iconLoader:LoadImage(icon)
  if 9999999 < count then
    count = 9999999
  end
  self._countLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, count, "#c9c7c5", "#ffd954"))
end

function UIActivityN31Shop:RefreshActivityRemainTime()
  local status, seconds = self._activityConst:GetComponentStatus(ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP)
  local timeStr = UIActivityCustomHelper.GetTimeString(seconds, "str_n31_day", "str_n31_hour", "str_n31_minus", "str_n31_less_one_minus")
  local timeTips = StringTable.Get("str_n31_shop_close_time_tips", timeStr)
  self._timeDownLabel:SetText(timeTips)
end

function UIActivityN31Shop:RefreshSpecialGood(goodID)
  self._bigItems = {}
  self._smallItems = {}
  local itemList = self._shopCmpInfo.m_exchange_item_list
  for i = 1, #itemList do
    if itemList[i].m_is_special then
      table.insert(self._bigItems, itemList[i])
    else
      table.insert(self._smallItems, itemList[i])
    end
  end
end

function UIActivityN31Shop:RefreshGoodList(playAnim, goodID)
  local itemList = self._shopCmpInfo.m_exchange_item_list
  if playAnim then
    self:StartTask(self._CreateItemAnim, self, itemList, goodID)
  else
    self._bigLoader:SpawnObjects("UIActivityN31ShopItem", #self._bigItems)
    local items = self._bigLoader:GetAllSpawnList()
    local index = 0
    for i = 1, #items do
      index = index + 1
      items[i]:Refresh(itemList[i], self._shopComponent, goodID, function(itemInfo)
        self:StartTask(self.ExchangeItem, self, itemInfo, goodID)
      end)
    end
    self._smallLoader:SpawnObjects("UIActivityN31ShopItem", #self._smallItems)
    local items = self._smallLoader:GetAllSpawnList()
    for i = 1, #items do
      items[i]:Refresh(itemList[i + index], self._shopComponent, goodID, function(itemInfo)
        self:StartTask(self.ExchangeItem, self, itemInfo, goodID)
      end)
    end
  end
end

function UIActivityN31Shop:_CreateItemAnim(TT, itemList, goodID)
  self:Lock("UIActivityN20Shop_CreateItemAnim")
  self._bigLoader:SpawnObjects("UIActivityN31ShopItem", #self._bigItems)
  local items = self._bigLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetVisible(false)
  end
  local index = 0
  for i = 1, #items do
    index = index + 1
    items[i]:Refresh(itemList[i], self._shopComponent, goodID, function(itemInfo)
      self:StartTask(self.ExchangeItem, self, itemInfo, goodID)
    end, true)
    YIELD(TT, 50)
  end
  self._smallLoader:SpawnObjects("UIActivityN31ShopItem", #self._smallItems)
  items = self._smallLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetVisible(false)
  end
  for i = 1, #items do
    items[i]:Refresh(itemList[i + index], self._shopComponent, goodID, function(itemInfo)
      self:StartTask(self.ExchangeItem, self, itemInfo, goodID)
    end, true)
    YIELD(TT, 50)
  end
  self:UnLock("UIActivityN20Shop_CreateItemAnim")
end

function UIActivityN31Shop:ExchangeItem(TT, itemInfo)
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

function UIActivityN31Shop:IconInfoOnClick()
  self:StartTask(self.PlayIconInfoOutAnim, self)
end

function UIActivityN31Shop:PlayIconInfoOutAnim(TT)
  self:Lock("UIActivityN31Shop_PlayIconInfoOutAnim")
  self._iconInfoAnim:Play("uieff_N31_Shop_IconInfo_out")
  YIELD(TT, 500)
  self._iconInfo:SetActive(false)
  self:UnLock("UIActivityN31Shop_PlayIconInfoOutAnim")
end

function UIActivityN31Shop:CountBGOnClick()
  self._iconInfo:SetActive(true)
end

function UIActivityN31Shop:PetBtnOnClick()
  if self._isShowPetSpeek then
    return
  end
  self._petSpeekGo:SetActive(true)
  self._petSpeekAnim:Play("uieff_UIActivityN31Shop_PetSpeek_in")
  self._isShowPetSpeek = true
  local index = math.random(1, 5)
  local str = StringTable.Get("str_n31_shop_pet_des" .. index)
  self._petSpeekLabel:SetText(str)
  self._showTimer = 0
end

function UIActivityN31Shop:SpecialBtnOnClick()
  local itemInfo = self._shopCmpInfo.m_exchange_item_list[1]
  if itemInfo.m_exchange_limit_count ~= -1 and itemInfo.m_can_exchange_count == 0 then
    ToastManager.ShowToast(StringTable.Get("str_n26_item_has_empty_tips"))
    return
  end
  self:StartTask(self.ExchangeItem, self, itemInfo)
end

function UIActivityN31Shop:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N31
end

function UIActivityN31Shop:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP
  return componentIds
end
