_class("UIS5QuestContent", UICustomWidget)
UIS5QuestContent = UIS5QuestContent

function UIS5QuestContent:Constructor()
  self._scrollViewInit = false
end

function UIS5QuestContent:CloseDialogWithAnim(callback)
  self:_PlayAnim("out", callback)
end

function UIS5QuestContent:OnShow(uiParams)
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

function UIS5QuestContent:OnHide()
  self:_Detach()
end

function UIS5QuestContent:SetData(params)
  self._ownerName = params and params.ownerName
  self._closeCallback = params and params.closeCallback
  self._isQuestController = self._ownerName == "UISeasonQuestController"
  self._type = self._isQuestController and 1 or 2
  self:_Refresh(true)
  self:_SetGoBtn()
  local anim = self._isQuestController and "in" or "in2"
  self:_PlayAnim(anim)
end

function UIS5QuestContent:_Refresh(isFirst)
  self:_DynamicSv(isFirst)
  self:_SetClaimAllBtn()
end

function UIS5QuestContent:_PlayAnim(type, callback)
  local tb = {
    ["in"] = {
      animName = "uieffanim_UIS2QuestContent_in",
      duration = 1333
    },
    in2 = {
      animName = "uieffanim_UIS2QuestContent_in2",
      duration = 1333
    },
    out = {
      animName = "uieffanim_UIS1QuestContent_out",
      duration = 200
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[type].animName, tb[type].duration, callback, true)
end

function UIS5QuestContent:_SetGoBtn()
  local isShow = not self._isQuestController
  self:GetGameObject("Title"):SetActive(not isShow)
  self:GetGameObject("GoBtn"):SetActive(isShow)
  local widgetName = isShow and "GoBtn" or "Title"
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIS5Title")
end

function UIS5QuestContent:_SetClaimAllBtn()
  local isShow = self._component:HasQuestCanClaim(self._cellDatas)
  self:GetGameObject("ClaimAllBtn"):SetActive(isShow)
end

function UIS5QuestContent:_SetCellListData()
  self._cellDatas = UIS1Helper.GetQuestInfo_BySeasonFilter(self._component)
  self._questStatus = self._component:GetCampaignQuestStatus(self._cellDatas)
  self._component:SortQuestInfoByCampaignQuestStatus(self._cellDatas)
end

function UIS5QuestContent:_DynamicSv(isFirst)
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

function UIS5QuestContent:DynamicSvInfo(scrollView, index)
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

function UIS5QuestContent:GoBtnOnClick(go)
  UISeasonHelper.ShowCurSeasonMainController()
end

function UIS5QuestContent:ClaimAllBtnOnClick(go)
  self._component:Start_HandleOneKeyTakeQuest(function(res, rewards)
    self:_OnRecvRewards(res, rewards)
  end)
end

function UIS5QuestContent:_ClaimOneBtn(uiView, questInfo)
  self._component:Start_HandleQuestTake(questInfo.quest_id, function(res, rewards)
    self:_OnRecvRewards(res, rewards)
  end)
end

function UIS5QuestContent:_OnRecvRewards(res, rewards)
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

function UIS5QuestContent:_Attach()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIS5QuestContent:_Detach()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIS5QuestContent:OnUIGetItemCloseInQuest()
  if not self._isQuestController and not self._responseEvent then
    return
  end
  self:_Refresh()
end

function UIS5QuestContent:SetResponseEvent(val)
  self._responseEvent = val
end
