local WeeklyTaskItem, Super = NewClass("WeeklyTaskItem", ViewComponent)

function WeeklyTaskItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Main_Item_ActiveTasksResource(uiNode)
  self.data = data
  self._rewards = data.rewards or {}
end

function WeeklyTaskItem:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:_CreateRewardTableView()
  self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self._OnClickReceive))
  self:RegisterNotify(NotifyId.OnDailyChallengeDataChanged, System.fn(self, self._OnDailyChallengeUpdate))
end

function WeeklyTaskItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:Refresh()
end

function WeeklyTaskItem:Refresh()
  self:SetActive(self.ui.Btn_Proxy, false)
  if not self.data then
    return
  end
  self:SetText(self.ui.Text_Desc, self.data.desc)
  local state = self.data.state
  local RewardState = cd.RewardState
  self:SetActive(self.ui.Group_Got, state == RewardState.Received)
  self:SetActive(self.ui.Btn_Receive, state == RewardState.Available)
  self:SetActive(self.ui.Group_NotReceive, state == RewardState.Unavailable or state == RewardState.Dummy)
  self:_RefreshRewards()
end

function WeeklyTaskItem:_OnClickReceive()
  self:RequestGainPrize(self.data.idx, self.data.score, function(success)
    self:Refresh()
  end)
end

function WeeklyTaskItem:_OnDailyChallengeUpdate()
  self:Refresh()
end

function WeeklyTaskItem:_RefreshRewards()
  self._rewardTableView:ReloadData()
end

function WeeklyTaskItem:_CreateRewardTableView()
  local cellGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local sizeDelta = cellGameObj.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._rewardTableView = self:CreateTableview(self.ui.ScrollView_Award, function()
    return #self._rewards
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(cellGameObj)
    local rewardData = self._rewards[index]
    local viewData = {
      itemTid = rewardData.tid,
      itemCount = rewardData.count
    }
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
    return cell
  end, function()
    return w, h
  end)
end

function WeeklyTaskItem:RequestGainPrize(idx, score, callback)
  local params = DT.GetOriginalConstant("DailyChallengeSkipConsume")
  local skipItemId = params[1]
  
  local function reqGainPrize()
    DailyChallengeController.Instance:RequestGainPrize(idx, score, callback)
  end
  
  local totalCnt = 0
  local infos = DailyChallengeController.Instance:GetWeekRewardInfos()
  for _, info in pairs(infos) do
    if info.score == score then
      for _, reward in ipairs(info.rewards) do
        if reward.tid == skipItemId then
          totalCnt = totalCnt + reward.count
        end
      end
      break
    end
  end
  if totalCnt > 0 and GetChallengeSkipItemCheckUtils.ItemIsOverMax(totalCnt) then
    GetChallengeSkipItemCheckUtils.TipsShow(reqGainPrize)
  else
    reqGainPrize()
  end
end

return WeeklyTaskItem
