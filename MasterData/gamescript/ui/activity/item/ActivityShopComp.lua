local MAX_TOGGLE_NUM = 4
local ActivityShopComp, Super = System.NewClass("ActivityShopComp", ActivityBaseComp)

function ActivityShopComp:ctor(res, activityTid, activityModel)
  Super.ctor(self, res, activityTid, activityModel)
  self.ui = UI_Events_Panel_Back_To_SchoolResource(res)
  self.activityTid = activityTid
  self.activityModel = activityModel
  self.activityData = self.activityModel:GetActivityDataClient(activityTid)
end

function ActivityShopComp:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(ActivityShopModel, self.activityTid, self.activityData)
  binder:SetText(self.ui.Text_Title, LT.Text(ActivityDataUtils.GetConfigByField("ActivityName", self.model.activityTid)))
  binder:BindToImageSync(self.ui.Image_Map, System.fn(self, self._GetBgImage))
  self:_BindActivityTimer()
  self:_BindPortraitComp()
  self:_OnBindShopEntry(binder)
  self:_OnBindTaskGroup(binder)
  self:_OnBindToggleGroup(binder)
end

function ActivityShopComp:_GetBgImage()
  do return ActivityDataUtils.GetBgImage end
  return ActivityDataUtils.GetBgImage, self.activityTid
end

function ActivityShopComp:_OnBindShopEntry(binder)
  local showCurrencyTid = self.model.shopTypeCfg.ShowMoney and self.model.shopTypeCfg.ShowMoney[1]
  if not showCurrencyTid then
    self.ui.Btn_Shop:SetActive(false)
    return
  end
  self.ui.Btn_Shop:SetActive(true)
  binder:SetImage(self.ui.Image_Currency_01, ItemDataUtils.GetItemIcon(showCurrencyTid))
  binder:BindToText(self.ui.Text_Currency_01, function()
    do return LT.Text, ItemDataUtils.GetItemNum(showCurrencyTid) end
    return LT.Text, ItemDataUtils.GetItemNum(showCurrencyTid)
  end)
  binder:BindComponent(UICompRedDotNewVue(self.ui.Red_Shop, RedDotDefine.DynamicRedDotID.ActivityShopEntry, {
    activityTid = self.model.activityTid
  }))
  binder:BindZ1Button(self.ui.Btn_Shop, function()
    ShopController.Instance:OpenActivityShopView(self.model.activityTid)
  end)
end

function ActivityShopComp:_OnBindTaskGroup(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Task, function()
    return self.model.showingTaskGroup
  end, function(cBinder, go, index)
    local taskData = self.model.showingTaskGroup[index]
    cBinder:BindComponent(ActivityTaskItem(go, taskData, self.model.activityData))
  end)
  binder:BindToRaw(function()
    local isLock = self:_CheckTaskGroupIsLock(self.model.selectGroupIdx)
    self.ui.Image_Null:SetActive(isLock)
    self.ui.ScrollView_Task:SetActive(not isLock)
    self:_ClearTaskCountDownTimer()
    if isLock then
      self:_BindTaskCountDownTimer(self.model.selectGroupIdx)
    end
  end, function()
    return self.model.selectGroupIdx
  end)
end

function ActivityShopComp:_ClearTaskCountDownTimer()
  if self.taskTimer then
    self.binder:StopTimer(self.taskTimer)
    self.taskTimer = nil
  end
end

function ActivityShopComp:_BindTaskCountDownTimer(selectGroupIdx)
  self.binder:SetText(self.ui.Text_Task_Time, self:_GetCountDownShow(selectGroupIdx))
  self.taskTimer = self.binder:BindTimer(1, -1, function()
    self.binder:SetText(self.ui.Text_Task_Time, self:_GetCountDownShow(selectGroupIdx))
  end)
end

function ActivityShopComp:_OnBindToggleGroup(binder)
  for idx = 1, MAX_TOGGLE_NUM do
    local toggleObj = self.ui["Btn_" .. idx]
    local taskGroupTid = self.model:GetTaskGroupByFieldIdx("tid", idx)
    if not taskGroupTid then
      toggleObj:SetActive(false)
    else
      toggleObj:SetActive(true)
      binder:BindToZ1Toggle(toggleObj, nil, function(isOn)
        if isOn then
          self.model:Set_selectGroupIdx(idx)
        end
      end)
      local descTxt = TaskDataUtils.GetConfigByField("Desc", taskGroupTid)
      local txtNormalObj = self.ui["Text_" .. idx .. "_Normal"]
      local txtSelectObj = self.ui["Text_" .. idx .. "_Select"]
      binder:SetText(txtNormalObj, LT.Text(descTxt))
      binder:SetText(txtSelectObj, LT.Text(descTxt))
      local imgLockNormalObj = self.ui["Image_Lock_Normal_" .. idx]
      local imgLockSelectObj = self.ui["Image_Lock_Select_" .. idx]
      binder:BindToVisible(imgLockNormalObj, System.bind(self._CheckTaskGroupIsLock, self, idx))
      binder:BindToVisible(imgLockSelectObj, System.bind(self._CheckTaskGroupIsLock, self, idx))
      if self:_CheckTaskGroupIsLock(idx) then
        self.binder:SetActive(self.ui["Com_RedDot_" .. idx], false)
      else
        self.binder:SetActive(self.ui["Com_RedDot_" .. idx], true)
        local taskTidList = {}
        local taskGroupData = self.model:GetTaskGroupByIdx(idx)
        local taskDataMap = taskGroupData.taskDataMap
        for _, taskData in pairs(taskDataMap) do
          table.insert(taskTidList, taskData.tid)
        end
        self.binder:BindComponent(UICompRedDotNewVue(self.ui["Com_RedDot_" .. idx], RedDotDefine.DynamicRedDotID.ActivityTaskListGroupEntry, {
          taskGroupTid = taskGroupTid,
          taskTidList = taskTidList,
          activityTid = self.model.activityTid
        }))
      end
    end
  end
end

function ActivityShopComp:_CheckTaskGroupIsLock(idx)
  local now = TimeUtils.GetServerTime()
  local openTs = self.model:GetTaskGroupByFieldIdx("openTs", idx)
  if not openTs or 0 == openTs then
    return false
  end
  return now < openTs
end

function ActivityShopComp:_GetCountDownShow(idx)
  local openTs = self.model:GetTaskGroupByFieldIdx("openTs", idx)
  local now = TimeUtils.GetServerTime()
  local countDown = openTs - now
  if countDown < 0 then
    return ""
  end
  local d, h, m = TimeUtils.ConvertTime(countDown)
  do return LT.Textf, "ActivityTaskGroupOpenCountDownFormat", d, h end
  return LT.Textf, "ActivityTaskGroupOpenCountDownFormat", d, h, m
end

function ActivityShopComp:OnUnbind()
  self:_ClearTaskCountDownTimer()
end

return ActivityShopComp
