_class("UIFavourPetQuestController", UIController)
UIFavourPetQuestController = UIFavourPetQuestController

function UIFavourPetQuestController:_SetCurComponent(index)
  self._cmptId, self._component, self._componentInfo = UIFavourPetHelper.Component_Quest(self._campaign, index)
end

function UIFavourPetQuestController:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_VOTE
  local componentIds = {}
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
end

function UIFavourPetQuestController:OnShow(uiParams)
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self:_SetTabBtns()
  self:_SetTabSelect(1)
  self:_AttachEvents()
end

function UIFavourPetQuestController:OnHide()
  self:_DetachEvents()
end

function UIFavourPetQuestController:Refresh_ByParams(params)
  if not self.view then
    return
  end
  params = params or {}
  self:_SetRedPoint()
  self:_CheckQuestDailyReset()
  self:_SetCoin()
  self:_SetDynamicList()
  if params.resetPos and self._dynamicListHelper then
    self._dynamicListHelper:MovePanelToItemIndex(0, 0)
  end
  if params.anim_ListItem then
    self:_DynamicListPlayAnimation()
  end
end

function UIFavourPetQuestController:_SetCoin()
  local component = self._campaign:GetComponent(ECampaignVoteComponentID.ECAMPAIGN_VOTE)
  local obj = UIWidgetHelper.SpawnObject(self, "_coin", "UIFavourPetCoin")
  obj:SetData(component, self._tipsCallback)
end

function UIFavourPetQuestController:_CheckQuestDailyReset()
  local nextTime = self._component:GetEarliestEndTimeInDailyQuest()
  self:_SetRemainingTime("_time", nextTime, function(first)
    local logStr = "UIFavourPetQuestController:_CheckQuestDailyReset() "
    Log.info(logStr, "Timer stop in ", nextTime)
    if first then
      Log.info(logStr, "Timer stop by first tick")
      return
    end
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      self._component:HandleCamQuestDailyReset(TT, res)
      if res:GetSucc() then
        self._campaign:ReLoadCampaignInfo_Force(TT, res)
      end
      self:Refresh_ByParams({resetPos = true, anim_ListItem = true})
    end, self)
  end)
end

function UIFavourPetQuestController:_SetRemainingTime(widgetName, endTime, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  local isShow = endTime ~= nil or endTime ~= 0
  obj:GetGameObject():SetActive(isShow)
  if not isShow then
    return
  end
  obj:SetAdvanceText("str_favour_pet_quest_time")
  obj:SetCustomTimeStr_Common_2()
  obj:SetData(endTime, nil, stopCallback)
end

function UIFavourPetQuestController:_SetTabBtns()
  local title = {
    "str_favour_pet_quest_tab_btn_1",
    "str_favour_pet_quest_tab_btn_2"
  }
  self._tabBtns = UIWidgetHelper.SpawnObjects(self, "_tabBtns", "UIActivityCommonTextTabBtn", #title)
  for i, v in ipairs(self._tabBtns) do
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
      titleText = StringTable.Get(title[i]),
      callback = function(index, isOffBtnClick)
        if isOffBtnClick then
          self:_SetTabSelect(index)
        end
      end,
      lockCallback = nil
    })
  end
end

function UIFavourPetQuestController:_SetTabSelect(index)
  self._tabIndex = index
  for i, v in ipairs(self._tabBtns) do
    v:SetSelected(i == index)
  end
  self:_SetCurComponent(self._tabIndex)
  self:Refresh_ByParams({resetPos = true, anim_ListItem = true})
end

function UIFavourPetQuestController:_SetRedPoint()
  for i, v in ipairs(self._tabBtns) do
    local id = UIFavourPetHelper.ComponentId_Quest(i)
    local isShow = self._campaign:CheckComponentRed(id)
    v:GetGameObject("red"):SetActive(isShow)
  end
end

function UIFavourPetQuestController:_SetDynamicListData()
  self._dynamicListInfo = self._component:GetQuestInfo()
  self._questStatus = self._component:GetCampaignQuestStatus(self._dynamicListInfo)
  self._component:SortQuestInfoByDaily(self._dynamicListInfo)
  self._component:SortQuestInfoByCampaignQuestStatus(self._dynamicListInfo)
end

function UIFavourPetQuestController:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "_dynamicList"), "UIFavourPetQuestCell", function(listItem, itemIndex)
      self:_SetCellData(listItem, itemIndex)
    end)
  end
  local itemCount = #self._dynamicListInfo
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

function UIFavourPetQuestController:_SetCellData(listItem, index, rightItem)
  local quest = self._dynamicListInfo[index]
  local status = self._questStatus[quest]
  if quest ~= nil then
    listItem:SetData(index, self._campaign, quest, status, function(questInfo)
      self._component:Start_HandleQuestTake(questInfo.quest_id, function(res, rewards)
        self:_OnGetRewards(res, rewards)
      end)
    end, self._tipsCallback)
  end
end

function UIFavourPetQuestController:_DynamicListPlayAnimation()
  local tb = self._dynamicListHelper:GetVisibleItem()
  for _, v in ipairs(tb) do
    v.item:PlayAnimationInSequence(v.index)
  end
end

function UIFavourPetQuestController:_OnGetRewards(res, rewards)
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
    self:Refresh_ByParams({resetPos = true, anim_ListItem = true})
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:Refresh_ByParams({resetPos = true, anim_ListItem = true})
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
end

function UIFavourPetQuestController:CloseBtnOnClick(go)
  self:_CloseWithAnim()
end

function UIFavourPetQuestController:_CloseWithAnim()
  local animName, duration = "uieff_UIFavourPetQuestController_out", 167
  UIWidgetHelper.PlayAnimation(self, "_anim", animName, duration, function()
    self:CloseDialog()
  end)
end

function UIFavourPetQuestController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIFavourPetQuestController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIFavourPetQuestController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:CloseDialog()
  end
end
