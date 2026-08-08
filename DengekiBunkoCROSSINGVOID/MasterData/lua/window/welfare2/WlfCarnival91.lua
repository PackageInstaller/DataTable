local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")

function Start()
  WU.BindButtonEvent(REF.ButtonShop, function()
    this:SetData("EventActivityExchange/ShopId", 21)
    WU.AcquireWindowAsync("EventActivityExchange")
  end)
  WU.BindButtonEvent(REF.ButtonNormal, function()
    local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.Carnival91)
    if activities == nil then
      WU.ShowHintText(WU.GetString("Activity_DungeonIsNotUnlock"))
      return
    end
    local activityList = _ENV["!"](activities):where(function(k, v)
      return v.category == PB.enum.ActivityCategory.Dungeon
    end):toarray()
    if not ACU.IsOpenForDoing(activityList[1]) then
      WU.ShowHintText(WU.GetString("Activity_DungeonIsNotUnlock"))
      return
    end
    this:SetData("EventCarnival91Stage/Tab", 0)
    WU.AcquireWindowAsync("EventCarnival91Stage")
  end)
  WU.BindButtonEvent(REF.ButtonHard, function()
    local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.Carnival91)
    if activities == nil then
      WU.ShowHintText(WU.GetString("Activity_DungeonIsNotUnlock"))
      return
    end
    local activityList = _ENV["!"](activities):where(function(k, v)
      return v.category == PB.enum.ActivityCategory.Dungeon
    end):toarray()
    if not ACU.IsOpenForDoing(activityList[2]) then
      WU.ShowHintText(WU.GetString("Activity_DungeonIsNotUnlock"))
      return
    end
    this:SetData("EventCarnival91Stage/Tab", 1)
    WU.AcquireWindowAsync("EventCarnival91Stage")
  end)
end
