local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local DU = require("Common/DungeonUtil")
local NU = require("Common/NotepadUtil")
local U = require("Common/Util")
local m_gachaId = 2
local m_gachaDetail, m_activity, m_activityId, m_bClosed, m_bLoseFocus, m_srcBGMusic

function InitWindow()
  this:BindRemote(DB:GameRequest("fci/gachainfo/"), OnGachaInfoChanged)
  this:Bind("ActivityList", OnActivityChanged)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  REF.WidgetGachaInsertCoin["$SetGachaId"](m_gachaId)
  REF.WidgetGachaInsertCoin["$SetGachaClickCallback"](function(times)
    if not DU.IsWaitingForJob(function()
      DoGacha(times)
    end) then
      DoGacha(times)
    end
  end)
  REF.GachaActivitySelection["$SetToggleCallback"](function(activityInfo)
    SetStatus(activityInfo)
  end)
  WU.BindButtonEvent(REF.ButtonPlay, function()
    local data = this:GetData("fci/gacha-plot-emote/")
    if data then
      local url = data.actorVideoUrl
      WU.OpenUrl(url)
    end
  end)
end

function UninitWindow()
  CS.SoundManager.Instance:PlayMusic(m_srcBGMusic)
end

function SetupWindow()
  m_srcBGMusic = CS.SoundManager.Instance:GetCurrentMusic()
  WU.BindButtonEvent(REF.ButtonActorCollections, function()
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey) then
      NU.GetCollectionsActor(function()
        WU.AcquireWindowAsync("CollectionsActor")
      end)
    end
  end)
end

function OnGachaInfoChanged(gachaInfo)
  if gachaInfo then
    local _, gacha = _ENV["!"](gachaInfo):find(function(k, v)
      return v.id == m_gachaId
    end)
    m_gachaDetail = gacha
    OnActivityChanged()
  end
end

function OnActivityChanged(activityList)
  local activities = _ENV["!"](this:GetData("ActivityList")):where(function(k, v)
    if v.type == PB.enum.ActivityType.Gacha then
      return ACU.IsOpenForDoing(v)
    end
  end)
  activities = activities or {}
  local activityInfo = _ENV["!"](m_gachaDetail.activityInfo)
  for _, a in pairs(activities) do
    local _, temp = activityInfo:find(function(k, v)
      return v.activityId == a.activityId
    end)
    if temp == nil then
      table.insert(activityInfo, {
        activityId = a.activityId,
        curDropActivityActor = 0,
        preDropActivityActor = 0,
        getActivityActorCount = 0,
        nextGetPurpleCount = PB.get("GachaType", m_gachaDetail.id).actorDropCount
      })
    end
  end
  SetActivity()
end

function SetActivity()
  local activities = m_gachaDetail.activityInfo
  table.sort(activities, function(a, b)
    if a.activityId == 0 then
      return false
    end
    if b.activityId == 0 then
      return true
    end
    return a.activityId < b.activityId
  end)
  local selectedActivityId = this:GetData("gacha/" .. m_gachaId .. "/SelectedActivityId") or 1
  local jumpActivityId = this:GetData("GachaJumpId")
  if jumpActivityId and jumpActivityId ~= 0 then
    local index, _ = table.find(activities, function(k, v)
      return v.activityId == jumpActivityId
    end)
    this:SetData("GachaJumpId", nil)
    if index then
      selectedActivityId = index
      this:SetData("gacha/" .. m_gachaId .. "/SelectedActivityId", index)
    end
  end
  if this:GetData("CurrentTutorial") == 5 then
    selectedActivityId = #activities
  end
  SetStatus(activities[selectedActivityId])
  REF.GachaActivitySelection["$SetView"](activities, m_gachaDetail)
  REF.WidgetGachaInsertCoin["$SetActivity"](activities[selectedActivityId])
end

function OnActivityStatusChanged(category, activityId, status, type, activity)
  if type == PB.enum.ActivityType.Gacha then
    local activityInfo = _ENV["!"](m_gachaDetail.activityInfo)
    local opened = ACU.IsOpenForDoing(activity)
    local i, a = activityInfo:find(function(k, v)
      return v.activityId == activityId
    end)
    if opened then
      if a == nil then
        table.insert(activityInfo, {
          activityId = activityId,
          curDropActivityActor = 0,
          preDropActivityActor = 0,
          getActivityActorCount = 0,
          nextGetPurpleCount = PB.get("GachaType", m_gachaDetail.id).actorDropCount
        })
      end
    elseif i ~= nil then
      table.remove(activityInfo, i)
    end
    SetActivity()
  end
end

function Focus(on)
  m_bLoseFocus = not on
  if on and m_bClosed then
    WU.RecycleWindow(this)
  end
  WU.RecordWindowFocus(100114, on)
end

function SetStatus(activity)
  m_bClosed = false
  if activity then
    REF.WidgetGachaInsertCoin["$SetActivity"](activity)
    m_activity = activity
    if m_activity ~= nil and m_activityId ~= m_activity.activityId then
      m_activityId = m_activity.activityId
      WU.RemoveAllChild(REF.NodeEffect)
      local ad = PB.get("GachaAd", m_activity.activityId)
      if ad == nil then
        error("Gacha", "no bg effect prefab for gacha activityId " .. m_activity.activityId)
      else
        if ad.musicID and ad.musicID ~= "" then
          CS.SoundManager.Instance:PlayMusic(ad.musicID)
        else
          CS.SoundManager.Instance:PlayMusic(m_srcBGMusic)
        end
        do
          local obj = WU.InstantiateWindowPrefab(REF.NodeEffect, ad.displayName)
          SetActorButtons()
          WU.HandleGameObjectAttached(obj)
          this:DelayInvokeInSeconds(0.01, function()
            local refObj = _ENV["$"](obj)
            if refObj.WidgetTwoBoardActor then
              for i, v in ipairs(ad.emoteId) do
                refObj.WidgetTwoBoardActor["$PlayByActorID"](v, i, "GachaPeriodic")
              end
            end
          end)
        end
      end
    end
  elseif m_bLoseFocus == false then
    WU.RecycleWindow(this)
  else
    m_bClosed = true
  end
end

function DoGacha(times)
  S:Get("Gacha").DoGacha(m_gachaDetail, {
    times = times,
    activityId = m_activityId,
    cinematic = "ATM",
    showContinue = false
  })
end

function SetActorButtons()
  local ad = PB.get("GachaAd", m_activityId)
  local ids = {}
  local ref = reRef(REF.NodeEffect)
  WU.TraverseChildren(ref.RoleButtons, function(go)
    local name = go.name
    if string.sub(name, 1, 4) == "Role" then
      local id = U.ToInt(string.sub(name, string.len("Role") + 2, string.len(name)))
      WU.BindButtonEvent(go, function()
        if not WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey) then
          NU.GetCollectionsActor(function(actors)
            local actor = {}
            for k, v in pairs(actors) do
              if v.id == id then
                actor = v
                break
              end
            end
            WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
              _ENV["$"](w)["$$SetActor"](actor)
            end)
          end)
        end
      end)
    end
  end)
end
