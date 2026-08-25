local MAX_SIGN_COUNT = 7
local ActivityKarenSevenDaySignPanel, Super = System.NewClass("ActivityKarenSevenDaySignPanel", UIBasePanel)
ActivityKarenSevenDaySignPanel.uiResCls = UI_Event_Activity_SevenDaySignResource

function ActivityKarenSevenDaySignPanel:ctor(activityData, params)
  self.activityData = activityData
  self.params = params or {}
end

function ActivityKarenSevenDaySignPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:_RefreshSighItemList()
  self:_RefreshCountDown()
  binder:BindTimer(1, -1, System.fn(self, self._RefreshCountDown))
  if self.ui.Text_Title and self.params.title then
    self.binder:SetText(self.ui.Text_Title, self.params.title)
  end
  if self.ui.Text_Desc and self.params.desc then
    self.binder:SetText(self.ui.Text_Desc, self.params.desc)
  end
end

function ActivityKarenSevenDaySignPanel:_RefreshSighItemList()
  local taskDataList = self:_GetSignTaskDataList()
  for i = 1, MAX_SIGN_COUNT do
    local signItemUi = self.ui["Item_SignDa_" .. i]
    local taskData = taskDataList[i]
    local viewData = {
      taskData = taskData,
      idx = i,
      activityTid = self.activityData.activityTid
    }
    self.binder:BindComponent(ActivityKarenSevenDaySignItem(signItemUi, viewData))
  end
end

function ActivityKarenSevenDaySignPanel:_RefreshCountDown()
  ActivityUiUtils.RefreshActivityCountDown(self.binder, self.ui.Text_Time, self.activityData)
end

function ActivityKarenSevenDaySignPanel:_GetSignTaskDataList()
  local rst = ActivityKarenUtils.GetSignTaskDataList(self.activityData)
  table.sort(rst, function(a, b)
    local aSortId = TaskCfgUtils.GetCfgField("BaseSortID", a.tid)
    local bSortId = TaskCfgUtils.GetCfgField("BaseSortID", b.tid)
    return aSortId < bSortId
  end)
  return rst
end

return ActivityKarenSevenDaySignPanel
