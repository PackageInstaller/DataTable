local base = ControllerBase
local ActivityShortTheatreCtrl = class("ActivityShortTheatreCtrl", base)
local ActivityShortTheatreData = require("Game.ActivityShortTheatre.Data.ActivityShortTheatreData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function ActivityShortTheatreCtrl:OnInit()
  self.__TaskChangeCallback = BindCallback(self, self.TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

function ActivityShortTheatreCtrl:InitCtrl(activityFrameData)
  if self._actData ~= nil then
    error("Cant support more limit ShortTheatre activity")
    return
  end
  local actId = activityFrameData:GetActId()
  self._actData = ActivityShortTheatreData.New()
  self._actData:InitShortTheatreData(actId)
  self._mainCfg = ConfigData.sign_theater_main[actId]
end

function ActivityShortTheatreCtrl:InitNetWrorkData(msgData)
  if msgData == nil then
    error("CS_ACTIVITY_SingleConcreteInfo 返回数据字段activitySignTheater为空")
    return
  end
  if msgData == nil then
    return
  end
  if self._actData == nil then
    return
  end
  self._actData:InitNetWrorkData(msgData)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.ShortTheatre)
  self:UpdActShortTheatreRedDot()
end

function ActivityShortTheatreCtrl:UpdateShortTheatre(msgData)
  if self._actData == nil then
    return
  end
  local actId = self._actData:GetActId()
  local data = msgData[1]
  if data == nil then
    return
  end
  self._actData:UpdateNetWorkData(data)
  local window = UIManager:GetWindow(UIWindowTypeID.EventPreciousCompany)
  if window ~= nil then
    window:RefreshLeftDay()
    window:RefreshTask()
  end
end

function ActivityShortTheatreCtrl:GetShortTheatreId()
  return self._actData:GetID()
end

function ActivityShortTheatreCtrl:GetActId()
  if self._actData == nil then
    return 0
  end
  return self._actData:GetActId()
end

function ActivityShortTheatreCtrl:GetCurData()
  return self._actData
end

function ActivityShortTheatreCtrl:GetShorTheatreMainCfg()
  return self._mainCfg
end

function ActivityShortTheatreCtrl:GetTotalStageId()
  if self._mainCfg == nil then
    return -1
  end
  return self._mainCfg.stage
end

function ActivityShortTheatreCtrl:GetCurStage()
  if self._actData == nil then
    return 0
  end
  local curStageData = self._actData:GetActCurStage()
  if curStageData ~= nil then
    return curStageData
  end
  return nil
end

function ActivityShortTheatreCtrl:CheckCanGetFinalReward()
  local stageData = self:GetCurStage()
  if stageData == nil then
    return false
  end
  if stageData.pickFinalReward == true then
    return false
  end
  if stageData.stageId == self:GetTotalStageId() then
    return true
  end
end

function ActivityShortTheatreCtrl:SendGetFinalRewardMsg(callback)
  if self.networkCtrl == nil then
    return
  end
  self.networkCtrl:CS_ActivitySignTheater_PickFinalReward(self:GetActId(), callback)
end

function ActivityShortTheatreCtrl:TaskProcessUpdate()
  self:UpdActShortTheatreRedDot()
end

function ActivityShortTheatreCtrl:UpdActShortTheatreRedDot()
  if self._actData == nil then
    return
  end
  local reddotNode = self._actData:GetActivityReddotNode()
  if reddotNode == nil then
    return
  end
  local showReddot = false
  local curStageData = self:GetCurStage()
  if curStageData ~= nil then
    local tasks = curStageData.curQuests
    for k, v in pairs(tasks) do
      local taskData = PlayerDataCenter.allTaskData.taskDatas[v.questId]
      if taskData ~= nil and taskData:CheckComplete() then
        showReddot = true
        break
      end
    end
  end
  if showReddot == false then
    showReddot = self:CheckCanGetFinalReward()
  end
  reddotNode:SetRedDotCount(showReddot and 1 or 0)
end

function ActivityShortTheatreCtrl:CloseActLimitTaskCtrl(activityFrameData)
  if UIManager:GetWindow(UIWindowTypeID.SignInMiniGame) ~= nil then
    UIUtil.ReturnHome()
  end
  self:Delete()
end

function ActivityShortTheatreCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

return ActivityShortTheatreCtrl
