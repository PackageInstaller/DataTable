_class("UIActivityEveSinsaTaskQuestListItem", UICustomWidget)
UIActivityEveSinsaTaskQuestListItem = UIActivityEveSinsaTaskQuestListItem

function UIActivityEveSinsaTaskQuestListItem:_GetComponents()
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._list = self:GetUIComponent("UIDynamicScrollView", "rewardList")
  self._desTex = self:GetUIComponent("UILocalizationText", "desTex")
  self._progressValueImg = self:GetUIComponent("Image", "progressValueImg")
  self._progressValueTex = self:GetUIComponent("UILocalizationText", "progressValueTex")
  self._stateCanGetObj = self:GetGameObject("stateCanGet")
  self._stateCanGetTex = self:GetUIComponent("UILocalizationText", "stateCanGetTex")
  self._stateCanGetTexEn = self:GetUIComponent("UILocalizationText", "stateCanGetTexEn")
  self._stateCanGetTexEnObj = self:GetGameObject("stateCanGetTexEn")
  self._stateReceivedObj = self:GetGameObject("stateReceived")
  self._stateReceivedTex = self:GetUIComponent("UILocalizationText", "stateReceivedTex")
  self._stateReceivedTexEn = self:GetUIComponent("UILocalizationText", "stateReceivedTexEn")
  self._stateReceivedTexEnObj = self:GetGameObject("stateReceivedTexEn")
end

function UIActivityEveSinsaTaskQuestListItem:OnShow(uiParams)
  self._isFirst = true
  self._module = GameGlobal.GetModule(QuestModule)
  if self._module == nil then
    Log.fatal("[quest] erro --> module is nil !")
    return
  end
  self._itemCountPerRow = 1
end

function UIActivityEveSinsaTaskQuestListItem:SetData(index, quest, callback, itemCallback, gotStr, canGetStr, bgNotFinish, bgFinish)
  self:_GetComponents()
  self._index = index
  self._quest = quest:QuestInfo()
  self._callback = callback
  self._itemCallback = itemCallback
  self._gotStr = gotStr
  self._canGetStr = canGetStr
  self._bgNotFinish = bgNotFinish
  self._bgFinish = bgFinish
  self._rewardCount = table.count(self._quest.rewards)
  self:_OnValue()
end

function UIActivityEveSinsaTaskQuestListItem:OnHide()
end

function UIActivityEveSinsaTaskQuestListItem:_OnValue()
  self._desTex:SetText(StringTable.Get(self._quest.CondDesc))
  local progress = ""
  if self._quest.ShowType == 1 then
    local c, d = math.modf(self._quest.cur_progress * 100 / self._quest.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  else
    progress = self._quest.cur_progress .. "/" .. self._quest.total_progress
  end
  self._progressValueTex:SetText(progress)
  local rate = self._quest.cur_progress / self._quest.total_progress
  self._progressValueImg.fillAmount = rate
  local EnglishFlag = HelperProxy:GetInstance():IsInEnglish()
  self._stateCanGetTexEnObj:SetActive(EnglishFlag)
  self._stateReceivedTexEnObj:SetActive(EnglishFlag)
  self._stateCanGetTex:SetText(StringTable.Get(self._canGetStr))
  self._stateCanGetTexEn:SetText(StringTable.Get(self._canGetStr))
  self._stateReceivedTex:SetText(StringTable.Get(self._gotStr))
  self._stateReceivedTexEn:SetText(StringTable.Get(self._gotStr))
  local urlBg = self._bgFinish
  if self._quest.status <= QuestStatus.QUEST_Accepted then
    urlBg = self._bgNotFinish
    self._stateCanGetObj:SetActive(false)
    self._stateReceivedObj:SetActive(false)
  elseif self._quest.status == QuestStatus.QUEST_Completed then
    self._stateCanGetObj:SetActive(true)
    self._stateReceivedObj:SetActive(false)
  elseif self._quest.status == QuestStatus.QUEST_Taken then
    self._stateCanGetObj:SetActive(false)
    self._stateReceivedObj:SetActive(true)
  end
  if self._bg then
    self._bg:LoadImage(urlBg)
  end
  if self._isFirst then
    self._isFirst = false
    self._list:InitListView(self._rewardCount, function(scrollView, index)
      return self:_InitScrollViewList(scrollView, index)
    end)
  else
    self:_RefreshList(self._quest.rewards, self._list)
  end
end

function UIActivityEveSinsaTaskQuestListItem:_RefreshList(info, list)
  local count = table.count(info)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list:RefreshAllShownItem()
  list.ScrollRect.content.localPosition = contentPos
end

function UIActivityEveSinsaTaskQuestListItem:_InitScrollViewList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIActivityEveSinsaTaskRewardItem", self._itemCountPerRow)
  end
  local rewardList = self._quest.rewards
  local rewardCount = #rewardList
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local itemIndex = index * self._itemCountPerRow + i
    if rewardCount < itemIndex then
      rowList[i]:GetGameObject():SetActive(false)
    else
      rowList[i]:GetGameObject():SetActive(true)
      rowList[i]:SetData(itemIndex, rewardList[itemIndex], self._itemCallback)
    end
  end
  return item
end

function UIActivityEveSinsaTaskQuestListItem:getRewardBtnOnClick()
  if self._callback then
    self._callback(self._quest)
  end
end
