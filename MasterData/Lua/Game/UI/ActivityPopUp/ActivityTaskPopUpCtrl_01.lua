local ActivityTaskPopUpCtrl_01 = class("ActivityTaskPopUpCtrl_01", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
ActivityTaskPopUpCtrl_01._mapNodeConfig = {
  imgActivity = {sComponentName = "Image"},
  goTaskList = {},
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
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "LoginReward_PopUp_Tip"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  txtActivityTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Permanent_Time"
  }
}
ActivityTaskPopUpCtrl_01._mapEventConfig = {
  RefreshActivityTask = "OnEvent_RefreshActivityTask"
}
ActivityTaskPopUpCtrl_01._mapRedDotConfig = {}

function ActivityTaskPopUpCtrl_01:ShowPopUp(actId, callback, index)
  self.popUpIndex = index
  self.nCurActId = actId
  self.callback = callback
  self.actData = PlayerData.Activity:GetActivityDataById(self.nCurActId)
  self:RefreshTaskList()
  self.anim = self.gameObject:GetComponent("Animator")
  self:PlayOpenAnim()
end

function ActivityTaskPopUpCtrl_01:RefreshTaskList()
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

function ActivityTaskPopUpCtrl_01:PlayOpenAnim()
  if self.animRoot ~= nil then
    local nAnimLength = NovaAPI.GetAnimClipLength(self.animRoot, {
      "ActivityContent_2_in"
    })
    self.animRoot:Play("ActivityContent_2_in")
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
  end
end

function ActivityTaskPopUpCtrl_01:Close()
  if self.callback ~= nil then
    if self.anim then
      local nAnimLength = NovaAPI.GetAnimClipLength(self.anim, {
        "ActivityTask_01_out"
      })
      self.anim:Play("ActivityTask_01_out")
      EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
      self:AddTimer(1, nAnimLength, function()
        self.callback()
      end, true, true, true)
    else
      self.callback()
    end
  end
end

function ActivityTaskPopUpCtrl_01:Awake()
end

function ActivityTaskPopUpCtrl_01:OnEnable()
end

function ActivityTaskPopUpCtrl_01:OnDisable()
end

function ActivityTaskPopUpCtrl_01:OnDestroy()
end

function ActivityTaskPopUpCtrl_01:OnBtnClick_Item(btn, nIndex)
  if self.tbRewardList[nIndex] ~= nil then
    UTILS.ClickItemGridWithTips(self.tbRewardList[nIndex], btn.gameObject.transform, true, true, false)
  end
end

function ActivityTaskPopUpCtrl_01:OnBtnClick_Task(btn, nIndex)
  if self.tbTaskList ~= nil and self.tbTaskList[nIndex] ~= nil then
    local mapQuest = self.tbTaskList[nIndex]
    if mapQuest.nStatus == AllEnum.ActQuestStatus.Complete then
      local mapGroupCfg = ConfigTable.GetData("ActivityTaskGroup", self.nGroupId)
      if self.actData ~= nil and mapGroupCfg ~= nil then
        local function callback()
          self:RefreshTaskList()
          
          RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nCurActId, false)
        end
        
        self.actData:SendMsg_ActivityTaskRewardReceiveReq(self.nGroupId, mapQuest.nId, mapGroupCfg.TaskTabType, callback)
      end
    elseif mapQuest.nStatus == AllEnum.ActQuestStatus.UnComplete then
    end
  end
end

function ActivityTaskPopUpCtrl_01:OnBtnClick_Receive()
  local bCanReceive = false
  for _, v in ipairs(self.tbTaskList) do
    if v.nStatus == AllEnum.ActQuestStatus.Complete then
      bCanReceive = true
      break
    end
  end
  if bCanReceive then
    local mapGroupCfg = ConfigTable.GetData("ActivityTaskGroup", self.nGroupId)
    if self.actData ~= nil and mapGroupCfg ~= nil then
      local function callback()
        self:RefreshTaskList()
        
        RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nCurActId, false)
        self:Close()
      end
      
      self.actData:SendMsg_ActivityTaskRewardReceiveReq(self.nGroupId, 0, mapGroupCfg.TaskTabType, callback)
    end
  else
    self:Close()
  end
end

function ActivityTaskPopUpCtrl_01:OnEvent_RefreshActivityTask()
  self:RefreshTaskList()
end

return ActivityTaskPopUpCtrl_01
