require("ui_side_enter_center_content_base")
_class("UIFavourPetVote3", UISideEnterCenterContentBase)
UIFavourPetVote3 = UIFavourPetVote3

function UIFavourPetVote3:DoInit(params)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_VOTE
  self._componentId = ECampaignVoteComponentID.ECAMPAIGN_VOTE
  self._campaignId = params and params.campaign_id
  self._campaign = self._data
  self._component = self._campaign:GetComponent(self._componentId)
  self:_ForceRefresh()
end

function UIFavourPetVote3:DoShow()
  if self._campaign:CheckCampaignClose_ShowClientError() then
    return
  end
  self:InitUIComponents()
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self:_SetReqTime()
  local closeTime = self._campaign:GetSample().end_time
  self:_SetRemainingTime("_time", "str_favour_pet_remain_time", closeTime)
  local tb = self._component:GetAllVoteItemId()
  table.shuffle(tb)
  self._listData_All = tb
  self:InitSexGroup()
  self:_SetTabBtns()
  self:_SetTabSelect(1)
  self:_AttachEvent()
end

function UIFavourPetVote3:InitUIComponents()
  self._unPetGo = self:GetGameObject("UnPet")
  self._unPetGo:SetActive(false)
  self._femaleToggle = self:GetUIComponent("Toggle", "FemaleToggle")
  self._maleToggle = self:GetUIComponent("Toggle", "MaleToggle")
end

function UIFavourPetVote3:DoHide()
  UIWidgetHelper.ClearWidgets(self, "_tipsPool")
  self:_DetachEvent()
end

function UIFavourPetVote3:DoDestroy()
end

function UIFavourPetVote3:_ForceRefresh()
  if self._refreshTaskID ~= nil then
    return
  end
  self._refreshTaskID = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    if res and res:GetSucc() then
      self:_Refresh(true)
    end
    self._refreshTaskID = nil
  end, self)
end

function UIFavourPetVote3:_Refresh(playAnim)
  if not self.view then
    return
  end
  self._champion = self._component:CalcZonePetVoteChampion()
  self:_SetCoin()
  self:_SetRedPoint()
  self:_SetListData()
  self:_SetDynamicList(playAnim)
  self:_DynamicListPlayAnimation(playAnim)
end

function UIFavourPetVote3:_SetCoin()
  local obj = UIWidgetHelper.SpawnObject(self, "_coin", "UIFavourPetCoin")
  obj:SetData(self._component, self._tipsCallback)
end

function UIFavourPetVote3:_SetRedPoint()
  local id1 = UIFavourPetHelper.ComponentId_Quest(1)
  local id2 = UIFavourPetHelper.ComponentId_Quest(2)
  local isShow = self._campaign:CheckComponentRed(id1, id2)
  self:GetGameObject("_questRed"):SetActive(isShow)
end

function UIFavourPetVote3:_SetRemainingTime(widgetName, descId, endTime, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, stopCallback)
end

function UIFavourPetVote3:_SetTabBtns()
  self._tabBtnIds = UIFavourPetHelper.GetFilterType()
  self._tabBtns = UIWidgetHelper.SpawnObjects(self, "_tabBtns", "UIActivityCommonTextTabBtn", #self._tabBtnIds)
  for i, v in ipairs(self._tabBtns) do
    local title = UIFavourPetHelper.GetFilterTitle(self._tabBtnIds[i])
    v:SetData(i, {
      indexWidgets = {},
      onoffWidgets = {
        {"OnBtn"},
        {"OffBtn"}
      },
      lockWidgets = {
        {},
        {}
      },
      titleWidgets = {"txtTitle"},
      titleText = title,
      callback = function(index, isOffBtnClick)
        if isOffBtnClick then
          self:_SetTabSelect(index)
        end
      end,
      lockCallback = nil
    })
  end
end

function UIFavourPetVote3:_SetTabSelect(index)
  self._tabIndex = index
  for i, v in ipairs(self._tabBtns) do
    v:SetSelected(i == index)
  end
  self:_Refresh(true)
end

function UIFavourPetVote3:_SetListData()
  local tb = table.collect(self._listData_All)
  local filterType = self._tabBtnIds[self._tabIndex]
  local filterPet = UIFavourPetHelper.GetFilterPet(tb, filterType)
  local sexfilterPet = UIFavourPetHelper.GetSexFilterPet(filterPet, self._sexIndex)
  if table.count(sexfilterPet) == 0 then
    self._unPetGo:SetActive(true)
  else
    self._unPetGo:SetActive(false)
  end
  self._listData = sexfilterPet
end

function UIFavourPetVote3:_SetDynamicList(resetPos)
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "_dynamicList"), "UIFavourPetVote3Item", function(listItem, itemIndex)
      local petId = self._listData[itemIndex]
      local isChampion = self._champion == petId
      listItem:SetData(self._campaign, self._component, petId, isChampion, function(itemId)
        self:_VoteBtnOnClick(itemId)
      end)
    end)
  end
  local itemCount = #self._listData
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
  if resetPos then
    self._dynamicListHelper:MovePanelToItemIndex(0, 0)
  end
end

function UIFavourPetVote3:_DynamicListPlayAnimation(isPlay)
  if not isPlay then
    return
  end
  local tb = self._dynamicListHelper:GetVisibleItem()
  for _, v in ipairs(tb) do
    v.item:PlayAnimationInSequence(v.index)
  end
end

function UIFavourPetVote3:_SetReqTime()
  if not self.view then
    return
  end
  local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  local reqTime = curTime + 180
  self:_SetRemainingTime("_reqTime", nil, reqTime, function()
    self._component:Start_HandleGetZoneInfo(function()
      self:_Refresh()
    end)
    self:_SetReqTime()
  end)
end

function UIFavourPetVote3:_VoteBtnOnClick(petId)
  local costItemId = self._component:GetVoteCostItemId()
  local costCount = self._component:GetVoteItemCostCount(petId)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local count = itemModule:GetItemCount(costItemId)
  if costCount <= count then
    self._component:Start_HandleVote(petId, 1, function(res, ret)
      if res:GetSucc() then
        local petName = UIFavourPetHelper.GetPetName(petId)
        local text = StringTable.Get("str_favour_pet_vote_succ_msg", petName)
        ToastManager.ShowToast(text)
        self:_Refresh()
      else
        self._campaign:CheckErrorCode(res.m_result, function()
          self:_Refresh()
        end, function()
          self:SwitchState(UIStateType.UIMain)
        end)
      end
    end)
  else
    local text = StringTable.Get("str_favour_pet_vote_not_enough_msg")
    ToastManager.ShowToast(text)
  end
end

function UIFavourPetVote3:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIFavourPetIntro")
end

function UIFavourPetVote3:QuestBtnOnClick(go)
  self:ShowDialog("UIFavourPetQuestController")
end

function UIFavourPetVote3:FemaleToggleOnClick(go)
  self._sexIndex = 1
  self:_Refresh()
end

function UIFavourPetVote3:MaleToggleOnClick(go)
  self._sexIndex = 2
  self:_Refresh()
end

function UIFavourPetVote3:InitSexGroup()
  self._sexIndex = 1
  self._femaleToggle.isOn = true
  self._maleToggle.isOn = false
end

function UIFavourPetVote3:_AttachEvent()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIFavourPetVote3:_DetachEvent()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIFavourPetVote3:OnUIGetItemCloseInQuest()
  self:_Refresh()
end
