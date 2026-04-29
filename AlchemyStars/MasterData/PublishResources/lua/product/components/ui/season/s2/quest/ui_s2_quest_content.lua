_class("UIS2QuestContent", UICustomWidget)
UIS2QuestContent = UIS2QuestContent

function UIS2QuestContent:CloseDialogWithAnim(callback)
  self:_PlayAnim(3, callback)
end

function UIS2QuestContent:OnShow(uiParams)
  self._responseEvent = true
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._seasonId = self._seasonModule:GetCurSeasonID()
  self._seasonObj = self._seasonModule:GetCurSeasonObj()
  self._componentId = ECCampaignSeasonComponentID.QUEST
  self._component = self._seasonObj:GetComponent(self._componentId)
  
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self:_Attach()
end

function UIS2QuestContent:OnHide()
  self:_Detach()
end

function UIS2QuestContent:SetData(params)
  self._ownerName = params and params.ownerName
  self._closeCallback = params and params.closeCallback
  local type = self._ownerName == "UISeasonQuestController" and 1 or 2
  self._type = type
  self:_SetScrollView_Bg()
  self:_Refresh(true)
  local first = self:_CalcFirstShowIndex()
  self:_SetScrollViewPosByIndex(first)
  self:_SetGoBtn()
  self:_SetType(type)
  self:_PlayAnim(type)
  self:_CellListPlayAnim(first)
end

function UIS2QuestContent:_Refresh(isFirst)
  self:_SetCellList()
  self:_SetClaimAllBtn()
end

function UIS2QuestContent:_SetType(type)
  if type == 1 then
    return
  end
  local offset = 180
  UIWidgetHelper.SetAnchoredPosition(self, "ScrollView_Bg", offset, 0)
  UIWidgetHelper.SetAnchoredPosition(self, "_nextPageHint", offset, 0)
  UIWidgetHelper.SetAnchoredPosition(self, "ScrollView_Item", offset, 0)
end

function UIS2QuestContent:_PlayAnim(type, callback)
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

function UIS2QuestContent:_SetGoBtn(show)
  local isShow = self._ownerName ~= "UISeasonQuestController"
  self:GetGameObject("GoBtn"):SetActive(isShow)
end

function UIS2QuestContent:_SetClaimAllBtn()
  local isShow = self._component:HasQuestCanClaim(self._cellDatas)
  self:GetGameObject("ClaimAllBtn"):SetActive(isShow)
end

function UIS2QuestContent:_SetScrollView_Bg()
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

function UIS2QuestContent:_SetCellListData()
  self._cellDatas = UIS1Helper.GetQuestInfo_BySeasonFilter(self._component)
  self._cellDatas = UIS1Helper.HideQuest(self._cellDatas)
  self._questStatus = self._component:GetCampaignQuestStatus(self._cellDatas)
end

function UIS2QuestContent:_SetCellList()
  self:_SetCellListData()
  local objs = UIWidgetHelper.SpawnObjects(self, "Content", "UIS2QuestCell", #self._cellDatas)
  for i, v in ipairs(objs) do
    local quest = self._cellDatas[i]
    local state = self._questStatus[quest]
    v:SetData(self._type, i, self._component, quest, state, function(uiView, questInfo)
      self:_ClaimOneBtn(uiView, questInfo)
    end, self._tipsCallback)
  end
  self._cells = objs
end

function UIS2QuestContent:_CellListPlayAnim(first)
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

function UIS2QuestContent:_CalcFirstShowIndex()
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

function UIS2QuestContent:_SetScrollViewPosByIndex(index)
  local count = #self._cellDatas
  local pos = Mathf.Clamp((count - index) / (count - 1), 0, 1)
  self:_SetScrollViewPos(false, pos)
end

function UIS2QuestContent:_SetScrollViewPos(hor, normalizedPos)
  local svItem = self:GetUIComponent("ScrollRect", "ScrollView_Item")
  if hor then
    svItem.horizontalNormalizedPosition = normalizedPos
  else
    svItem.verticalNormalizedPosition = normalizedPos
  end
end

function UIS2QuestContent:GoBtnOnClick(go)
  UISeasonHelper.ShowCurSeasonMainController()
end

function UIS2QuestContent:ClaimAllBtnOnClick(go)
  self._component:Start_HandleOneKeyTakeQuest(function(res, rewards)
    self:_OnRecvRewards(res, rewards)
  end)
end

function UIS2QuestContent:_ClaimOneBtn(uiView, questInfo)
  self._component:Start_HandleQuestTake(questInfo.quest_id, function(res, rewards)
    self:_OnRecvRewards(res, rewards)
  end)
end

function UIS2QuestContent:_OnRecvRewards(res, rewards)
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

function UIS2QuestContent:_Attach()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIS2QuestContent:_Detach()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIS2QuestContent:OnUIGetItemCloseInQuest()
  if self._ownerName ~= "UISeasonQuestController" and not self._responseEvent then
    return
  end
  self:_Refresh()
end

function UIS2QuestContent:SetResponseEvent(val)
  self._responseEvent = val
end
