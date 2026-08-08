local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local m_acStatus, m_chipDuns, m_exchangeInfo, m_chapterSumry, m_curDunId, m_curChapterId

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, OnButtonExitClick)
  WU.BindButtonEvent(REF.BtnChipExchange, function()
    if WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare, PB.enum.UnlockWindow.Welfare) then
      return
    end
    this:SetData("WelfareTab", "ActorChipExchange")
    WU.AcquireWindowAsync("Welfare")
  end)
end

function InitWindow()
  this:Bind("fci/dungeon/chapter-summary", function(summary)
    this:Bind("fci/chipexchange/", function(exchangeinfo)
      m_chapterSumry = summary
      m_exchangeInfo = exchangeinfo
      m_chipDuns = DU.GetChipDungeonList()
      LU.Bind(REF.WrapContent, {
        updateRow = UpdateChoiceSlot
      })
      this:RegisterGameEvent("UpdateChapterRewardSlot", SetContent)
      this:RegisterGameEvent("ResourceExchangeSucceed", OnResourceExchangeSucceed)
      SetContent()
    end)
  end)
end

function SetContent(reset)
  m_curChapterId = nil
  m_curDunId = nil
  S:Get("ActivityManager").GetActivityByType(PB.enum.ActivityType.ActorChipExchange, function(activity)
    if activity and activity[1] then
      m_acStatus = ACU.GetStatus(activity[1])
    end
    DU.IsDungeonUnlocked(m_chapterSumry, 5102, function(unlocked)
      if unlocked and (m_acStatus == PB.enum.ActivityStatus.PreHeat or m_acStatus == PB.enum.ActivityStatus.Started) then
        REF.TextureAd.UITexture.mainTexturePath = "Texture/Welfare/factor_picture_2"
        REF.LabelOpenTime.UILabel.text = WU.RenderTime24(activity[1].timestampStart, activity[1].timestampClose)
        REF.BtnChipExchange.gameObject:SetActive(true)
      else
        REF.TextureAd.UITexture.mainTexturePath = "Texture/Welfare/factor_picture_1"
        REF.BtnChipExchange.gameObject:SetActive(false)
        REF.LabelOpenTime.UILabel.text = ""
      end
      LU.Set(REF.WrapContent, #m_chipDuns, reset)
    end)
  end)
end

function UpdateChoiceSlot(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_chipDuns == nil or realIndex >= #m_chipDuns then
    return
  end
  local record
  local dun = m_chipDuns[realIndex + 1]
  local recordInfo = this:GetData("fci/dungeon/chapter/" .. dun.chapterId)
  local reward = PB.get("DungeonReward", dun.dungeonId)
  local dropDisplayOutside = dun.outInfo[1]
  local restTimes = reward.enterTimes
  if recordInfo then
    record = recordInfo.recordDungeons[dun.dungeonId]
    if record then
      restTimes = math.max(0, reward.enterTimes - record.doneTimes)
    end
  end
  rowRef.ButtonAddTime.gameObject:SetActive(restTimes <= 0)
  rowRef.LabelName.UILabel.text = WU.GetString("MainStoryTag", dun.chapterIndex)
  rowRef.LabelTimeLeft.UILabel.text = WU.GetString("Window_ChanceLeft") .. restTimes .. "/" .. reward.enterTimes
  rowRef.WidgetIconSlot["$SetData"](dropDisplayOutside.type, dropDisplayOutside.id)
  rowRef.WidgetIconSlot["$SetClickCallback"](function()
    WU.ShowResourceDetail(dropDisplayOutside.type, dropDisplayOutside.id)
  end)
  DU.IsDungeonUnlocked(m_chapterSumry, dun.dungeonId, function(unlocked)
    WU.SetActive(rowRef.ButtonGoto, unlocked and 0 < restTimes)
    WU.SetActive(rowRef.LabelTimeLeft, unlocked)
    WU.SetActive(rowRef.SpriteDone, unlocked and restTimes <= 0)
    WU.SetActive(rowRef.SpriteLock, not unlocked)
  end)
  WU.ClearButtonEvent(rowRef.ButtonGoto)
  WU.BindButtonEvent(rowRef.ButtonGoto, function()
    WU.RecordButtonClick(129006)
    WU.AcquireWindowAsync("DungeonStory", function()
      this:SetData("DungeonPrepare/ChapterId", dun.chapterId)
      this:SetData("DungeonPrepare/DungeonId", dun.dungeonId)
    end)
  end)
  WU.ClearButtonEvent(rowRef.ButtonAddTime)
  WU.BindButtonEvent(rowRef.ButtonAddTime, function()
    m_curChapterId = dun.chapterId
    m_curDunId = dun.dungeonId
    WU.Exchange(PB.enum.ResourceType.ResDungeonPlayTimesLimit, dun.dungeonId, true)
  end)
end

function OnButtonExitClick()
  WU.RecordButtonClick(129007)
  WU.RecordWindowFocus(100129, false)
  WU.RecycleWindow(this)
end

function OnResourceExchangeSucceed(buy)
  local chap = this:GetData("fci/dungeon/chapter/" .. m_curChapterId)
  chap.recordDungeons[m_curDunId].doneTimes = chap.recordDungeons[m_curDunId].doneTimes - buy.count
  this:SetData("fci/dungeon/chapter/" .. m_curChapterId, chap)
  this:BroadcastGameEvent("RefreshChipExchangeDungeon")
  SetContent(false)
end

function Focus(on)
  if on then
    WU.RecordWindowFocus(100129, true)
  end
end
