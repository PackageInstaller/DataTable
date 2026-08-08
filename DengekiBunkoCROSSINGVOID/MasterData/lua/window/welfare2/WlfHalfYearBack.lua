local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_misc = PB.index("Misc", 1)
local m_clientFlag, m_activeTime, m_url, m_activityId

function Awake()
  WU.BindButtonEvent(REF.ButtonSignin, function()
    local unlocked = this:GetData("halfyearbackcando")
    if unlocked then
      WU.AcquireWindowAsync("HalfYearBackSignin")
    else
      WU.ShowHintText(WU.GetString("DungeonTeam_ActivityEnded"))
    end
  end)
  WU.BindButtonEvent(REF.ButtonTask, function()
    if m_clientFlag == 0 then
      this:GameRequest("fci/half-year-back-activity/"):Post({clientFlag = 1}, function()
        local activityInfo = this:GetData("fci/half-year-back-activity/")
        activityInfo.clientFlag = 1
        this:SetData("fci/half-year-back-activity/", activityInfo)
        WU.AcquireWindowAsync("HalfYearBackTask")
      end)
    else
      WU.AcquireWindowAsync("HalfYearBackTask")
    end
  end)
  WU.BindButtonEvent(REF.ButtonVideo, function()
    if m_url then
      WU.OpenUrl(m_url)
    end
  end)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    this:SetData("ShareConfig", {
      shareName = "WlfHalfYearBack",
      fromWindow = WU.TopWindow() and WU.TopWindow().name
    })
    WU.AcquireWindowAsync("Share")
  end)
end

function OnEnable()
  REF.FirstBuffShow.gameObject:SetActive(false)
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.HalfYearBack)
  m_activityId = activities[1].activityId
  this:Bind("fci/half-year-back-activity/", OnActivityInfoChange)
end

function OnActivityInfoChange(activityInfo)
  if activityInfo == nil then
    return
  end
  m_clientFlag = activityInfo.clientFlag
  if m_clientFlag == 0 then
    local rewardInfo = PB.all("PlayerBackProcess"):where(function(k, v)
      return v.activityId == m_activityId and v.levelMax >= activityInfo.activeLevel and v.levelMin <= activityInfo.activeLevel and v.progress == 0
    end):toarray()
    if table.empty(rewardInfo) then
      error(string.format("PlayerBackProcess.xlsx has no id = %s and level %s", m_activityId, m_activeLevel))
      return
    end
    local rewards = rewardInfo[1].reward
    local goRef = _ENV["$"](REF.WidgetIconSlotHalfYearTask)
    goRef.IconHasClaimed.gameObject:SetActive(false)
    goRef.SpriteProgress.gameObject:SetActive(false)
    goRef["$$SetData"](rewards[1].type, rewards[1].id)
    goRef["$$SetClickCallback"](function()
      WU.ShowResourceDetail(rewards[1].type, rewards[1].id)
    end)
    REF.FirstBuffShow.gameObject:SetActive(true)
  else
    REF.FirstBuffShow.gameObject:SetActive(false)
  end
  REF.LabelSigninDays.UIHtmlLabel.text = WU.GetString("Welfare_SigninDays", activityInfo.signStep)
  m_activeTime = activityInfo.activeTime
  if activityInfo.videoUrl and activityInfo.videoUrl[1] then
    m_url = activityInfo.videoUrl[1]
  end
end

function Update()
  local activeTime = CS.GameTime.UtcToLocal(m_activeTime)
  local activeDay24 = CS.System.DateTime(activeTime.Year, activeTime.Month, activeTime.Day, 0, 0, 0):AddDays(1)
  local endDoTime = activeDay24:AddDays(m_misc.halfYearBackDuration)
  local lastTime = endDoTime - CS.GameTime.serverNow
  if endDoTime < CS.GameTime.serverNow then
    REF.LabelLastTime.gameObject:SetActive(false)
    return
  end
  local lastDay = lastTime.Days
  local lastHour = lastTime.Hours
  local lastMin = lastTime.Minutes
  local lastSecond = lastTime.Seconds
  if 0 < lastDay then
    REF.LabelLastTime.UIHtmlLabel.text = WU.GetString("Welfare_LastTimeDay", lastDay, lastHour)
  elseif 0 < lastHour then
    REF.LabelLastTime.UIHtmlLabel.text = WU.GetString("Welfare_LastTimeHour", lastHour, lastMin)
  else
    REF.LabelLastTime.UIHtmlLabel.text = WU.GetString("Welfare_LastTimeMin", lastMin, lastSecond)
  end
end
