_class("UICN13PuzzlePlanPopUp", UIController)
UICN13PuzzlePlanPopUp = UICN13PuzzlePlanPopUp

function UICN13PuzzlePlanPopUp:LoadDataOnEnter(TT, res)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  if res and res:GetSucc() then
    self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE)
    self.personProcess = self._localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
    self.personProcessInfo = self._localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  end
end

function UICN13PuzzlePlanPopUp:OnShow(uiParams)
  self:InitWidget()
  self:InitUI()
end

function UICN13PuzzlePlanPopUp:InitWidget()
  self._anim = self:GetGameObject("_anim")
  self.titleText = self:GetGameObject("TitleText")
  self.itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self.closeBtn = self:GetUIComponent("Image", "CloseBtn")
  self.questPool = self:GetUIComponent("UISelectObjectPath", "QuestPool")
end

function UICN13PuzzlePlanPopUp:InitUI()
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

function UICN13PuzzlePlanPopUp:_RefreshList(count, list, resetPos)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  if not resetPos then
    list.ScrollRect.content.localPosition = contentPos
  end
end

function UICN13PuzzlePlanPopUp:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UICN13PerfectPuzzlePlanItem", self._itemCountPerRow)
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

function UICN13PuzzlePlanPopUp:_SetListItemData(listItem, index)
  local progress = self._dynamicListInfo[index]
  listItem:SetData(self._campaign, index, progress, function(v)
    self:ListItemOnClick(v)
  end, function(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "ItemTips", matid, pos)
  end)
end

function UICN13PuzzlePlanPopUp:ListItemOnClick(progress)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    self:CloseDialog()
    return
  end
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  component:Start_HandleReceiveReward(progress, function(res, rewards)
    self:_OnReceiveRewards(res, rewards)
  end)
end

function UICN13PuzzlePlanPopUp:_OnReceiveRewards(res, rewards)
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

function UICN13PuzzlePlanPopUp:_Refresh()
  self:InitUI()
end

function UICN13PuzzlePlanPopUp:BgOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
  end
  self:CloseDialog()
end

function UICN13PuzzlePlanPopUp:CloseBtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
  end
  self:CloseDialog()
end
