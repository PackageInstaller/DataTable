local MAX_REWARD_NUM = 4
local MainCopyAchievementItem, Super = System.NewComponent("MainCopyAchievementItem")

function MainCopyAchievementItem:ctor(uiNode, taskId, stageData)
  Super.ctor(self)
  self.ui = UI_Chapter_Item_Success_ListResource(uiNode)
  self.taskId = Vue.ref(taskId)
  self.stageData = stageData
  self.stageId = self.stageData.stageID
  self.state = Vue.ref(MainCopyDataUtils.GetAchieveState(self.stageData, taskId))
end

function MainCopyAchievementItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Finish_Title, function()
    local taskCfg = DT.Task[self.taskId.value]
    do return LT.Text end
    return LT.Text, taskCfg.Name
  end)
  binder:BindToText(self.ui.Text_Finish_Tips, function()
    local taskCfg = DT.Task[self.taskId.value]
    do return LT.Text end
    return LT.Text, taskCfg.Desc
  end)
  binder:BindToText(self.ui.Text_Lost, function()
    do return LT.Text end
    return LT.Text, "WeekChallengeNotReached"
  end)
  binder:BindToVisible(self.ui.Text_Lost, function()
    return self.state.value == CommonDefine.MainCopyAchieveState.NotAchieved
  end)
  binder:BindToVisible(self.ui.Btn_Get, function()
    return self.state.value == CommonDefine.MainCopyAchieveState.IsFinish
  end)
  binder:BindZ1Button(self.ui.Btn_Get, function()
    ProtoManager.Instance:ReqServer("GameRequest", "GainStageAchievementRw", function(_)
      local stageData = MainCopyDataUtils.GetStageData(self.stageId)
      if stageData.achivement then
        stageData.achivement[self.taskId.value] = CommonDefine.MainCopyAchieveState.IsGot
        self.state.value = CommonDefine.MainCopyAchieveState.IsGot
        EventMgr.Instance.AchieveRewarded:Dispatch()
      end
    end, nil, self.stageId, self.taskId.value)
  end, nil, function()
    do return LT.Text end
    return LT.Text, "StoryLineTask_String_Available"
  end, function()
    return RedPointDataUtils.RedAttrType.Red
  end)
  binder:BindToVisible(self.ui.Image_Got_Icon, function()
    return self.state.value == CommonDefine.MainCopyAchieveState.IsGot
  end)
  binder:BindToVisible(self.ui.Image_Bg_Got, function()
    return self.state.value == CommonDefine.MainCopyAchieveState.IsGot
  end)
  binder:BindToRaw(function(itemBinder, nVal)
    local rewards = {}
    local taskCfg = DT.Task[self.taskId.value]
    for itemTid, itemCount in table.iteraDouble(taskCfg.CompleteAward or {}) do
      table.insert(rewards, {
        tid = itemTid,
        type = CommonDefine.ItemAwardType.Normal,
        num = itemCount,
        isGot = nVal == CommonDefine.MainCopyAchieveState.IsGot
      })
    end
    for index = 1, MAX_REWARD_NUM do
      local obj = self.ui["WuPin_Type_" .. index]
      local rewardData = rewards[index]
      if rewardData then
        local itemData = {
          itemTid = rewardData.tid,
          itemCount = rewardData.num
        }
        itemBinder:BindComponent(CommonIconItemType2(obj, itemData))
      end
      obj:SetActive(rewardData)
    end
  end, function()
    return self.state.value
  end)
end

function MainCopyAchievementItem:UpdateItemTid(taskTid)
  self.taskId.value = taskTid
end

return MainCopyAchievementItem
