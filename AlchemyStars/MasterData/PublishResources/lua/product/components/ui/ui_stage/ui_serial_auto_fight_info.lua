_class("UISerialAutoFightInfo", UIController)
UISerialAutoFightInfo = UISerialAutoFightInfo
OpenUISerialFightInfoState = {
  InGame = 1,
  OutGame = 2,
  Finished = 3
}

function UISerialAutoFightInfo:ShowOverview()
  self._detail:SetActive(false)
  self._overview:SetActive(true)
  if not self._overviewInited then
    self._overviewInited = true
    self._overviewItemPool = self:GetUIComponent("UISelectObjectPath", "OverviewItems")
    self._overviewEmpty = self:GetGameObject("overview_empty")
    local overviewTitle = self:GetUIComponent("UILocalizationText", "overview_title")
    if self._finished then
      overviewTitle:SetText(StringTable.Get("str_battle_auto_fight_total_award"))
    else
      overviewTitle:SetText(StringTable.Get("str_battle_auto_fight_got_now"))
    end
  end
  local md = GameGlobal.GetModule(SerialAutoFightModule)
  local rewards = md:GetTotalRewards()
  local items = self._overviewItemPool:SpawnObjects("UIItem", #rewards)
  for i, asset in ipairs(rewards) do
    local item = items[i]
    self:SetItemData(item, asset)
  end
  self._overviewEmpty:SetActive(#rewards == 0)
end

function UISerialAutoFightInfo:ShowDetail()
  self._overview:SetActive(false)
  self._detail:SetActive(true)
  local md = GameGlobal.GetModule(SerialAutoFightModule)
  local fightCnt = md:GetFightCount() + 1
  local totalCnt = md:GetTotalCount()
  if fightCnt > totalCnt then
    fightCnt = totalCnt
  end
  local rewardList = {}
  local normalRewardList = md:GetRewardList()
  local activityRewardList = md:GetActivityRewardList()
  self._matchResult = md:GetResult()
  for i = 1, fightCnt do
    local awards = {}
    local activity = activityRewardList[i]
    local normal = normalRewardList[i]
    if activity then
      table.appendArray(awards, activity)
    end
    if normal then
      table.appendArray(awards, normal)
    end
    rewardList[i] = awards
  end
  self._detailAwards = rewardList
  if not self._detailInited then
    self._detailInited = true
    self._detailSv = self:GetUIComponent("UIDynamicScrollView", "DetailScrollView")
    self._detailScrollRect = self:GetUIComponent("ScrollRect", "DetailScrollView")
    self._detailSv:InitListView(fightCnt, function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
    self._detailItemPool = self:GetUIComponent("UISelectObjectPath", "total_awards")
    self._detailEmpty = self:GetGameObject("detail_empty")
    local totalTitle = self:GetUIComponent("UILocalizationText", "total_title")
    if self._finished then
      totalTitle:SetText(StringTable.Get("str_battle_auto_fight_total_award"))
    else
      totalTitle:SetText(StringTable.Get("str_battle_auto_fight_got_now"))
    end
  else
    self._detailSv:SetListItemCount(fightCnt, true)
    self._detailSv:RefreshAllShownItem()
  end
  local rewards = md:GetTotalRewards()
  local items = self._detailItemPool:SpawnObjects("UIItem", #rewards)
  for i, asset in ipairs(rewards) do
    local item = items[i]
    self:SetItemData(item, asset)
  end
  self._detailEmpty:SetActive(#rewards == 0)
end

function UISerialAutoFightInfo:OnShow(uiParams)
  self._overview = self:GetGameObject("Overview")
  self._detail = self:GetGameObject("Detail")
  local md = GameGlobal.GetModule(SerialAutoFightModule)
  self._txtTime = self:GetUIComponent("UILocalizationText", "time")
  self._finished = false
  local st = uiParams[1]
  if st == OpenUISerialFightInfoState.Finished then
    self._finished = true
    self:GetGameObject("ConfirmBtn"):SetActive(true)
    self:GetGameObject("ReturnBtn"):SetActive(true)
    self:GetGameObject("ContinueBtn"):SetActive(true)
    self:GetGameObject("FinishWithTimeBtn"):SetActive(false)
    self:GetGameObject("FinishBtn"):SetActive(false)
    self:GetGameObject("CloseBtn"):SetActive(false)
  elseif st == OpenUISerialFightInfoState.InGame then
    self:GetGameObject("ConfirmBtn"):SetActive(false)
    self:GetGameObject("ReturnBtn"):SetActive(false)
    self:GetGameObject("ContinueBtn"):SetActive(false)
    self:GetGameObject("FinishWithTimeBtn"):SetActive(false)
    self:GetGameObject("FinishBtn"):SetActive(true)
    self:GetGameObject("CloseBtn"):SetActive(true)
  elseif st == OpenUISerialFightInfoState.OutGame then
    self:GetGameObject("ConfirmBtn"):SetActive(false)
    self:GetGameObject("ReturnBtn"):SetActive(false)
    self:GetGameObject("ContinueBtn"):SetActive(false)
    self:GetGameObject("FinishWithTimeBtn"):SetActive(true)
    self:OnSerialAutoFightWaitTime(md:GetWaitTime())
    self:GetGameObject("FinishBtn"):SetActive(false)
    self:GetGameObject("CloseBtn"):SetActive(true)
  end
  self._matchType = md:GetMatchType()
  self:GetGameObject("_towerDesc"):SetActive(self._matchType == MatchType.MT_Tower)
  self:GetGameObject("title_finish"):SetActive(self._finished)
  self:GetGameObject("title_fighting"):SetActive(not self._finished)
  if st == OpenUISerialFightInfoState.InGame then
    self._fightingNumber = md:GetFightCount() + 1
  end
  self._doubleList = {}
  for i = 1, md:GetTotalCount() do
    self._doubleList[i] = md:GetTicketCountByIndex(i)
  end
  self:AttachEvent(GameEventType.SerialAutoFightWaitTime, self.OnSerialAutoFightWaitTime)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self:ShowOverview()
  self:ChkAutoPick()
  if self._finished then
    local activityRewardList = md:GetMergedActivityRewards()
    if 0 < #activityRewardList then
      local itemId = activityRewardList[1].assetid
      local tipsText = ""
      if itemId then
        local tipsCfg = Cfg.cfg_activity_drop_item_get_tips_client[itemId]
        if tipsCfg then
          local tipsId = tipsCfg.GetItemTips
          if tipsId and tipsId ~= "" then
            tipsText = StringTable.Get(tipsId)
          end
        end
      end
      local titleText = StringTable.Get("str_sakura_get_activity_item")
      self:ShowDialog("UIGetItemController", activityRewardList, function()
        self:ShowGetRewards()
      end, nil, tipsText, titleText)
    else
      self:ShowGetRewards()
    end
  end
end

function UISerialAutoFightInfo:ShowGetRewards()
  local md = GameGlobal.GetModule(SerialAutoFightModule)
  local returnRewardList = md:GetMergedReturnHelpRewards()
  if 0 < #returnRewardList then
    local itemId = returnRewardList[1].assetid
    local tipsText = ""
    local tipsId = ""
    if itemId then
      local tipsCfg = Cfg.cfg_activity_drop_item_get_tips_client[itemId]
      if tipsCfg then
        local tipsId = tipsCfg.GetItemTips
        if tipsId and tipsId ~= "" then
          tipsText = StringTable.Get(tipsId)
        end
      end
    end
    local titleText = StringTable.Get("str_return_system_btn_assistance")
    self:ShowDialog("UIGetItemController", returnRewardList, nil, nil, nil, titleText)
  end
end

function UISerialAutoFightInfo:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local row = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", row.gameObject)
  if row.IsInitHandlerCalled == false then
    row.IsInitHandlerCalled = true
  end
  local item = rowPool:SpawnObject("UIAutoFightAwardsItem")
  index = index + 1
  item:SetData(self._matchType, index, self._doubleList[index], self._detailAwards[index], self._fightingNumber, self:_GetListItemTitle(index), self._matchResult[index], function(id, pos)
    self:ShowTips(id, pos)
  end)
  item:ParentParentSr(self._detailScrollRect)
  return row
end

function UISerialAutoFightInfo:_GetListItemTitle(index)
  local str = ""
  if self._matchType == MatchType.MT_Tower then
    local md = GameGlobal.GetModule(SerialAutoFightModule)
    local towerModule = self:GetModule(TowerModule)
    local id = md:GetAutoFightDatas_Tower()
    local name, stage = towerModule:GetTowerNameByID(id)
    str = StringTable.Get("str_battle_auto_fight_tower_name_level", stage + index - 1)
  else
    str = StringTable.Get("str_battle_auto_fight_number", index)
  end
  return str
end

function UISerialAutoFightInfo:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UISerialAutoFightInfo:OnSerialAutoFightWaitTime(waitTime)
  self._txtTime:SetText(StringTable.Get("str_common_ss", waitTime))
end

function UISerialAutoFightInfo:finish()
  local md = GameGlobal.GetModule(SerialAutoFightModule)
  md:CancelSerialAutoFight()
  self:CloseDialog()
  ToastManager.ShowToast(StringTable.Get("str_battle_serial_fight_finished"))
end

function UISerialAutoFightInfo:ConfirmBtnOnClick()
  self:finish()
end

function UISerialAutoFightInfo:FinishWithTimeBtnOnClick()
  self:finish()
end

function UISerialAutoFightInfo:FinishBtnOnClick()
  self:finish()
end

function UISerialAutoFightInfo:CloseBtnOnClick()
  self:CloseDialog()
end

function UISerialAutoFightInfo:ShowDetailBtnOnClick()
  self:ShowDetail()
end

function UISerialAutoFightInfo:ShowOverviewBtnOnClick()
  self:ShowOverview()
end

function UISerialAutoFightInfo:SetItemData(item, asset)
  local award = Award:New()
  award:InitWithCount(asset.assetid, asset.count)
  item:SetForm(UIItemForm.Base, UIItemScale.Level3)
  local activityText = ""
  if asset.type == StageAwardType.Activity then
    award.type = asset.type
    activityText = StringTable.Get("str_item_xianshi")
  end
  item:SetData({
    icon = award.icon,
    text1 = award.count,
    quality = award.color,
    itemId = award.id,
    activityText = activityText
  })
  item:SetClickCallBack(function(go)
    self:ShowTips(award.id, go.transform.position)
  end)
end

function UISerialAutoFightInfo:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UISerialAutoFightInfo:ChkAutoPick()
  self._uiAutoPick = self:GetUIComponent("RectTransform", "uiAutoPick")
  self._uiovContent = self:GetUIComponent("RectTransform", "ovContent")
  self._uiTotal = self:GetUIComponent("RectTransform", "total")
  self._uiDetailScrollView = self:GetUIComponent("RectTransform", "DetailScrollView")
  local aps = GameGlobal.GetModule(SerialAutoFightModule):GetApsData()
  local isEnable = aps:IsEnable(false)
  if not isEnable then
    self._uiovContent.anchoredPosition = Vector2(6.5, 0)
    self._uiTotal.anchoredPosition = Vector2(0, 160)
    self._uiDetailScrollView.anchoredPosition = Vector2(0, -139.5)
    self._uiDetailScrollView.sizeDelta = Vector2(1920, 444)
  else
    self._uiovContent.anchoredPosition = Vector2(6.5, -100)
    self._uiTotal.anchoredPosition = Vector2(0, 60)
    self._uiDetailScrollView.anchoredPosition = Vector2(0, -189.5)
    self._uiDetailScrollView.sizeDelta = Vector2(1920, 344)
  end
  if not isEnable then
    self._uiAutoPick.gameObject:SetActive(false)
  else
    self._uiNotEnough = self:GetUIComponent("RectTransform", "uiNotEnough")
    self._uiNotEnough.gameObject:SetActive(not aps:IsPowerEnough())
    self._uiAutoPickItem = self:GetUIComponent("UISelectObjectPath", "uiAutoPickItem")
    self._widgetAutoPickItem = self._uiAutoPickItem:SpawnObject("UISerialAutoPickStuff")
    self._widgetAutoPickItem:SetTips("itemTips")
    local left = self:GetChildComponent(self._uiNotEnough, "RectTransform", "LeftSeparator")
    local txt = self:GetChildComponent(self._uiNotEnough, "UILocalizationText", "txtNotEnough")
    local right = self:GetChildComponent(self._uiNotEnough, "RectTransform", "RightSeparator")
    local space = 15
    local total = 394
    local txtPreferredWidth = txt.preferredWidth
    local width = (total - txtPreferredWidth) * 0.5 - space
    if 0 < width then
      left.sizeDelta = Vector2(width, 2)
      right.sizeDelta = Vector2(width, 2)
    else
      left.gameObject:SetActive(false)
      right.gameObject:SetActive(false)
    end
  end
end

function UISerialAutoFightInfo:ReturnBtnOnClick(go)
  local aps = GameGlobal.GetModule(SerialAutoFightModule):GetApsData()
  if aps:IsEnable(false) then
    self:finish()
    aps:ReturnSpirit()
  end
end

function UISerialAutoFightInfo:ContinueBtnOnClick(go)
  local aps = GameGlobal.GetModule(SerialAutoFightModule):GetApsData()
  if aps:IsEnable(false) then
    local md = GameGlobal.GetModule(SerialAutoFightModule)
    md:CancelSerialAutoFight()
    self:CloseDialog()
    aps:ContinueBattle()
  end
end
