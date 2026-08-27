local base = require("Game.Common.Activity.Lobby.ActLobbyCtrlBase")
local ActivitySpring24Controller = class("ActivitySpring24Controller", base)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivitySpring24Data = require("Game.ActivitySpring24.Data.ActivitySpring24Data")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local cs_MessageCommon = CS.MessageCommon
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function ActivitySpring24Controller:OnInit()
  base.OnInit(self)
  self.netCtrl = NetworkManager:GetNetwork(NetworkTypeID.Spring24)
  self.OnReceiveTreasureDigCallback = BindCallback(self, self.OnReceiveTreasureDig)
end

function ActivitySpring24Controller:NewActData()
  local data = ActivitySpring24Data.New()
  return data
end

function ActivitySpring24Controller:LoadAllCfg()
  ConfigData:LoadDynCfg(eDynConfigData.activity_treasurehunt_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_treasurehunt_treasure_detail)
  ConfigData:LoadDynCfg(eDynConfigData.activity_treasurehunt_story)
end

function ActivitySpring24Controller:LoadAllListener()
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

function ActivitySpring24Controller:UnLoadAllCfg()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_treasurehunt_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_treasurehunt_treasure_detail)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_treasurehunt_story)
end

function ActivitySpring24Controller:UnLoadAllListener()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

function ActivitySpring24Controller:GetSpring24NetCtrl()
  return self.netCtrl
end

function ActivitySpring24Controller:SendDigReward(objId, actData)
  local treasureData = actData:GetTreasureData()
  local isShow = treasureData:GetEntObjIdIsShow(objId)
  if not isShow then
    return
  end
  local netCtrl = self:GetSpring24NetCtrl()
  local treasureId = treasureData:TransEntObjId2TreasureId(objId)
  netCtrl:CS_ActTreasureHunt_Dig(actData:GetActId(), treasureId, self.OnReceiveTreasureDigCallback)
end

function ActivitySpring24Controller:OnReceiveTreasureDig(args)
  if args.Count == 0 then
    error("args.Count == 0")
    return
  end
  local msg = args[0]
  local rewardDic = msg.rewards
  local rewardIds = {}
  local rewardNums = {}
  for id, data in pairs(rewardDic) do
    table.insert(rewardIds, id)
    table.insert(rewardNums, data)
  end
  self:UpdateActData(msg.actData)
  local actData = self:GetActDataByActId(msg.actData.actId)
  local isHaveAvg, avgId = actData:CheckAndGetPlayAvg()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRShowOverFunc(function()
      if not isHaveAvg then
        return
      end
      local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
      avgCtrl:StartAvg(nil, avgId, nil)
    end)
    window:AddAndTryShowReward(CRData)
  end)
  self:DoDailyFlush(msg.actData.actId)
end

function ActivitySpring24Controller:DoDailyFlush(actId)
  local actData = self:GetActDataByActId(actId)
  ActLbUtil.UpdLbCurInteractEntShow(actData:GetActFrameId())
  ActLbUtil.UpdLbCurInteractList()
  ActLbUtil.UpdLbCurFollowInfoShow()
  self:TryOpenNotice(actData)
end

function ActivitySpring24Controller:TryOpenNotice(actData)
  local lbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if lbCtrl == nil or lbCtrl:GetActLbActId() ~= actData:GetActFrameId() then
    return
  end
  if actData:CheckPopNeed() then
    UIManager:ShowWindowAsync(UIWindowTypeID.UISpring24Notice, function(win)
      if win == nil then
        return
      end
      win:InitSpring24Notice(actData)
    end)
  end
end

function ActivitySpring24Controller:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local dailyTaskData = data:GetSpring24DailyTaskData()
    if dailyTaskData ~= nil and dailyTaskData:IsExitInDailyTask(taskData.id) then
      data:RefreshRedSpring24DailyTask()
    else
      local termTaskData = data:GetSpring24TermTaskData()
      if termTaskData:IsExitInTermTask(taskData.id) then
        data:RefreshRedSpring24OnceTask()
      else
      end
    end
  end
end

function ActivitySpring24Controller:OnDelete()
  base.OnDelete(self)
end

return ActivitySpring24Controller
