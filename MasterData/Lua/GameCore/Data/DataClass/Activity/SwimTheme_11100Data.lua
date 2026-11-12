local ActivityGroupDataBase = require("GameCore.Data.DataClass.Activity.ActivityGroupDataBase")
local SwimTheme_11100Data = class("SwimTheme_11100Data", ActivityGroupDataBase)

function SwimTheme_11100Data:Init()
  self.tbAllActivity = {}
  self.nCGActivityId = 0
  self.sCGPath = ""
  self.bPlayedCG = false
  self:ParseActivity()
end

function SwimTheme_11100Data:ParseActivity()
  if self.actGroupConfig == nil then
    self.actGroupConfig = ConfigTable.GetData("ActivityGroup", self.nActGroupId)
  end
  local sJson = self.actGroupConfig.Enter
  local tbJson = decodeJson(sJson)
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
    self.nCGActivityId = tonumber(tbCGJson[1])
    self.sCGPath = tbCGJson[2]
  end
end

function SwimTheme_11100Data:GetActivityDataByIndex(nIndex)
  for _, activity in pairs(self.tbAllActivity) do
    if activity.Index == nIndex then
      return activity
    end
  end
end

function SwimTheme_11100Data:PlayCG()
  self:SendMsg_CG_READ(self.nCGActivityId)
end

function SwimTheme_11100Data:GetActivityGroupCGPlayed()
  if self.bPlayedCG then
    return true
  end
  return PlayerData.Activity:IsCGPlayed(self.nCGActivityId)
end

function SwimTheme_11100Data:IsActivityInActivityGroup(nActivityId)
  for _, activity in pairs(self.tbAllActivity) do
    if activity.ActivityId == nActivityId then
      return true, self.nActGroupId
    end
  end
  return false
end

function SwimTheme_11100Data:SendMsg_CG_READ(nActivityId)
  local function Callback()
    self.bPlayedCG = true
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_cg_read_req, {nActivityId}, nil, Callback)
end

return SwimTheme_11100Data
