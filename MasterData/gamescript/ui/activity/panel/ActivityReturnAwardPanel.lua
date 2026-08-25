local ActivityReturnAwardPanel, Super = System.NewClass("ActivityReturnAwardPanel", UIBasePanel)
ActivityReturnAwardPanel.uiResCls = UI_Event_Item_ReturnResource

function ActivityReturnAwardPanel:ctor(activityTid)
  Super.ctor(self)
  self.activityTid = activityTid
  self.config = ActivityDataUtils.GetConfig(self.activityTid)
  self.activityData = ActivityManager.Instance.model:GetActivityDataClient(self.activityTid)
  self:_ParseConfigData()
end

function ActivityReturnAwardPanel:OnBind(binder)
  self.binder = binder
  self:_SetText(binder)
  self:_OnBindButtons(binder)
  self:_OnBindAwardList(binder)
end

function ActivityReturnAwardPanel:_ParseConfigData()
  local textStr = self.config and self.config.ActivityPara2 or ""
  local textArr = string.split(textStr, ",")
  self.awardBtnText = LT.Text(textArr[1]) or ""
  self.titleText = LT.Text(textArr[2]) or ""
  self.contentText = LT.Text(textArr[3]) or ""
  self.signText = LT.Text(textArr[4]) or ""
  self.awardList = {}
  self.returnAwardTaskTid = ActivityDataUtils.GetSpecialTaskListActivityAwardTaskTid(self.activityTid)
  if self.returnAwardTaskTid then
    local taskCfg = TaskDataUtils.GetConfig(self.returnAwardTaskTid)
    if taskCfg and taskCfg.CompleteAward then
      for i = 1, #taskCfg.CompleteAward, 2 do
        local tid = taskCfg.CompleteAward[i]
        local num = taskCfg.CompleteAward[i + 1]
        if tid and num then
          table.insert(self.awardList, {tid = tid, num = num})
        end
      end
    end
  end
end

function ActivityReturnAwardPanel:_SetText(binder)
  binder:SetText(self.ui.Text_Title, self.titleText)
  binder:SetText(self.ui.Text_Information, self.contentText)
  binder:SetText(self.ui.Text_Name, self.signText)
end

function ActivityReturnAwardPanel:_OnBindButtons(binder)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level1, System.fn(self, self._OnClickAwardBtn), System.fn(self, self._GetAwardBtnState), function()
    return self.awardBtnText
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindToVisible(self.ui.UI_Common_Btn_Level1, function()
    local rst = self:_HasGotReturnPrize()
    return not rst
  end)
  binder:BindToVisible(self.ui.Image_Line_3, System.fn(self, self._HasGotReturnPrize))
end

function ActivityReturnAwardPanel:_OnBindAwardList(binder)
  binder:SetActive(self.ui.ScrollView_Thing, true)
  CS.Framework.TransformUtil.SetHeight(self.ui.ScrollView_Information.transform, 270.7)
  binder:BindToCircularListView(self.ui.ScrollView_Thing, function()
    return self.awardList
  end, function(itemBinder, go, index)
    local award = self.awardList[index]
    
    local function _HasGotAward()
      do return self._HasGotReturnPrize end
      return self._HasGotReturnPrize, self
    end
    
    local itemData = {
      itemTid = award.tid,
      itemCount = award.num,
      isGotFunc = _HasGotAward
    }
    setmetatable(itemData, ReactiveFlags.SKIP)
    itemBinder:BindComponent(CommonIconItemType2(go, itemData))
  end)
end

function ActivityReturnAwardPanel:_OnClickAwardBtn()
  local specialTaskListData = self.activityData
  if not (specialTaskListData and specialTaskListData.taskList) or not specialTaskListData.taskList[self.returnAwardTaskTid] then
    return
  end
  if self:_HasGotReturnPrize() then
    return
  end
  ActivityDataUtils.ReqGainAward(self.activityTid, self.returnAwardTaskTid, {}, function(result)
    if result then
      specialTaskListData.taskList[self.returnAwardTaskTid].state = CommonDefine.CommonState.Finish
      ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
    end
  end)
end

function ActivityReturnAwardPanel:_GetAwardBtnState()
  if not self.activityData or self.activityData.specialPrizeGain then
    return CommonDefine.BtnType.Unclickable
  end
  return CommonDefine.BtnType.High
end

function ActivityReturnAwardPanel:_HasGotReturnPrize()
  local specialTaskListData = self.activityData
  if not specialTaskListData then
    return
  end
  if not self.returnAwardTaskTid then
    return false
  end
  local taskData = specialTaskListData.taskList and specialTaskListData.taskList[self.returnAwardTaskTid]
  if not taskData then
    return false
  end
  return taskData.state == CommonDefine.CommonState.Finish
end

function ActivityReturnAwardPanel:Close()
  Super.Close(self)
end

return ActivityReturnAwardPanel
