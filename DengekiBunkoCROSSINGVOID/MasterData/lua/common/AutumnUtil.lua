local WU, DB, REF = require("Common/WindowUtil")()
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local TU = require("Common/TaskUtil")
local RU = require("Common/RedMarkUtil")
local DU = require("Common/DungeonUtil")
local ATU = {gachaTicketId = 60001, clawId = 61001}

function ATU.HasGoods(callbackTrue, callbackFalse)
  DB:GameRequest("fci/ClawCranePrize/"):Get(function(resp)
    local hasGoods = false
    if resp then
      DB:SetData("fci/ClawCranePrize/", resp)
      local info = resp.limitInfo
      for k, v in pairs(info) do
        if v.leftCount > 0 then
          hasGoods = true
          break
        end
      end
      DB:SetData("ClawCranePrize/hasGoods", hasGoods)
      if hasGoods then
        callbackTrue()
      else
        callbackFalse()
      end
    end
  end)
end

function ATU.GetActivitesByType(type)
  local activityList = DB:GetData("ActivityList")
  local activties = {}
  if activityList == nil then
    return
  end
  for k, v in ipairs(activityList) do
    if v.type == type and v.category == PB.enum.ActivityCategory.WeeklyActivity then
      table.insert(activties, v)
    end
  end
  table.sort(activties, function(a, b)
    return a.activityId < b.activityId
  end)
  DB:SetData("EventActivity/Activities", activties)
  return activties
end

function ATU.CheckTaskReward(taskInfo)
  if taskInfo[PB.enum.TaskCategory.Autumn] then
    local canReward = TU.TaskCanReward(taskInfo[PB.enum.TaskCategory.Autumn])
    RU.SetRedMark("Welfare/Autumn/AutumnTask", canReward)
  end
end

function ATU.AutumnActivityOpen(activityId)
  local activities = DB:GetData("EventActivity/Activities")
  local _, activity = table.find(activities, function(k, v)
    return v.activityId == activityId
  end)
  local isOpen = CS.GameTime.serverUtc >= activity.timestampStart
  local dateTime = CS.GameTime.UtcToLocal(activity.timestampStart)
  return isOpen, dateTime.Month, dateTime.Day
end

function ATU.MangeAutumnRedMark()
  local hasReward = false
  local rewardAcIds = {}
  local activties = {}
  local types = {
    PB.enum.ActivityType.EventDungeon_Autumn2018Hard,
    PB.enum.ActivityType.EventDungeon_Autumn2018
  }
  for key, val in pairs(types) do
    local acs = DB:GetData("ActivityList")
    for k, v in pairs(acs) do
      if v.type == val then
        table.insert(activties, v)
      end
    end
  end
  local info = DB:GetData("fci/event-dungeon/star-reward")
  if info == nil then
    return
  end
  for k, v in pairs(activties) do
    local flag = DU.DoesEventActivityHasStarReward(info.rewardSummary, v.activityId)
    if flag then
      RU.SetRedMark(string.format("Activity/%s/%s/Reward", v.type, v.activityId), flag)
      hasReward = true
    end
  end
  RU.SetRedMark("Welfare/Autumn/Dungeon", hasReward)
end

function ATU.GetPresent(resChange)
  local craneInfo = PB.all("ClawCrane")
  for k, v in pairs(resChange) do
    if v.baseRes and v.baseRes.countDelta > 0 then
      local _, crane = table.find(craneInfo, function(key, val)
        return val.res.id == v.baseRes.id
      end)
      if crane then
        return fif(crane.getAnim == nil, false, crane.getAnim)
      end
    end
  end
  return true
end

function ATU.CheckIsGachaTicket(resChange)
  local _, item = table.find(resChange, function(k, v)
    if v.baseRes and v.baseRes.countDelta > 0 then
      return v.baseRes.id == ATU.gachaTicketId
    end
  end)
  return item ~= nil
end

function ATU.GetAutumnClawCount(id)
  local craneInfo = PB.all("ClawCrane")
  local probaCount = PB.index("Misc", 1).clawCraneTotalProbability
  if id then
    local _, crane = table.find(craneInfo, function(k, v)
      return v.id == id
    end)
    local actualProbality = crane.probability / probaCount
    return actualProbality, probaCount
  end
  return probaCount
end

function ATU.UsedForAutumn(acType)
  if acType == PB.enum.ActivityType.EventDungeon_Autumn2018 or acType == PB.enum.ActivityType.EventDungeon_Autumn2018Hard or acType == PB.enum.ActivityType.EventDungeon then
    return true
  else
    return false
  end
end

return ATU
