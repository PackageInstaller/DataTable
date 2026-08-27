local base = require("Game.ActivityFrame.ActivityBase")
local ActivitySkinLimitData = class("ActivitySkinLimitData", base)
local ActivitySkinLimitEnum = require("Game.ActivitySkinLimit.Data.ActivitySkinLimitEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.SkinLimit

function ActivitySkinLimitData:InitSkinLimitData(msg)
  self._actId = msg.actId
  self:SetActFrameDataByType(CurActType, self._actId)
  self._mainCfg = ConfigData.activity_skinlimit_main[self._actId]
  self._skinList = ConfigData.activity_skinlimit_skin[self._actId]
  self._posList = {}
  self:UpdateSkinLimitShow()
end

function ActivitySkinLimitData:UpdateSkinLimitShow()
  self:__RefreshSkinLimitRedDotLooked()
  self:__RefreshSkinLimitRedHasTask()
end

function ActivitySkinLimitData:__RefreshSkinLimitRedHasTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySkinLimitEnum.eRedDotType.Task)
  local isCanGet = self:IsCanGetTask()
  local flag = isCanGet
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySkinLimitData:__RefreshSkinLimitRedDotLooked()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySkinLimitEnum.eRedDotType.Looked)
  local flag = not self:GetSkinLimitLooked()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySkinLimitData:SetSkinLimitLooked()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetSkinLimitLooked(self:GetActId())
  self:UpdateSkinLimitShow()
end

function ActivitySkinLimitData:GetSkinLimitMainCfg()
  return self._mainCfg
end

function ActivitySkinLimitData:GetSkinLimitActvityName()
  return self._mainCfg and self._mainCfg.name
end

function ActivitySkinLimitData:GetSkinLimitStartTime()
  local timeStr = self._mainCfg.start_time
  return self:GetSkinLimitTimeStr(timeStr)
end

function ActivitySkinLimitData:GetSkinLimitEndTime()
  local timeStr = self._mainCfg.end_time
  return self:GetSkinLimitTimeStr(timeStr)
end

function ActivitySkinLimitData:GetSkinLimitTimeStr(timeStr)
  local _, _, y, m, d, hour, min, sec = string.find(timeStr, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
  return m .. "/" .. d, hour .. ":" .. min
end

function ActivitySkinLimitData:GetSkinLimitActivityTip()
  return self._mainCfg.activity_rule
end

function ActivitySkinLimitData:GetSkinLimitSkinList()
  return self._skinList
end

function ActivitySkinLimitData:GetSkinDataPosList(id)
  if self._posList[id] == nil then
    local data = self._skinList[id]
    if data == nil then
      return nil
    end
    self._posList[id] = {}
    local posXList, posYList = CommonUtil.SplitStrToDoubleNumber(data.BG_pos, "|", "_")
    self._posList[id].bgPosX = posXList[1]
    self._posList[id].bgPosY = posYList[1]
    self._posList[id].live2dPosX = posXList[2]
    self._posList[id].live2dPosY = posYList[2]
  end
  return self._posList[id]
end

function ActivitySkinLimitData:GetSkinLimitLooked()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return saveUserData:GetSkinLimitLooked(self:GetActId())
end

function ActivitySkinLimitData:IsCanGetTask()
  local isCanGet = false
  local taskIds = ConfigData.activity_general[self:GetActFrameId()].once_quest
  for _, taskId in pairs(taskIds) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    isCanGet = isCanGet or taskData:CheckComplete()
    if isCanGet then
      break
    end
  end
  return isCanGet
end

return ActivitySkinLimitData
