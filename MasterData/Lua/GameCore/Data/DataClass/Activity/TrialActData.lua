local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local TrialActData = class("TrialActData", ActivityDataBase)
local LocalData = require("GameCore.Data.LocalData")

function TrialActData:Init()
  self.mapTrialActCfg = nil
  self.tbCompleteGroupId = {}
  self:ParseConfig()
end

function TrialActData:ParseConfig()
  local mapCfg = ConfigTable.GetData("TrialControl", self.nActId)
  if not mapCfg then
    return
  end
  self.mapTrialActCfg = mapCfg
end

function TrialActData:GetTrialControlCfg()
  return self.mapTrialActCfg
end

function TrialActData:RefreshTrialActData(msgData)
  self.tbCompleteGroupId = msgData.CompletedGroupIds
end

function TrialActData:CheckGroupReceived(nGroupId)
  return table.indexof(self.tbCompleteGroupId, nGroupId) > 0
end

function TrialActData:GetNextUnreceiveGroup()
  local tbGroup = self.mapTrialActCfg.GroupIds
  for _, v in ipairs(tbGroup) do
    local bReceived = self:CheckGroupReceived(v)
    if not bReceived then
      return v
    end
  end
end

function TrialActData:SendActivityTrialRewardReceiveReq(nGroupId, callback)
  if self:CheckGroupReceived(nGroupId) then
    printError("试玩奖励已领取过" .. nGroupId)
    callback()
    return
  end
  local msgData = {
    ActivityId = self.nActId,
    GroupId = nGroupId
  }
  
  local function successCallback(_, mapMainData)
    table.insert(self.tbCompleteGroupId, nGroupId)
    if callback then
      callback(mapMainData)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_trial_reward_receive_req, msgData, nil, successCallback)
end

return TrialActData
