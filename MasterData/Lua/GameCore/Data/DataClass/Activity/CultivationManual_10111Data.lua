local ActivityGroupDataBase = require("GameCore.Data.DataClass.Activity.ActivityGroupDataBase")
local LocalData = require("GameCore.Data.LocalData")
local CultivationManual_10111Data = class("CultivationManual_10111Data", ActivityGroupDataBase)

function CultivationManual_10111Data:Init()
  self.tbAllActivity = {}
  self.nCGActivityId = 0
  self.sCGPath = ""
  self.bPlayedCG = false
  self:ParseActivity()
end

function CultivationManual_10111Data:ParseActivity()
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

function CultivationManual_10111Data:GetActivityDataByIndex(nIndex)
  for _, activity in pairs(self.tbAllActivity) do
    if activity.Index == nIndex then
      return activity
    end
  end
end

function CultivationManual_10111Data:PlayCG()
  self:SendMsg_CG_READ(self.nCGActivityId)
end

function CultivationManual_10111Data:GetActivityGroupCGPlayed()
  if self.bPlayedCG then
    return true
  end
  return PlayerData.Activity:IsCGPlayed(self.nCGActivityId)
end

function CultivationManual_10111Data:IsActivityInActivityGroup(nActivityId)
  for _, activity in pairs(self.tbAllActivity) do
    if activity.ActivityId == nActivityId then
      return true, self.nActGroupId
    end
  end
  return false
end

function CultivationManual_10111Data:OnOpenMiniGameEntrance(actData)
  LocalData.SetPlayerLocalData("Activity_MiniGame_10111_New", true)
  RedDotManager.SetValid(RedDotDefine.Activity_GroupNew_MiniGame, {
    actData.ActivityId
  }, false)
end

function CultivationManual_10111Data:SendMsg_CG_READ(nActivityId)
  local function Callback()
    self.bPlayedCG = true
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_cg_read_req, {nActivityId}, nil, Callback)
end

return CultivationManual_10111Data
