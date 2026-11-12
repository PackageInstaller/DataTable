local ActivityTaskCtrl_01 = class("ActivityTaskCtrl_01", BaseCtrl)
ActivityTaskCtrl_01._mapNodeConfig = {
  goTaskItem = {
    nCount = 7,
    sCtrlName = "Game.UI.Activity.ActivityTask.ActivityTaskItemCtrl_01"
  },
  btnItem = {
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  btnTask = {
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Task"
  },
  txtActivityTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Permanent_Time"
  }
}
ActivityTaskCtrl_01._mapEventConfig = {}

function ActivityTaskCtrl_01:RefreshTaskList()
  self.tbTaskList = {}
  self.tbRewardList = {}
  self.nGroupId = 0
  local tbTaskGroup, tbTaskList = self.actData:GetAllTaskList()
  for nGroupId, tbTask in pairs(tbTaskGroup) do
    self.nGroupId = nGroupId
    for _, nId in ipairs(tbTask) do
      local mapQuest = tbTaskList[nId]
      if mapQuest ~= nil then
        local mapData = {
          nId = nId,
          nStatus = mapQuest.nStatus,
          nExpire = mapQuest.nExpire,
          nCur = mapQuest.nCur,
          nMax = mapQuest.nMax
        }
        table.insert(self.tbTaskList, mapData)
      end
      local mapCfg = ConfigTable.GetData("ActivityTask", nId)
      if mapCfg ~= nil and mapCfg.Tid1 ~= 0 then
        table.insert(self.tbRewardList, mapCfg.Tid1)
      end
    end
  end
  table.sort(self.tbTaskList, function(a, b)
    return a.nId < b.nId
  end)
  for k, v in ipairs(self._mapNode.goTaskItem) do
    local mapQuestData = self.tbTaskList[k]
    v.gameObject:SetActive(mapQuestData ~= nil)
    if mapQuestData ~= nil then
      v:SetTaskItem(mapQuestData)
      if self._mapNode.btnItem[k] ~= nil then
        NovaAPI.SetRaycastTarget(self._mapNode.btnItem[k].gameObject, mapQuestData.nStatus ~= AllEnum.ActQuestStatus.Complete)
      end
    end
  end
end

function ActivityTaskCtrl_01:InitActData(actData)
  self.actData = actData
  self:RefreshTaskList()
end

function ActivityTaskCtrl_01:ClearActivity()
end

function ActivityTaskCtrl_01:Awake()
end

function ActivityTaskCtrl_01:OnEnable()
end

function ActivityTaskCtrl_01:OnDisable()
end

function ActivityTaskCtrl_01:OnDestroy()
end

function ActivityTaskCtrl_01:OnBtnClick_Detail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = mapActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function ActivityTaskCtrl_01:OnBtnClick_Item(btn, nIndex)
  if self.tbRewardList[nIndex] ~= nil then
    UTILS.ClickItemGridWithTips(self.tbRewardList[nIndex], btn.gameObject.transform, true, true, false)
  end
end

function ActivityTaskCtrl_01:OnBtnClick_Task(btn, nIndex)
  if self.tbTaskList ~= nil and self.tbTaskList[nIndex] ~= nil then
    local mapQuest = self.tbTaskList[nIndex]
    if mapQuest.nStatus == AllEnum.ActQuestStatus.Complete then
      local mapGroupCfg = ConfigTable.GetData("ActivityTaskGroup", self.nGroupId)
      if self.actData ~= nil and mapGroupCfg ~= nil then
        local function callback()
          self:RefreshTaskList()
          
          RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.actData:GetActId(), false)
        end
        
        self.actData:SendMsg_ActivityTaskRewardReceiveReq(self.nGroupId, mapQuest.nId, mapGroupCfg.TaskTabType, callback)
      end
    elseif mapQuest.nStatus == AllEnum.ActQuestStatus.UnComplete then
    end
  end
end

function ActivityTaskCtrl_01:OnEvent_RefreshActivityTask()
  self:RefreshTaskList()
end

return ActivityTaskCtrl_01
