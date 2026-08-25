local SubplotStageListItem, Super = System.NewComponent("SubplotStageListItem")

function SubplotStageListItem:ctor(uiNode, model, stageTid, index)
  Super.ctor(self)
  self.ui = UI_Chapter_Item_Level_ContentResource(uiNode)
  self.model = model
  self.stageTid = stageTid
  self.index = index
  self.stageData = model and model:GetStageData(stageTid)
  local locked = model and not model:IsSubplotUnlocked(stageTid)
  self.isLocked = Vue.ref(locked)
  self.unlockTimer = nil
end

function SubplotStageListItem:OnBind(binder)
  self:_BindTimer(binder)
  self:_BindStarShow(binder)
  binder:BindToText(self.ui.Text_Level_Number, System.fn(self, self._GetStageName))
  binder:BindToText(self.ui.Text_Achievement, System.fn(self, self._GetAchievementProgress))
  binder:BindToVisible(self.ui.Group_AVG, System.fn(self, self._IsStoryStage))
  binder:BindToVisible(self.ui.Group_Fight, System.fn(self, self._IsBattleStage))
  binder:BindToVisible(self.ui.Image_Icon_Trophy, System.fn(self, self._HasAchievement))
  binder:BindToVisible(self.ui.Group_Star, System.fn(self, self._IsShowGroupStar))
  binder:BindToVisible(self.ui.Image_Select, System.fn(self, self._OnSelected))
  binder:BindToVisible(self.ui.Group_Lock, System.fn(self, self._IsLocked))
  binder:BindToVisible(self.ui.Image_Time, System.fn(self, self._IsLocked))
  binder:BindButtonClick(self.ui.Button_Click, System.fn(self, self._OnClick))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, System.fn(self, self._RedFunc)))
end

function SubplotStageListItem:_OnSelected()
  return self.model.curStageTid == self.stageTid
end

function SubplotStageListItem:_HasAchievement()
  return false
end

function SubplotStageListItem:_IsStoryStage()
  if not self.model then
    return false
  end
  do return self.model.IsStoryStage, self.model end
  return self.model.IsStoryStage, self.model, self.stageTid
end

function SubplotStageListItem:_IsBattleStage()
  if not self.model then
    return false
  end
  return not self.model:IsStoryStage(self.stageTid)
end

function SubplotStageListItem:_IsShowGroupStar()
  local config = DT.Stage[self.stageTid]
  return self:_IsBattleStage() and config.PerfectCondition ~= nil
end

function SubplotStageListItem:_GetAchievementProgress()
  return false
end

function SubplotStageListItem:_GetStageIndex()
  if not self.model then
    return
  end
  do return self.model.GetStageIndex, self.model end
  return self.model.GetStageIndex, self.model, self.stageTid
end

function SubplotStageListItem:_GetStageName()
  if not self.model then
    return ""
  end
  local stageName = self.model:GetStageName(self.stageTid)
  if self:_IsLocked() then
    stageName = LT.Text("LockedSubplotStageName")
  end
  do return StrUtils.ReplaceAvgContent end
  return StrUtils.ReplaceAvgContent, stageName
end

function SubplotStageListItem:_BindTimer(binder)
  self:_ClearTimer()
  if not self.model:CheckNumblerValid(self.stageTid) then
    return
  end
  if self.isLocked.value == false then
    binder:SetText(self.ui.Text_Time, "")
    return
  end
  local leftTime = self.model:GetLeftTime(self.stageTid)
  if leftTime <= 0 then
    return
  end
  binder:SetText(self.ui.Text_Time, TimeUtils.UnlockedCountDownFormat(leftTime))
  self.unlockTimer = binder:BindTimer(1, -1, function()
    leftTime = leftTime - 1
    if leftTime <= 0 then
      self:_ClearTimer()
      self:_SetIsLocked(false)
      return
    end
    binder:SetText(self.ui.Text_Time, TimeUtils.UnlockedCountDownFormat(leftTime))
  end, function()
    self:_SetIsLocked(false)
    self:_ClearTimer()
  end)
end

function SubplotStageListItem:_BindStarShow(binder)
  binder:BindToRaw(function(childBinder, nStar, _)
    if not nStar then
      return
    end
    for i = 1, 3 do
      local obj = self.ui["Star_" .. i]
      if obj then
        childBinder:SetActive(obj, i <= nStar)
      end
    end
  end, function()
    if not self.stageData then
      return 0
    end
    if self:_IsStoryStage() then
      return 0
    end
    return self.stageData.star or 0
  end)
end

function SubplotStageListItem:_IsLocked()
  return self.isLocked.value
end

function SubplotStageListItem:_OnClick()
  if not self.model:CheckNumblerValid(self.stageTid) then
    Logger.Info("[Subplot] Error param:", self.stageTid)
    return
  end
  if self:_IsLocked() then
    local leftTime = self.model:GetLeftTime(self.stageTid)
    local leftTimeText = TimeUtils.UnlockedCountDownFormat(leftTime)
    local tipStr = DT.TipsType[10647].Desc
    tipStr = LT.Textf(tipStr, leftTimeText)
    Alert.Show(10647, nil, nil, nil, tipStr)
    return
  end
  SubplotRedUtils.RemoveStageNew(self.stageTid)
  local withoutOpenItem = false
  
  local function challengeCallback()
    print("---------[SubplotStageListItem]challengeCallback", self.stageTid, debug.traceback())
    StageExitPanelManager.Instance:PushWhenSubplotExit(self.stageTid)
  end
  
  UIManager.Instance:Reopen(Urls.CopyStageDetailView, self.stageTid, challengeCallback, withoutOpenItem, self.model.hasSubplotActivity)
end

function SubplotStageListItem:_RedFunc()
  if self:_IsLocked() then
    return
  end
  local red = SubplotRedUtils.GetRedByStageTid(self.stageTid)
  return red
end

function SubplotStageListItem:_ClearTimer()
  if self.unlockTimer then
    TimerManager.Instance:StopTimer(self.unlockTimer)
    self.unlockTimer = nil
  end
end

function SubplotStageListItem:_SetIsLocked(isLocked)
  if nil == isLocked then
    isLocked = false
  end
  self.isLocked.value = isLocked
end

return SubplotStageListItem
