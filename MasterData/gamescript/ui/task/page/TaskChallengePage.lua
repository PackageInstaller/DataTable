local RectTransform = CS.UnityEngine.RectTransform
local typeof = _ENV.typeof
local TaskChallengePage, Super = System.NewClass("TaskChallengePage", TaskBasePage)

function TaskChallengePage:ctor(uiNode, serverIdx)
  Super.ctor(self, serverIdx)
  self.serverIdx = serverIdx
  self.ui = UI_Task_Popup_ChallengeResource(uiNode)
end

function TaskChallengePage:OnBind(binder)
  self.binder = binder
  self.itemCircularGroupRT = self.ui.Content:GetComponent(typeof(RectTransform))
  binder:BindToText(self.ui.Text_Name, function()
    return DataCenter.playerData.DRole.name
  end)
  binder:BindToText(self.ui.Text_Time, function()
    do return TimeUtils.TimestampToString, DataCenter.playerData.DRole.createTime end
    return TimeUtils.TimestampToString, DataCenter.playerData.DRole.createTime, TimeUtils.TimeExactType.Day
  end)
  binder:BindToText(self.ui.Text_Challenge, function()
    do return LT.Text, PlayerDataUtils.GetLevel() end
    return LT.Text, PlayerDataUtils.GetLevel()
  end)
  binder:BindToImage(self.ui.Image_PLayer, function()
    local genderCfg = GenderDataUtils.GetGenderCfgByRoleData()
    return genderCfg and genderCfg.PlayerLevelTaskAvatarRes
  end)
  self:BindCurrency()
  self:SortList(self.taskList.value)
  binder:BindToCircularListView(self.ui.ScrollView_Career_List, function()
    return self.taskList.value
  end, function(itemBinder, item, index)
    local taskData = self.taskList.value[index]
    local itemData = {
      taskState = taskData.state,
      taskTid = taskData.tid,
      taskUid = taskData.uid
    }
    itemBinder:BindComponent(TaskPlayerLevelItem(item, itemData))
  end)
  self.binder:BindToRaw(function(childBinder, nVal, oVal)
    if 0 == oVal and nVal > 0 then
      childBinder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Career_List)
    end
  end, function()
    return #self.taskList.value
  end)
  binder:BindEvent(EventMgr.Instance.TaskViewUpdate, function(serverIdx)
    if serverIdx == CommonDefine.TaskServerIndex.PlayerLevel then
      self:UpdatePageShow(CommonDefine.TaskServerIndex.PlayerLevel)
    end
  end)
end

function TaskChallengePage:SortList(list)
  local tempList = table.deepclone(list)
  table.sort(tempList, function(a, b)
    local aCfg = DT.Task[a.tid]
    local bCfg = DT.Task[b.tid]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  self.taskList.value = tempList
end

function TaskChallengePage:BindCurrency()
  local coinList = {}
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, coinList))
end

function TaskChallengePage:GetCompleteTaskNum(list)
  local returnNum = 0
  local tempList = table.deepclone(list)
  for _, value in pairs(tempList) do
    if value.state == CommonDefine.TaskState.Done then
      returnNum = returnNum + 1
    end
  end
  return returnNum
end

function TaskChallengePage:UpdatePageShow(serverIdx)
  self:SortList(TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx) or {})
end

function TaskChallengePage:OnOpen()
  self:JumpToDefaultIdx()
  self.binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Career_List)
end

function TaskChallengePage:JumpToDefaultIdx()
  local firstReceiveIdx = 0
  local firstDoingIdx = 0
  for idx, taskData in pairs(self.taskList.value) do
    if 0 == firstReceiveIdx and taskData.state == CommonDefine.TaskState.Receive then
      firstReceiveIdx = idx
    end
    if 0 == firstDoingIdx and taskData.state == CommonDefine.TaskState.Doing then
      firstDoingIdx = idx
    end
  end
  local finalJumpIdx = #self.taskList.value
  if 0 ~= firstReceiveIdx then
    finalJumpIdx = firstReceiveIdx
  elseif 0 ~= firstDoingIdx then
    finalJumpIdx = firstDoingIdx
  end
  self.binder:CircularScrollTo(self.ui.ScrollView_Career_List, finalJumpIdx)
  local pos = self.itemCircularGroupRT.anchoredPosition
  local offset = pos.y - 1
  FrameWaiter.OnNextFrame(function()
    self.itemCircularGroupRT.anchoredPosition = CS.UnityEngine.Vector2(pos.x, offset + 1)
  end, 1)
  FrameWaiter.OnNextFrame(function()
    self.itemCircularGroupRT.anchoredPosition = CS.UnityEngine.Vector2(pos.x, offset - 1)
  end, 2)
end

return TaskChallengePage
