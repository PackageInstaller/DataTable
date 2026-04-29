_class("UIActivityBattlePassMainTabReward", UICustomWidget)
UIActivityBattlePassMainTabReward = UIActivityBattlePassMainTabReward

function UIActivityBattlePassMainTabReward:_GetLVRewardComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassMainTabReward:_GetLVRewardComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassMainTabReward:_GetBuyGiftComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponent(cmptId)
end

function UIActivityBattlePassMainTabReward:_GetBuyGiftComponentInfo()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityBattlePassMainTabReward:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self._callback then
      self._callback()
    end
  end, function()
    self:ShowDialog("UIHelpController", "UIActivityBattlePassMainController")
  end)
  self._anim = self:GetUIComponent("Animation", "root")
  self._red = self:GetGameObject("red")
  self._claimAllBtn = self:GetUIComponent("Button", "claimAllBtn")
end

function UIActivityBattlePassMainTabReward:SetData(campaign, callback)
  self._campaign = campaign
  self._callback = callback
  self:_GetComponents()
  self:_SetCG()
  UIActivityBattlePassHelper.SetSpecialImg(self._campaign, self:GetGameObject("imgRoot"), self:GetUIComponent("RawImageLoader", "img"), self:GetName())
  self:_SetRemainingTime()
  self:_Refresh()
  self:_OnScrollMove()
end

function UIActivityBattlePassMainTabReward:OnShow(uiParams)
  self._isOpen = true
  self._scrollRect = self:GetUIComponent("ScrollRect", "dynamicList")
  self._scrollRect.onValueChanged:AddListener(function()
    self:_OnScrollMove()
  end)
  if not self._EMIMatResRequest then
    self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("ui_image_gray.mat", LoadType.Mat)
    self._EMIMat = self._EMIMatResRequest.Obj
  end
end

function UIActivityBattlePassMainTabReward:OnHide()
  self._isOpen = false
  if self._EMIMatResRequest then
    self._EMIMat = nil
    self._EMIMatResRequest:Dispose()
    self._EMIMatResRequest = nil
  end
end

function UIActivityBattlePassMainTabReward:_Refresh(upgrade)
  if self._isOpen then
    self:_SetExpInfo(upgrade)
    self:_SetBuyEliteBtn()
    self:_SetBuyLevelBtn()
    self:_SetClaimAllBtn()
    self:_SetLeftReward()
    self:_SetDynamicList()
    self:_RefreshRightReward()
    self:_CheckRedPointAll()
  end
end

function UIActivityBattlePassMainTabReward:_SetCG()
  local component = self:_GetLVRewardComponent()
  local cfg = component:GetSpecialRewardCfg()
  local obj = self:GetGameObject("cg")
  obj:SetActive(false)
  if cfg and cfg.SpecialRewardCg then
    obj:SetActive(true)
    local cfg_cg = Cfg.cfg_cg_book[cfg.SpecialRewardCg]
    local img = self:GetUIComponent("RawImageLoader", "imgCG")
    img:LoadImage(cfg_cg.Preview)
    local txt = self:GetUIComponent("UILocalizationText", "txtCG")
    txt:SetText(StringTable.Get(cfg.SpeicalRewardCgDesc))
  end
end

function UIActivityBattlePassMainTabReward:_SetRemainingTime()
  local componentInfo = self:_GetLVRewardComponentInfo()
  local remainingTimePool = self:GetUIComponent("UISelectObjectPath", "remainingTimePool")
  self._remainingTime = remainingTimePool:SpawnObject("UIActivityCommonRemainingTime")
  local endTime = componentInfo.m_close_time
  self._remainingTime:SetExtraText("txtDesc", "", "str_activity_common_remainingtime_2")
  self._remainingTime:SetData(endTime, nil, nil)
end

function UIActivityBattlePassMainTabReward:_SetExpInfo(upgrade)
  local componentInfo = self:_GetLVRewardComponentInfo()
  local expInfoPool = self:GetUIComponent("UISelectObjectPath", "expInfoPool")
  self._expInfo = expInfoPool:SpawnObject("UIActivityBattlePassExpInfo")
  self._expInfo:SetData(componentInfo, upgrade)
end

function UIActivityBattlePassMainTabReward:_SetLeftReward()
  local component = self:_GetLVRewardComponent()
  local leftItemPool = self:GetUIComponent("UISelectObjectPath", "leftItem")
  self._leftItem = leftItemPool:SpawnObject("UIActivityBattlePassRewardListItem")
  self._leftItem:SetData_Fixed(component)
end

function UIActivityBattlePassMainTabReward:_SetRightReward(index)
  self._rightRewardIndex = index
  local component = self:_GetLVRewardComponent()
  local rightItemPool = self:GetUIComponent("UISelectObjectPath", "rightItem")
  self._rightItem = rightItemPool:SpawnObject("UIActivityBattlePassRewardListItem")
  self._rightItem:SetData(index, component, function(lv, adv)
    self:_Start_HandleReceiveLevelRewardReq(lv, adv)
  end, function(matid, pos)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityQuestAwardItemClick, matid, pos)
  end)
end

function UIActivityBattlePassMainTabReward:_SetBuyEliteBtn()
  local componentInfo = self:_GetBuyGiftComponentInfo()
  local obj = self:GetGameObject("buyEliteBtnObj")
  obj:SetActive(componentInfo.m_buy_state ~= BuyGiftStateType.EBGST_LUXURY)
end

function UIActivityBattlePassMainTabReward:_SetBuyLevelBtn()
  local componentInfo = self:_GetLVRewardComponentInfo()
  local obj = self:GetGameObject("buyLevelBtnObj")
  local flag = componentInfo.m_current_level < componentInfo.m_max_level
  obj:SetActive(flag)
end

function UIActivityBattlePassMainTabReward:_SetClaimAllBtn()
  local bShow = UIActivityBattlePassHelper.CheckComponentRedPoint(self._campaign, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD)
  self._claimAllBtn.interactable = bShow
end

function UIActivityBattlePassMainTabReward:_OnScrollMove()
  local component = self:_GetLVRewardComponent()
  local showTab = self._dynamicList:GetVisibleItemIDsInScrollView()
  Log.debug("UIActivityBattlePassMainTabReward:_OnScrollMove() showTab.Count = ", showTab.Count)
  if showTab.Count == 0 then
    return
  end
  local id = math.floor(showTab[showTab.Count - 1] + 1)
  Log.debug("UIActivityBattlePassMainTabReward:_OnScrollMove() id = ", id)
  local next = component:GetNextPreviewLvFromConfig(id)
  if next then
    self:_SetRightReward(next)
  end
  local obj = self:GetGameObject("rightItem")
  obj:SetActive(next ~= nil)
end

function UIActivityBattlePassMainTabReward:_RefreshRightReward()
  if not self._rightRewardIndex then
    return
  end
  self:_SetRightReward(self._rightRewardIndex)
end

function UIActivityBattlePassMainTabReward:_SetDynamicListData()
  local componentInfo = self:_GetLVRewardComponentInfo()
  self._dynamicListSize = componentInfo.m_max_level
  self._itemCountPerRow = 1
  self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
end

function UIActivityBattlePassMainTabReward:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
    self._dynamicList:InitListView(self._dynamicListRowSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
    self:_SetDynamicListInitPos(self._dynamicList)
  else
    self:_RefreshList(self._dynamicListRowSize, self._dynamicList)
  end
end

function UIActivityBattlePassMainTabReward:_SetDynamicListInitPos(list)
  local component = self:_GetLVRewardComponent()
  local pos = component:GetShowLvOnEnter() - 1
  list:MovePanelToItemIndex(pos, 0)
end

function UIActivityBattlePassMainTabReward:_RefreshList(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIActivityBattlePassMainTabReward:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityBattlePassRewardListItem", self._itemCountPerRow)
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

function UIActivityBattlePassMainTabReward:_SetListItemData(listItem, index)
  local component = self:_GetLVRewardComponent()
  listItem:GetGameObject():SetActive(true)
  listItem:SetData(index, component, function(lv, adv)
    self:_Start_HandleReceiveLevelRewardReq(lv, adv)
  end, function(matid, pos)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityQuestAwardItemClick, matid, pos)
  end, self._EMIMat)
end

function UIActivityBattlePassMainTabReward:_Start_HandleReceiveLevelRewardReq(lv, adv)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIActivityBattlePassMainTabReward:_HandleReceiveLevelRewardReq")
  self:StartTask(self._HandleReceiveLevelRewardReq, self, lv, adv)
end

function UIActivityBattlePassMainTabReward:_HandleReceiveLevelRewardReq(TT, lv, adv)
  local component = self:_GetLVRewardComponent()
  if component then
    local res = AsyncRequestRes:New()
    local rewards = {}
    local reward = component:HandleReceiveLevelReward(TT, res, lv, adv)
    table.insert(rewards, reward)
    self:UnLock("UIActivityBattlePassMainTabReward:_HandleReceiveLevelRewardReq")
    if self.view == nil then
      return
    end
    if res:GetSucc() then
      UIActivityHelper.ShowUIGetRewards(rewards, true)
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
        self:_Refresh()
      end, function()
        self:SwitchState(UIStateType.UIMain)
      end)
    end
  end
end

function UIActivityBattlePassMainTabReward:_Start_HandleOneKeyReceiveRewardReq()
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIActivityBattlePassMainTabReward:_HandleOneKeyReceiveRewardReq")
  self:StartTask(self._HandleOneKeyReceiveRewardReq, self)
end

function UIActivityBattlePassMainTabReward:_HandleOneKeyReceiveRewardReq(TT)
  local component = self:_GetLVRewardComponent()
  if component then
    local res = AsyncRequestRes:New()
    local rewards = component:HandleOneKeyReceiveReward(TT, res)
    self:UnLock("UIActivityBattlePassMainTabReward:_HandleOneKeyReceiveRewardReq")
    if self.view == nil then
      return
    end
    if res:GetSucc() then
      UIActivityHelper.ShowUIGetRewards(rewards, true)
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
        self:_Refresh()
      end, function()
        self:SwitchState(UIStateType.UIMain)
      end)
    end
  end
end

function UIActivityBattlePassMainTabReward:BuyEliteBtnOnClick(go)
  Log.info("UIActivityBattlePassMainTabReward:BuyEliteBtnOnClick")
  self:ShowDialog("UIActivityBattlePassBuyController", function(upgrade)
    self:OnCloseBuyDeluxeDialog(upgrade)
  end)
end

function UIActivityBattlePassMainTabReward:BuyLevelBtnOnClick(go)
  Log.info("UIActivityBattlePassMainTabReward:BuyLevelBtnOnClick")
  self:ShowDialog("UIActivityBattlePassBuyLevelController", function()
    self:_Refresh(true)
  end)
end

function UIActivityBattlePassMainTabReward:PreviewBtnOnClick(go)
  Log.info("UIActivityBattlePassMainTabReward:PreviewBtnOnClick")
  self:ShowDialog("UIActivityBattlePassPreviewController")
end

function UIActivityBattlePassMainTabReward:ClaimAllBtnOnClick(go)
  Log.info("UIActivityBattlePassMainTabReward:ClaimAllBtnOnClick")
  if self._claimAllBtn.interactable then
    self:_Start_HandleOneKeyReceiveRewardReq()
  end
end

function UIActivityBattlePassMainTabReward:AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIActivityBattlePassMainTabReward:RemoveEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIActivityBattlePassMainTabReward:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckRedPointAll()
  end
end

function UIActivityBattlePassMainTabReward:_CheckRedPointAll()
  self:_CheckRedPoint(self._red, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD)
end

function UIActivityBattlePassMainTabReward:_CheckRedPoint(obj, ...)
  local bShow = self._campaign and UIActivityBattlePassHelper.CheckComponentRedPoint(self._campaign, ...)
  obj:SetActive(bShow)
end

function UIActivityBattlePassMainTabReward:OnCloseBuyDeluxeDialog(upgrade)
  self._anim:Play("uieff_UIActivityBattlePassMainTabReward_In")
  self:_Refresh(upgrade)
end
