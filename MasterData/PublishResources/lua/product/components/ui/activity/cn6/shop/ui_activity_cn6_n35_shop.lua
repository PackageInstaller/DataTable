_class("UIActivityCN6N35Shop", UIController)
UIActivityCN6N35Shop = UIActivityCN6N35Shop

function UIActivityCN6N35Shop:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self._activityConst:LoadData(TT, res)
  local shopComponent, shopComponentInfo = self._activityConst:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP)
  self._shopComponent = shopComponent
  self._shopCmpInfo = shopComponentInfo
end

function UIActivityCN6N35Shop:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N6
end

function UIActivityCN6N35Shop:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_SHARED
  return componentIds
end

function UIActivityCN6N35Shop:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    self:Close()
  end, nil, nil, false)
  self._isShowPetSpeek = false
  self._showTime = 3
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
  self._interactWords = string.split(StringTable.Get("str_cn6&n35_shop_npc_word_1"), "|")
  self._wordStack = Stack:New()
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
  self:InitUI()
  GameGlobal.TaskManager():StartTask(self._PlayIn, self)
end

function UIActivityCN6N35Shop:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
end

function UIActivityCN6N35Shop:OnHide()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
end

function UIActivityCN6N35Shop:Close()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN26ActivityMainRedStatusRefresh)
  GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
end

function UIActivityCN6N35Shop:_SetSpine()
  self._spine = UIWidgetHelper.SetSpineLoad(self, "spine", "33hao_n35_spine_idle")
  UIWidgetHelper.SetSpineAnimation(self._spine, 0, "Story_norm", true)
  self._spine.skeleton.color = Color(1, 1, 1, 0)
end

function UIActivityCN6N35Shop:_PlayIn(TT)
  self:Lock("UIActivityCN6N35Shop_PlayIn")
  self._playin = true
  self._anim:Play("uieff_UIActivityCN6N35Shop_in")
  YIELD(TT, 150)
  self._playin = false
  self:UnLock("UIActivityCN6N35Shop_PlayIn")
end

function UIActivityCN6N35Shop:CloseCoro(TT)
  local lineComponent, lineComponentInfo = self._activityConst:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION)
  local shopComponent, shopComponentInfo = self._activityConst:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP)
  local simpleCloseTime = lineComponentInfo.m_close_time
  local shopCloseTime = shopComponentInfo.m_close_time
  local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
  self.lineClose = false
  self.shopClose = false
  if simpleCloseTime < now then
    self.lineClose = true
  end
  if shopCloseTime < now then
    self.shopClose = true
  end
  if self.shopClose then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
  elseif self.lineClose then
    self:SwitchState(UIStateType.UIActivityCN6N35MainController)
  else
    self:CloseDialog()
  end
end

function UIActivityCN6N35Shop:InitUI()
  self:RefreshGoodList(true)
  self:RefreshItemStatus()
  self:RefreshActivityRemainTime()
  self:PetBtnOnClick()
end

function UIActivityCN6N35Shop:RefreshUI()
  self:RefreshGoodList(false)
  self:RefreshItemStatus()
end

function UIActivityCN6N35Shop:RefreshItemStatus()
  local icon, count = self._shopComponent:GetCostItemIconText()
  self._iconLoader:LoadImage(icon)
  self._countLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, count, "#7E91B6", "#FFFFFF"))
end

function UIActivityCN6N35Shop:RefreshActivityRemainTime()
  local status, seconds = self._activityConst:GetComponentStatus(ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP)
  local timeStr = UIActivityCustomHelper.GetTimeString(seconds)
  local timeTips = StringTable.Get("str_cn6&n35_shop_close_time_tips", timeStr)
  self._timeDownLabel:SetText(timeTips)
end

function UIActivityCN6N35Shop:RefreshGoodList(playAnim)
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
  self._bigLoader:SpawnObjects("UIActivityCN6N35ShopItem", #bigList)
  local items = self._bigLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:Refresh(bigList[i], self._shopComponent, function(itemInfo)
      self:StartTask(self.ExchangeItem, self, itemInfo)
    end)
  end
  self._smallLoader:SpawnObjects("UIActivityCN6N35ShopItem", #smallList)
  local items = self._smallLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:Refresh(smallList[i], self._shopComponent, function(itemInfo)
      self:StartTask(self.ExchangeItem, self, itemInfo)
    end)
  end
end

function UIActivityCN6N35Shop:CreateItemAnim(TT, bigList, smallList, shopCom)
  self:Lock("UIActivityN20Shop_CreateItemAnim")
  self._bigLoader:SpawnObjects("UIActivityCN6N35ShopItem", #bigList)
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
  self._smallLoader:SpawnObjects("UIActivityCN6N35ShopItem", #smallList)
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

function UIActivityCN6N35Shop:ExchangeItem(TT, itemInfo)
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

function UIActivityCN6N35Shop:IconInfoOnClick()
  self:StartTask(self.PlayIconInfoOutAnim, self)
end

function UIActivityCN6N35Shop:PlayIconInfoOutAnim(TT)
  self:Lock("UIActivityCN6N35Shop_PlayIconInfoOutAnim")
  YIELD(TT, 500)
  self._iconInfo:SetActive(false)
  self:UnLock("UIActivityCN6N35Shop_PlayIconInfoOutAnim")
end

function UIActivityCN6N35Shop:CountBGOnClick()
  self._iconInfo:SetActive(true)
end

function UIActivityCN6N35Shop:PetBtnOnClick()
  self._petSpeek:SetActive(false)
  self._petSpeek:SetActive(true)
  self._isShowPetSpeek = true
  self._petSpeekAnim:Play("uieff_UIActivityCN6N35Shop_PetSpeek_in")
  local word = self:_GetInteractWord()
  self._petSpeekLabel:SetText(word)
end

function UIActivityCN6N35Shop:_GetInteractWord()
  if self._wordStack:Size() <= 0 then
    local count = 0
    local all = #self._interactWords
    local tmpIndexs = {}
    for i = 1, all do
      table.insert(tmpIndexs, i)
    end
    for j = #tmpIndexs, 1, -1 do
      local index = math.random(1, #tmpIndexs)
      tmpIndexs[j], tmpIndexs[index] = tmpIndexs[index], tmpIndexs[j]
    end
    for _, value in ipairs(tmpIndexs) do
      self._wordStack:Push(value)
    end
  end
  return self._interactWords[self._wordStack:Pop()]
end
