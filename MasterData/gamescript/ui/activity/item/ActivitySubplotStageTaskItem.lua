local ActivitySubplotStageTaskItem, Super = System.NewClass("ActivitySubplotStageTaskItem", ActivityBaseComp)

function ActivitySubplotStageTaskItem:ctor(uiNode, taskData, onGainPrize)
  Super.ctor(self)
  self.ui = UI_Events_Item_StageResource(uiNode)
  self.taskData = taskData
  self.onGainPrize = onGainPrize
end

function ActivitySubplotStageTaskItem:OnBind(binder)
  local taskCfg = DT.Task[self.taskData.tid]
  binder:BindToRaw(function(childBinder, count)
    local stageId = taskCfg.CompleteCondPara[1]
    local stageCfg = DT.Stage[stageId]
    local stageData = MainCopyDataUtils.GetStageData(stageId)
    if not stageData then
      local stageName = "@1@2"
      local taskDesc = LT.Textf(taskCfg.Desc, stageName)
      local maxCount = TaskDataUtils.GetTaskProgressLimit(self.taskData.tid)
      local desc = string.format("%s(%s/%s)", taskDesc, count, maxCount)
      childBinder:SetText(self.ui.Text_Describe, desc)
      return
    end
    local timeToStageOpen = stageData.openTime - TimeUtils.GetServerTime()
    if timeToStageOpen > 0 then
      local stageName = "@1@2"
      local taskDesc = LT.Textf(taskCfg.Desc, stageName)
      local maxCount = TaskDataUtils.GetTaskProgressLimit(self.taskData.tid)
      
      local function setDesc(countdown)
        if self.ui then
          local d, h = TimeUtils.SecToDayHour(countdown)
          local timeDesc = LT.Textf("SubplotActivityRewardTimeTips", d, h)
          local desc = string.format("%s(%s/%s) %s", taskDesc, count, maxCount, timeDesc)
          childBinder:SetText(self.ui.Text_Describe, desc)
        end
      end
      
      setDesc(timeToStageOpen)
      childBinder:BindTimer(0.033, -1, function()
        timeToStageOpen = math.max(timeToStageOpen - 0.033, 0)
        setDesc(timeToStageOpen)
      end)
    else
      local stageName = LT.Text(stageCfg.Name)
      local taskDesc = LT.Textf(taskCfg.Desc, stageName)
      local maxCount = TaskDataUtils.GetTaskProgressLimit(self.taskData.tid)
      local desc = string.format("%s(%s/%s)", taskDesc, count, maxCount)
      childBinder:SetText(self.ui.Text_Describe, desc)
    end
  end, function()
    return self.taskData.count
  end)
  local itemGO = {
    self.ui.WuPin_Type_1,
    self.ui.WuPin_Type_2,
    self.ui.WuPin_Type_3
  }
  for idx, go in ipairs(itemGO) do
    local itemIdx = idx * 2 - 1
    local itemTid = taskCfg.CompleteAward[itemIdx]
    if itemTid then
      local itemCnt = taskCfg.CompleteAward[itemIdx + 1]
      binder:BindComponent(CommonIconItemType2(go, {itemTid = itemTid, itemCount = itemCnt}))
      go:SetActive(true)
    else
      go:SetActive(false)
    end
  end
  binder:BindToVisible(self.ui.Btn_Receive, function()
    return self.taskData.state == CommonDefine.TaskCommonState.CanFinish
  end)
  binder:BindZ1Button(self.ui.Btn_Receive, function()
    self.onGainPrize(self.taskData)
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "CommonReceive"
  end)
  binder:BindToVisible(self.ui.Image_Undone, function()
    return self.taskData.state == CommonDefine.TaskCommonState.Running
  end)
  binder:BindToVisible(self.ui.Image_Finish, function()
    return self.taskData.state == CommonDefine.TaskCommonState.Finish
  end)
end

return ActivitySubplotStageTaskItem
