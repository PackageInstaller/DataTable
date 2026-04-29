_class("UIActivityN8PersonProgressController", UIController)
UIActivityN8PersonProgressController = UIActivityN8PersonProgressController

function UIActivityN8PersonProgressController:InitWidget()
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end)
  self._claimAllBtn = self:GetUIComponent("Button", "claimAllBtn")
end

function UIActivityN8PersonProgressController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N8, ECampaignN8ComponentID.ECAMPAIGN_N8_CUMULATIVE_LOGIN, ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION, ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION_FIXTEAM, ECampaignN8ComponentID.ECAMPAIGN_N8_PERSON_PROGRESS, ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR)
  local componentId = ECampaignN8ComponentID.ECAMPAIGN_N8_PERSON_PROGRESS
  if not self._campaign:CheckComponentOpen(componentId) then
    res.m_result = self._campaign:CheckComponentOpenClientError(componentId) or res.m_result
    self._campaign:ShowErrorToast(res.m_result, true)
    return
  end
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
  end
end

function UIActivityN8PersonProgressController:OnShow(uiParams)
  self._isOpen = true
  self:_AttachEvents()
  self:InitWidget()
  self:_Refresh()
end

function UIActivityN8PersonProgressController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityN8PersonProgressController:Destroy()
  if self._EMIMatResRequest then
    self._EMIMat = nil
    self._EMIMatResRequest:Dispose()
    self._EMIMatResRequest = nil
  end
end

function UIActivityN8PersonProgressController:_Refresh()
  self:_SetClaimAllBtn()
  self:_SetIconText()
  self:_SetDynamicList(true)
end

function UIActivityN8PersonProgressController:_SetClaimAllBtn()
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  self._claimAllBtn.interactable = component:HasCanGetReward()
  self:_SetLocalizedTMPMaterial("titleText", "N8Material_02.mat")
end

function UIActivityN8PersonProgressController:_SetLocalizedTMPMaterial(widgetName, matName)
  self._localizedTMP = self:GetUIComponent("UILocalizedTMP", widgetName)
  self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset(matName, LoadType.Mat)
  self._EMIMat = self._EMIMatResRequest.Obj
  local mat = self._localizedTMP.fontMaterial
  self._localizedTMP.fontMaterial = self._EMIMat
  self._localizedTMP.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIActivityN8PersonProgressController:_SetIconText()
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  local icon = self:GetUIComponent("RawImageLoader", "icon")
  icon:LoadImage(component:GetItemIcon())
  local txt = self:GetUIComponent("UILocalizationText", "txtNum")
  txt:SetText(component:GetCurrentProgress())
end

function UIActivityN8PersonProgressController:_SetDynamicListData()
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  local progress = component:GetProgressList()
  self._dynamicListInfo = progress
  component:SortProgressListByCampaignPersonProgressStatus(self._dynamicListInfo)
  self._dynamicListSize = table.count(self._dynamicListInfo)
  self._itemCountPerRow = 1
  self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
end

function UIActivityN8PersonProgressController:_SetDynamicList(resetPos, noAnim)
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
    self._dynamicList:InitListView(self._dynamicListRowSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListRowSize, self._dynamicList, resetPos)
  end
end

function UIActivityN8PersonProgressController:_RefreshList(count, list, resetPos)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  if not resetPos then
    list.ScrollRect.content.localPosition = contentPos
  end
end

function UIActivityN8PersonProgressController:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityN8PersonProgressListItem", self._itemCountPerRow)
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

function UIActivityN8PersonProgressController:_SetListItemData(listItem, index)
  local progress = self._dynamicListInfo[index]
  listItem:SetData(self._campaign, progress, function(v)
    self:ListItemOnClick(v)
  end, function(matid, pos)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityQuestAwardItemClick, matid, pos)
  end)
end

function UIActivityN8PersonProgressController:ListItemOnClick(progress)
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  component:Start_HandleReceiveReward(progress, function(res, rewards)
    self:_OnReceiveRewards(res, rewards)
  end)
end

function UIActivityN8PersonProgressController:ClaimAllBtnOnClick()
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  if self._claimAllBtn.interactable then
    component:Start_HandleOneKeyReceiveRewards(function(res, rewards)
      self:_OnReceiveRewards(res, rewards)
    end)
  end
end

function UIActivityN8PersonProgressController:_OnReceiveRewards(res, rewards)
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

function UIActivityN8PersonProgressController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
end

function UIActivityN8PersonProgressController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIActivityN8PersonProgressController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN8PersonProgressController:_OnActivityQuestAwardItemClick(matid, pos)
  UIWidgetHelper.SetAwardItemTips(self, "itemInfoPool", matid, pos)
end
