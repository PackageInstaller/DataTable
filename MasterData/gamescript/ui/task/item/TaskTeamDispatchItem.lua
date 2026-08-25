local TaskTeamDispatchItem, Super = System.NewComponent("TaskTeamDispatchItem")

function TaskTeamDispatchItem:ctor(uiNode, data, awakerList, clickCb)
  Super.ctor(self)
  self.ui = UI_Task_Item_TeamdispatchResource(uiNode)
  self.taskData = data
  self.taskCfg = DT.Task[data.tid]
  self.taskType = self.taskCfg.TaskType
  self.awakerList = Vue.ref(awakerList)
  self.completeCond = self.taskCfg.CompleteCond
  self.extraCond = self.taskCfg.ExtraCondType
  self.clickCb = clickCb
  self.isComplete = false
  self.isExtra = false
end

function TaskTeamDispatchItem:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.Btn_Dispatch, System.fn(self, self.OnBtnDispatch), function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end, nil, nil, nil)
  binder:BindToRaw(function()
  end, function()
    self:UpdateTaskInfo(self.awakerList.value)
  end)
  if self.taskCfg.CompleteCondDesc then
    self.ui.Text_Biyao:SetActive(true)
    self.ui.Text_Biyao_Tip:SetActive(true)
    self.biyaoTips = LT.Textf(self.taskCfg.CompleteCondDesc, table.unpack(self.taskCfg.CompleteCondPara))
    binder:SetText(self.ui.Text_Biyao_Tip, self.biyaoTips)
  else
    self.ui.Text_Biyao:SetActive(false)
    self.ui.Text_Biyao_Tip:SetActive(false)
  end
  if self.taskCfg.ExtraCondDesc then
    self.ui.Text_Jiafen:SetActive(true)
    self.ui.Text_Jiafen_Tip:SetActive(true)
    self.extraTips = LT.Textf(self.taskCfg.ExtraCondDesc, table.unpack(self.taskCfg.ExtraCondPara))
    binder:SetText(self.ui.Text_Jiafen_Tip, self.extraTips)
  else
    self.ui.Text_Jiafen:SetActive(false)
    self.ui.Text_Jiafen_Tip:SetActive(false)
  end
end

function TaskTeamDispatchItem:OnBtnDispatch()
  if self.clickCb then
    self.clickCb()
  end
end

function TaskTeamDispatchItem:UpdateTaskInfo(awakerList)
  if self.completeCond then
    local condInfo = TaskDataUtils.GetConditionInfo(self.completeCond, self.taskCfg.CompleteCondPara, awakerList)
    self.isComplete = condInfo.isOk
    self.binder:BindToTextColorOld(self.ui.Text_Biyao_Tip, function()
      return condInfo.isOk and "#368005" or "#000000"
    end)
    if self.biyaoTips then
      self.binder:SetText(self.ui.Text_Biyao_Tip, self.biyaoTips .. "  " .. condInfo.conditionStr)
    end
  end
  if self.extraCond then
    local condInfo = TaskDataUtils.GetConditionInfo(self.extraCond, self.taskCfg.ExtraCondPara, awakerList)
    self.isExtra = condInfo.isOk
    self.binder:BindToTextColorOld(self.ui.Text_Jiafen_Tip, function()
      return condInfo.isOk and "#368005" or "#000000"
    end)
    if self.extraTips then
      self.binder:SetText(self.ui.Text_Jiafen_Tip, self.extraTips .. "  " .. condInfo.conditionStr)
    end
  end
end

function TaskTeamDispatchItem:BtnItemClick()
  if self.clickCb then
    self.clickCb(self, self)
  end
end

return TaskTeamDispatchItem
