local ActivityGroupDataBase = require("GameCore.Data.DataClass.Activity.ActivityGroupDataBase")
local GunStorm_10109Data = class("GunStorm_10109Data", ActivityGroupDataBase)

function GunStorm_10109Data:Init()
  self.tbAllActivity = {}
  self.nCGActivityId = 0
  self.sCGPath = ""
  self.bPlayedCG = false
  self:ParseActivity()
end

function GunStorm_10109Data:ParseActivity()
  if self.actGroupConfig == nil then
    self.actGroupConfig = ConfigTable.GetData("ActivityGroup", self.nActGroupId)
  end
  if self.actGroupConfig == nil then
    printError("ActivityGroup config not found for id: " .. tostring(self.nActGroupId))
    return
  end
  local sJson = self.actGroupConfig.Enter
  local tbJson = decodeJson(sJson)
  if tbJson == nil then
    printError("ActivityGroup Enter json is nil for id: " .. tostring(self.nActGroupId))
  end
  for _, activity in pairs(tbJson) do
    local data = {
      ActivityId = activity[1],
      Index = activity[2],
      PanelId = activity[3]
    }
    table.insert(self.tbAllActivity, data)
  end
  local sCgJson = self.actGroupConfig.CG
  if sCgJson ~= nil then
    local tbCGJson = decodeJson(sCgJson)
    if tbCGJson and 2 <= #tbCGJson then
      self.nCGActivityId = tonumber(tbCGJson[1])
      self.sCGPath = tbCGJson[2]
    end
  end
end

function GunStorm_10109Data:GetActivityDataByIndex(nIndex)
  for _, activity in pairs(self.tbAllActivity) do
    if activity.Index == nIndex then
      return activity
    end
  end
end

function GunStorm_10109Data:PlayCG()
  self:SendMsg_CG_READ(self.nCGActivityId)
end

function GunStorm_10109Data:GetActivityGroupCGPlayed()
  if self.bPlayedCG then
    return true
  end
  return PlayerData.Activity:IsCGPlayed(self.nCGActivityId)
end

function GunStorm_10109Data:IsActivityInActivityGroup(nActivityId)
  for _, activity in pairs(self.tbAllActivity) do
    if activity.ActivityId == nActivityId then
      return true, self.nActGroupId
    end
  end
  return false
end

function GunStorm_10109Data:SendMsg_CG_READ(nActivityId)
  local function Callback()
    self.bPlayedCG = true
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_cg_read_req, {nActivityId}, nil, Callback)
end

return GunStorm_10109Data
