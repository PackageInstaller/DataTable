_class("UIActivityN20Shop", UIController)
UIActivityN20Shop = UIActivityN20Shop

function UIActivityN20Shop:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._activityConst = UIActivityN20Const:New()
  self._activityConst:LoadData(TT, res)
  local shopComponent, shopComponentInfo = self._activityConst:GetShopComponent()
  self._shopComponent = shopComponent
  self._shopCmpInfo = shopComponentInfo
end

function UIActivityN20Shop:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    self:Close()
  end, nil, nil, false)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._timeDownLabel = self:GetUIComponent("UILocalizationText", "TimeDown")
  self._smallLoader = self:GetUIComponent("UISelectObjectPath", "SmallList")
  self._bigLoader = self:GetUIComponent("UISelectObjectPath", "Big")
  self._middleLoader = self:GetUIComponent("UISelectObjectPath", "Middle")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
  self:InitUI()
  self:_SetSpine()
  GameGlobal.TaskManager():StartTask(self._PlayIn, self)
end

function UIActivityN20Shop:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
end

function UIActivityN20Shop:OnHide()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
end

function UIActivityN20Shop:Close()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.N20RefreshShopBtnStatus)
  GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
end

function UIActivityN20Shop:_SetSpine()
  self._spine = UIWidgetHelper.SetSpineLoad(self, "spine", "kalianyuhun_n20_spine_idle")
  UIWidgetHelper.SetSpineAnimation(self._spine, 0, "Story_norm", true)
  self._spine.skeleton.color = Color(1, 1, 1, 0)
end

function UIActivityN20Shop:OnUpdate(deltaTimeMS)
  if self._playin and self._spine then
    local obj = self:GetUIComponent("SpineLoader", "spine")
    self._spine.skeleton.color = obj.color
  end
end

function UIActivityN20Shop:_PlayIn(TT)
  self:Lock("UIActivityN20Shop_PlayIn")
  self._playin = true
  self._anim:Play("uieffanim_N20Shop_in")
  YIELD(TT, 500)
  self._playin = false
  self:UnLock("UIActivityN20Shop_PlayIn")
end

function UIActivityN20Shop:CloseCoro(TT)
  self:Lock("UIActivityN20Shop_CloseCoro")
  self._anim:Play("uieffanim_N20Shop_out")
  YIELD(TT, 333)
  self:CloseDialog()
  self:UnLock("UIActivityN20Shop_CloseCoro")
end

function UIActivityN20Shop:InitUI()
  self:RefreshGoodList(true)
  self:RefreshItemStatus()
  self:RefreshActivityRemainTime()
end

function UIActivityN20Shop:RefreshUI()
  self:RefreshGoodList(false)
  self:RefreshItemStatus()
end

function UIActivityN20Shop:RefreshItemStatus()
  local shopCom, _ = self._activityConst:GetShopComponent()
  local icon, count = shopCom:GetCostItemIconText()
  self._iconLoader:LoadImage(icon)
  self._countLabel:SetText(UIActivityN20MainController.GetItemCountStr(count, "#545454", "#4bc5f8"))
end

function UIActivityN20Shop:RefreshActivityRemainTime()
  local endTime = self._activityConst:GetShopCloseTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds < 0 then
    seconds = 0
  end
  local timeStr = self._activityConst:GetTimeString(seconds)
  local timeTips = StringTable.Get("str_n20_shop_close_time_tips", timeStr)
  self._timeDownLabel:SetText(timeTips)
end

function UIActivityN20Shop:RefreshGoodList(playAnim)
  local shopCom, _ = self._activityConst:GetShopComponent()
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
    self:StartTask(self.CreateBigItems, self, bigList, shopCom)
    self:StartTask(self.CreateSmallItems, self, smallList, shopCom)
  else
    self._bigLoader:SpawnObjects("UIActivityN20ShopItem", #bigList)
    local items = self._bigLoader:GetAllSpawnList()
    for i = 1, #items do
      items[i]:Refresh(bigList[i], shopCom, function(itemInfo)
        self:StartTask(self.ExchangeItem, self, itemInfo)
      end)
    end
    self._smallLoader:SpawnObjects("UIActivityN20ShopItem", #smallList)
    local items = self._smallLoader:GetAllSpawnList()
    for i = 1, #items do
      items[i]:Refresh(smallList[i], shopCom, function(itemInfo)
        self:StartTask(self.ExchangeItem, self, itemInfo)
      end)
    end
  end
end

function UIActivityN20Shop:CreateBigItems(TT, bigList, shopCom)
  self:Lock("UIActivityN20Shop_CreateBigItems")
  self._bigLoader:SpawnObjects("UIActivityN20ShopItem", #bigList)
  local items = self._bigLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetVisible(false)
  end
  for i = 1, #items do
    items[i]:Refresh(bigList[i], shopCom, function(itemInfo)
      self:StartTask(self.ExchangeItem, self, itemInfo)
    end)
    YIELD(TT, 100)
  end
  self:UnLock("UIActivityN20Shop_CreateBigItems")
end

function UIActivityN20Shop:CreateSmallItems(TT, smallList, shopCom)
  self:Lock("UIActivityN20Shop_CreateSmallItems")
  self._smallLoader:SpawnObjects("UIActivityN20ShopItem", #smallList)
  local items = self._smallLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetVisible(false)
  end
  for i = 1, #items do
    items[i]:Refresh(smallList[i], shopCom, function(itemInfo)
      self:StartTask(self.ExchangeItem, self, itemInfo)
    end)
    YIELD(TT, 100)
  end
  self:UnLock("UIActivityN20Shop_CreateSmallItems")
end

function UIActivityN20Shop:ExchangeItem(TT, itemInfo)
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
