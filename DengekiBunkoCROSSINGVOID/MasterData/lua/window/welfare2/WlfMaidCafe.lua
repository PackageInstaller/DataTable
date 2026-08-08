local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_RankEndTime, m_NextTime, m_Invoke, m_RankCloseTime

function Start()
  WU.BindButtonEvent(REF.TreasureHouse, OnClickTreasure)
  WU.BindButtonEvent(REF.OrdinaryDungeon, OnClickOrdinaryDungeon)
  WU.BindButtonEvent(REF.RankDungeon, OnClickRankDungeon)
  WU.BindButtonEvent(REF.MiniGame, OnClickMiniGame)
  WU.BindButtonEvent(REF.Ranks, OnClickRank)
end

function OnEnable()
  RU.BindRedMark(this, "Welfare/MaidCafe_DaemonMode/Reward", function(flag)
    WU.SetActive(REF.SpriteOrdinaryRed, flag)
  end)
  RU.BindRedMark(this, "Welfare/MaidCafe/PassCountReward", function(flag)
    WU.SetActive(REF.SpriteRankRed, flag)
  end)
  RU.SetRedMark("Welfare/MaidCafe/First", false)
  WU.RecordFirstTimeInClient("WelfareMaidCafe")
  this:Bind("fci/maidcafe/rank-mode", OnRankInfoChanged)
  local info = this:GetData("fci/maidcafe/rank-mode")
  if info and info.unlocked == false and this:GetData("fci/baseinfo").level >= 30 then
    DB:SyncRemote(DB:GameRequest("fci/maidcafe/rank-mode"))
  end
  m_Invoke = this:RepeatInvokeInSeconds(30, function()
    if m_RankEndTime and m_RankEndTime > CS.GameTime.serverUtc then
      REF.LabelTime.UILabel.text = WU.GetString("MaidCafe_RankMode_TimeRemain") .. RenderCountdownTimeNotUrgent(m_RankEndTime - CS.GameTime.serverUtc)
    elseif m_RankEndTime and m_RankEndTime ~= 0 and m_RankEndTime < CS.GameTime.serverUtc and m_RankCloseTime and m_RankCloseTime > CS.GameTime.serverUtc then
      REF.LabelTime.UILabel.text = WU.GetString("MaidCafe_RankMode_End")
    end
  end)
end

function Update()
end

function OnClickTreasure()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity) then
          WU.AcquireWindowAsync("MaidCafeGacha")
          return
        end
      end
    end
    WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
  end)
end

function OnClickOrdinaryDungeon()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_DaemonMode, function(acList)
    if acList then
      local onList
      for _, activity in pairs(acList) do
        if activity.timestampStart <= CS.GameTime.serverUtc then
          if onList == nil then
            onList = {}
            table.insert(onList, activity)
          else
            table.insert(onList, activity)
          end
        end
      end
      if onList then
        table.sort(onList, function(a, b)
          return a.activityId < b.activityId
        end)
        this:SetData("MaidCafe/CurrentActivity/Ordinary", onList)
        WU.AcquireWindowAsync("EventMaidCafeStage")
        return
      end
    end
    WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
  end)
end

function OnClickRankDungeon()
  if this:GetData("fci/baseinfo").level < 30 then
    WU.ShowHintText(WU.GetString("MaidCafe_RankMode_LevelToUnlock"))
    return
  end
  local info = this:GetData("fci/maidcafe/rank-mode")
  if info and info.unlocked == false then
    DB:GameRequest("fci/maidcafe/rank-mode"):Get(function(resp)
      this:SetData("fci/maidcafe/rank-mode", resp)
      CheckRankModeStatus()
    end)
  else
    CheckRankModeStatus()
  end
end

function OnClickMiniGame()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_MiniGame, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity) then
          WU.AcquireWindowAsync("GameStackTower")
          return
        end
      end
    end
    WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
  end)
end

function OnClickRank()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_RankMode, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity, true) then
          local infoAll = this:GetData("fci/maidcafe/rank-mode")
          if infoAll then
            if this:GetData("fci/baseinfo").level < 30 then
              this:SetData("MaidCafe/SelectedGroupId", 1)
            else
              local legendInfo = infoAll.rankModeInfo[PB.enum.MaidCafeRankModeType.Legend]
              this:SetData("MaidCafe/SelectedGroupId", fif(legendInfo.unlocked, legendInfo.rankModeGroupId, 1))
            end
          end
          WU.AcquireWindowAsync("MaidCafeRanks")
          return
        end
      end
    end
    WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
  end)
end

function CheckRankModeStatus()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_RankMode, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        if ACU.IsOpenForDoing(activity, true) then
          WU.AcquireWindowAsync("MaidCafeRecruitMent")
          return
        end
      end
    end
    WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
  end)
end

function OnRankInfoChanged(info)
  m_RankEndTime = 0
  m_NextTime = 0
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_RankMode, function(acList)
    if acList then
      table.sort(acList, function(a, b)
        return a.timestampStart < b.timestampStart
      end)
      for i = 1, #acList do
        if ACU.IsOpenForDoing(acList[i], true) then
          m_RankEndTime = acList[i].timestampEnd
          m_RankCloseTime = acList[i].timestampClose
          break
        end
        if acList[i].timestampStart > CS.GameTime.serverUtc then
          m_NextTime = acList[i].timestampStart
          break
        end
      end
    end
  end)
  if m_RankEndTime == 0 then
    REF.LabelTime.UILabel.text = fif(m_NextTime == 0, WU.GetString("MaidCafe_RankMode_Close"), WU.GetString("MaidCafe_RankMode_NextTime", WU.RenderTime2(m_NextTime, true)))
  end
  if info == nil then
    return
  end
  WU.SetActive(REF.LabelTime, info.unlocked)
  REF.SpriteRank.UISprite.spriteName = "minigame_title_" .. info.theme
end

function RenderCountdownTimeNotUrgent(remainTime)
  local seconds = math.max(remainTime, 0)
  local timeSpan = CS.System.TimeSpan(0, 0, seconds)
  local res = ""
  if 0 < timeSpan.Days then
    res = timeSpan.Days .. WU.GetString("Window_DayUnit")
  end
  res = res .. timeSpan.Hours .. WU.GetString("Window_HourUnit")
  res = res .. timeSpan.Minutes .. WU.GetString("Window_MinUnit")
  return res
end
