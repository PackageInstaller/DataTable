_class("UIS3QuestContent", UICustomWidget)
UIS3QuestContent = UIS3QuestContent

function UIS3QuestContent:Constructor()
  self._scrollViewInit = false
end

function UIS3QuestContent:CloseDialogWithAnim(callback)
  self:_PlayAnim(3, callback)
end

function UIS3QuestContent:OnShow(uiParams)
  self._responseEvent = true
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._seasonId = self._seasonModule:GetCurSeasonID()
  self._seasonObj = self._seasonModule:GetCurSeasonObj()
  self._componentId = ECCampaignSeasonComponentID.QUEST
  self._component = self._seasonObj:GetComponent(self._componentId)
  
  function self._tipsCallback(matid, pos)
    if self._isQuestController then
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, matid, pos)
    end
  end
  
  self:_Attach()
end

function UIS3QuestContent:OnHide()
  self:_Detach()
end

function UIS3QuestContent:SetData(params)
  self._ownerName = params and params.ownerName
  self._closeCallback = params and params.closeCallback
  self._isQuestController = self._ownerName == "UISeasonQuestController"
  local type = self._isQuestController and 1 or 2
  local isZh = UIActivityZhHelper.IsZh()
  type = isZh and type or 1
  self._type = type
  UIWidgetHelper.SetRawImage(self, "drawing", self._isQuestController and "exp_s3_rw_character02" or "exp_s3_rw_character01")
  self:_Refresh(true)
  self:_SetGoBtn()
  self:_PlayAnim(type)
end

function UIS3QuestContent:_Refresh(isFirst)
  self:_DynamicSv(isFirst)
  self:_SetClaimAllBtn()
end

function UIS3QuestContent:_SetType(type)
  if type == 1 then
    return
  end
  local offset = 180
  UIWidgetHelper.SetAnchoredPosition(self, "ScrollView_Bg", offset, 0)
  UIWidgetHelper.SetAnchoredPosition(self, "_nextPageHint", offset, 0)
  UIWidgetHelper.SetAnchoredPosition(self, "ScrollView_Item", offset, 0)
end

function UIS3QuestContent:_PlayAnim(type, callback)
  local tb = {
    {
      animName = "uieffanim_UIS2QuestContent_in",
      duration = 1333
    },
    {
      animName = "uieffanim_UIS2QuestContent_in2",
      duration = 1333
    },
    {
      animName = "uieffanim_UIS1QuestContent_out",
      duration = 200
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[type].animName, tb[type].duration, callback, true)
end

function UIS3QuestContent:_SetGoBtn(show)
  local isShow = not self._isQuestController
  self:GetGameObject("GoBtn"):SetActive(isShow)
end

function UIS3QuestContent:_SetClaimAllBtn()
  local isShow = self._component:HasQuestCanClaim(self._cellDatas)
  self:GetGameObject("ClaimAllBtn"):SetActive(isShow)
end

function UIS3QuestContent:_SetScrollView_Bg()
  local nextPageHint = self:GetGameObject("_nextPageHint")
  local svBg = self:GetUIComponent("ScrollRect", "ScrollView_Bg")
  local svItem = self:GetUIComponent("ScrollRect", "ScrollView_Item")
  svItem.onValueChanged:AddListener(function(value)
    local y = Mathf.Clamp(value.y, 0, 1)
    svBg.verticalNormalizedPosition = y
    local isShow = 0.05 < y and true or false
    nextPageHint:SetActive(isShow)
  end)
end

function UIS3QuestContent:_SetCellListData()
  self._cellDatas = UIS1Helper.GetQuestInfo_BySeasonFilter(self._component)
  self._questStatus = self._component:GetCampaignQuestStatus(self._cellDatas)
  self:_SortCellListData()
end

function UIS3QuestContent:_SetCellList()
  self:_SetCellListData()
  local objs = UIWidgetHelper.SpawnObjects(self, "Content", "UIS3QuestCell", #self._cellDatas)
  for i, v in ipairs(objs) do
    local quest = self._cellDatas[i]
    local state = self._questStatus[quest]
    v:SetData(self._type, i, self._component, quest, state, function(uiView, questInfo)
      self:_ClaimOneBtn(uiView, questInfo)
    end, self._tipsCallback)
  end
  self._cells = objs
end

function UIS3QuestContent:_DynamicSv(isFirst)
  self:_SetCellListData()
  local dataCount = #self._cellDatas
  if self._scrollViewInit then
    self._scrollView:SetListItemCount(dataCount)
    self._scrollView:ResetListView()
    self._scrollView:RefreshAllShownItem()
    self._scrollView:MovePanelToItemIndex(0, 0)
  else
    self._scrollViewInit = true
    self._scrollView = self:GetUIComponent("UIDynamicScrollView", "taskList")
    self._scrollView:InitListView(dataCount, function(scrollView, index)
      return self:DynamicSvInfo(scrollView, index)
    end, nil)
  end
end

function UIS3QuestContent:DynamicSvInfo(scrollView, index)
  local itemCountPerRow = 1
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UINewQuestStoryListItem", itemCountPerRow)
  end
  local luaIndex = index + 1
  local uiWidget = rowPool:GetAllSpawnList()[1]
  uiWidget:HookCallBack(false, function(clickIndex)
  end, function(clickIndex)
    local questInfo = self._cellDatas[clickIndex]:QuestInfo()
    self:_ClaimOneBtn(uiView, questInfo)
  end, self._tipsCallback)
  uiWidget:SetData(luaIndex, self._cellDatas[luaIndex])
  return item
end

function UIS3QuestContent:_CellListPlayAnim(first)
  local offset = 4
  local start = Mathf.Max(first - offset, 1)
  local stop = #self._cells
  for i = start, stop do
    local v = self._cells[i]
    if v then
      v:PlayAnimationInSequence(i - start + 1)
    end
  end
end

function UIS3QuestContent:_CalcFirstShowIndex()
  local count = #self._cellDatas
  local offset_center = -2
  local offset_top = 0
  local index
  for i, v in ipairs(self._cellDatas) do
    if index then
      break
    end
    if self._questStatus[v] == CampaignQuestStatus.CQS_Completed then
      index = i + offset_center
    end
  end
  if not index then
    for i, v in ipairs(self._cellDatas) do
      if self._questStatus[v] ~= CampaignQuestStatus.CQS_Taken then
        index = i + offset_top
        break
      end
    end
  end
  return index or 1
end

function UIS3QuestContent:_SetScrollViewPosByIndex(index)
  local count = #self._cellDatas
  local pos = Mathf.Clamp((count - index) / (count - 1), 0, 1)
  self:_SetScrollViewPos(false, pos)
end

function UIS3QuestContent:_SetScrollViewPos(hor, normalizedPos)
  local svItem = self:GetUIComponent("ScrollRect", "ScrollView_Item")
  if hor then
    svItem.horizontalNormalizedPosition = normalizedPos
  else
    svItem.verticalNormalizedPosition = normalizedPos
  end
end

function UIS3QuestContent:GoBtnOnClick(go)
  UISeasonHelper.ShowCurSeasonMainController()
end

function UIS3QuestContent:ClaimAllBtnOnClick(go)
  self._component:Start_HandleOneKeyTakeQuest(function(res, rewards)
    self:_OnRecvRewards(res, rewards)
  end)
end

function UIS3QuestContent:_ClaimOneBtn(uiView, questInfo)
  self._component:Start_HandleQuestTake(questInfo.quest_id, function(res, rewards)
    self:_OnRecvRewards(res, rewards)
  end)
end

function UIS3QuestContent:_OnRecvRewards(res, rewards)
  if not self.view then
    return
  end
  if res and res:GetSucc() then
    UISeasonHelper.ShowUIGetRewards(rewards)
    self:DispatchEvent(GameEventType.OnSeasonQuestAwardCollected)
  else
    self._seasonModule:CheckErrorCode(res.m_result, self._seasonId, function()
      self:_Refresh()
    end, function()
      if self._closeCallback then
        self._closeCallback()
      end
    end)
  end
end

function UIS3QuestContent:_Attach()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIS3QuestContent:_Detach()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIS3QuestContent:OnUIGetItemCloseInQuest()
  if not self._isQuestController and not self._responseEvent then
    return
  end
  self:_Refresh()
end

function UIS3QuestContent:SetResponseEvent(val)
  self._responseEvent = val
end

function UIS3QuestContent:_SortCellListData()
  local testCase = false
  if testCase then
    for k, v in pairs(self._cellDatas) do
      if v._questInfo.quest_id == 800301 then
        self._questStatus[v] = CampaignQuestStatus.CQS_NotStart
      elseif v._questInfo.quest_id == 800302 then
        self._questStatus[v] = CampaignQuestStatus.CQS_Accepted
      elseif v._questInfo.quest_id == 800303 then
        self._questStatus[v] = CampaignQuestStatus.CQS_Completed
      elseif v._questInfo.quest_id == 800304 then
        self._questStatus[v] = CampaignQuestStatus.CQS_Taken
      elseif v._questInfo.quest_id == 800305 then
        self._questStatus[v] = CampaignQuestStatus.CQS_Over
      end
    end
  end
  
  local function fnStatus2Sort(status)
    if status == CampaignQuestStatus.CQS_Completed then
      return QuestStatus.QUEST_NotStart
    elseif status == CampaignQuestStatus.CQS_Accepted then
      return QuestStatus.QUEST_Accepted
    elseif status == CampaignQuestStatus.CQS_Taken then
      return QuestStatus.QUEST_Completed
    elseif status == CampaignQuestStatus.CQS_NotStart then
      return QuestStatus.QUEST_Taken
    elseif status == CampaignQuestStatus.CQS_Over then
      return QuestStatus.QUEST_Taken
    end
  end
  
  table.sort(self._cellDatas, function(a, b)
    local aSort = fnStatus2Sort(self._questStatus[a])
    local bSort = fnStatus2Sort(self._questStatus[b])
    if aSort == bSort then
      return a:ID() < b:ID()
    else
      return aSort < bSort
    end
    return false
  end)
end
