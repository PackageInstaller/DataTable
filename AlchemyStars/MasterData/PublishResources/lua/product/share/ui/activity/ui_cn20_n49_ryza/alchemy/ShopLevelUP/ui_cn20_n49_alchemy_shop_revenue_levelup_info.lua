_class("UICN20N49AlchemyShopRevenueLevelUpInfo", UIController)
UICN20N49AlchemyShopRevenueLevelUpInfo = UICN20N49AlchemyShopRevenueLevelUpInfo

function UICN20N49AlchemyShopRevenueLevelUpInfo:LoadDataOnEnter(TT, res)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_N20
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._campaign = UIActivityCampaign:New()
  local componentIds = {
    ECampaignCN20ComponentID.ECN20_ALCHEMY
  }
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, componentIds)
  if res and res:GetSucc() then
    self.personProcessInfo = UICN20N49Helper.GetComponentInfo(self._campaign, "alchemyShop")
    self.personProcess = UICN20N49Helper.GetComponent(self._campaign, "alchemyShop")
  end
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:OnShow(uiParams)
  self._goldItemID = Cfg.cfg_global.AlchemyMoneyItemID.IntValue
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self:InitWidget()
  self:InitUI()
  self:_InitBackBtn()
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:InitWidget()
  self._anim = self:GetGameObject("_anim")
  self.titleText = self:GetGameObject("TitleText")
  self.itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self.closeBtn = self:GetUIComponent("Image", "CloseBtn")
  self.questPool = self:GetUIComponent("UISelectObjectPath", "QuestPool")
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self.goldText = self:GetUIComponent("UILocalizationText", "GoldText")
  self.curLevelText = self:GetUIComponent("UILocalizationText", "TitleLevel")
  self.curNeedText = self:GetUIComponent("UILocalizationText", "NeedText")
  self.sliderImage = self:GetUIComponent("Image", "sliderImage")
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:_InitBackBtn()
  self.backBtns:SetData(function()
    self._timerHandler = GameGlobal.Timer():AddEventTimes(200, TimerTriggerCount.Once, function()
      self:CloseDialog()
    end)
  end, nil, nil, true, nil, false, nil)
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:InitUI()
  self._gold = self.itemModule:GetItemCount(self._goldItemID)
  self.goldText:SetText(tostring(self._gold))
  self.curLevelText:SetText(tostring(self.personProcess:GetCurProgress()))
  self._progressList = self.personProcess:GetProgressList()
  local curProgressLevel = self.personProcess:GetCurProgress(1)
  local needLevelUPGold = self.personProcess:GetNextLevelNeedProgress()
  if needLevelUPGold <= 0 then
    self.curNeedText:SetText("")
  else
    self.curNeedText:SetText(StringTable.Get("str_cn20_n49_shop_progress_cur_need_gold", needLevelUPGold))
  end
  self.sliderImage.fillAmount = self.personProcess:GetCurLevelProgressRate()
  local progress = self.personProcess:GetProgressList()
  self._dynamicListInfo = progress
  self.personProcess:SortProgressListByCampaignPersonProgressStatus(self._dynamicListInfo)
  self._dynamicListSize = table.count(self._dynamicListInfo)
  self._itemCountPerRow = 1
  self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._taskList = self:GetUIComponent("UIDynamicScrollView", "taskList")
    self._taskList:InitListView(self._dynamicListRowSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListRowSize, self._taskList, nil)
  end
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:_RefreshList(count, list, resetPos)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  if not resetPos then
    list.ScrollRect.content.localPosition = contentPos
  end
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UICN20N49AlchemyShopRevenueLevelUpInfoItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._dynamicListSize then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:_SetListItemData(listItem, index)
  local progress = self._dynamicListInfo[index]
  local level = self.personProcess:GetProgressLevel(progress)
  listItem:SetData(self._campaign, index, progress, function(v)
    self:ListItemOnClick(v)
  end, function(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "ItemTips", matid, pos)
  end, level)
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:ListItemOnClick(progress)
  if self.personProcess:ComponentIsClose() then
    local tips = StringTable.Get("str_activity_error_107")
    ToastManager.ShowToast(tips)
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self.personProcess:Start_HandleReceiveReward(progress, function(res, rewards)
    self:_OnReceiveRewards(res, rewards)
  end)
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
    self:_Refresh()
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_Refresh()
    end, function()
      self:CloseDialog()
    end)
  end
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:_Refresh()
  self:InitUI()
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:BgOnClick(go)
  self:CloseDialog()
end

function UICN20N49AlchemyShopRevenueLevelUpInfo:CloseBtnOnClick(go)
  self:CloseDialog()
end
