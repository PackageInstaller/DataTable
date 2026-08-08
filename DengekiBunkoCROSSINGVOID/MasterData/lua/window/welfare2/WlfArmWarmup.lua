local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local TU = require("Common/TaskUtil")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local ACU = require("Common/ActivityUtil")
local m_activityManager = S:Get("ActivityManager")
local m_cartoonId, m_warmupInfo

function Awake()
  m_cartoonId = PB.index("WarmupMiscConfig", 1).cartoonId
  WU.BindButtonEvent(REF.ButtonStory, function()
    WU.AcquireWindowAsync("ArmWarmupStory", function(window)
      _ENV["$"](window)["$$SetIndex"](1)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonCartoon, function()
    WU.EnterCartoonLevel(m_cartoonId, "Welfare", "Welfare/ArmWarmup")
  end)
  local chapterInfo = PB.all("WarmupChapterConfig")
  WU.TraverseChildren(REF.Chapters, function(go, i)
    local ref = _ENV["$"](go)
    ref["@chapter"] = chapterInfo[i + 1]
    WU.BindButtonEvent(ref.root, OnChapterClick)
  end)
end

function OnDestroy()
end

function OnEnable()
  this:Bind("ActivityList", CheckChapterStatus, false)
  this:Bind("NavigationContext", OnTopMostWindow, false)
  this:BindRemote(DB:GameRequest("fci/warmup"), OnWarmupInfoChange)
end

function OnDisable()
  this:Unbind("fci/warmup", OnWarmupInfoChange)
  this:Unbind("ActivityList", CheckChapterStatus)
  this:Unbind("NavigationContext", OnTopMostWindow)
  WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
end

function OnTopMostWindow(name)
  if name == "Welfare" then
    CheckNewChapterEffect()
  end
end

function OnWarmupInfoChange(info)
  m_warmupInfo = info
  CheckChapterStatus()
  CheckNewChapterEffect()
end

function CheckChapterStatus()
  if m_warmupInfo == nil then
    return
  end
  WU.TraverseChildren(REF.Chapters, function(go, i)
    local ref = _ENV["$"](go)
    local chapterInfo = ref["@chapter"]
    local _, record = table.find(m_warmupInfo.chapterRecords, function(k, v)
      return v.chapterId == chapterInfo.chapterId
    end)
    ref["@startTime"] = m_activityManager.GetActivitySync(chapterInfo.activityType, chapterInfo.activityId).timestampStart
    local unlocked = record ~= nil
    local available = unlocked and CS.GameTime.serverUtc >= ref["@startTime"]
    WU.SetActive(ref.TextureLock, not available)
    WU.SetActive(ref.TextureName, available)
    WU.SetActive(ref.Progress, available)
    WU.SetActive(ref.Content, true)
    WU.SetActive(ref.Effect, false)
    ref["@finished"] = false
    if unlocked then
      local count = PB.all("WarmupChapterProgressConfig"):where(function(k, v)
        return v.chapterId == chapterInfo.chapterId
      end):count() - 1
      local p = string.format("%.2f", record.currentProgressId / count)
      ref.LabelProgress.UILabel.text = math.floor(p * 100) .. "%"
      ref["@finished"] = record.currentProgressId == count
    end
  end)
  CheckNewChapterRedMark()
end

function OnChapterClick(go)
  local ref = _ENV["$"](go)
  local index = go.transform:GetSiblingIndex()
  if 0 < index and not REF.Chapters[index - 1]["@finished"] then
    WU.ShowHintText(WU.GetString("ArmWarmup_Locked"))
    return
  elseif CS.GameTime.serverUtc < ref["@startTime"] then
    WU.ShowHintText(WU.GetString("ArmWarmup_NotOpen", ACU.RenderTime2(ref["@startTime"])))
    return
  end
  local chapterInfo = ref["@chapter"]
  this:SetData("ArmWarmup/EnterChapter", chapterInfo.chapterId)
  local enteredChapter = WU.GetPlayerCache("ArmWarmup/EnteredChapter") or {}
  if not enteredChapter[tostring(chapterInfo.chapterId)] then
    enteredChapter[tostring(chapterInfo.chapterId)] = true
    WU.SetPlayerCache("ArmWarmup/EnteredChapter", enteredChapter)
    CheckNewChapterRedMark()
    if chapterInfo.chapterId == 1 then
      WU.EnterCartoonLevel(m_cartoonId, "Welfare,ArmWarmup", "Welfare/ArmWarmup")
    else
      WU.AcquireWindowAsync("ArmWarmup")
    end
  else
    WU.AcquireWindowAsync("ArmWarmup")
  end
end

function CheckNewChapterRedMark()
  if m_warmupInfo == nil then
    return
  end
  local enteredChapter = WU.GetPlayerCache("ArmWarmup/EnteredChapter") or {}
  local i, _ = table.find(m_warmupInfo.chapterRecords, function(k, v)
    return not enteredChapter[tostring(v.chapterId)]
  end)
  RU.SetRedMark("Welfare/ArmWarmup/NewChapter", i ~= nil)
  WU.SetActive(REF.ButtonCartoon, enteredChapter[tostring(1)])
end

function CheckNewChapterEffect()
  local top = WU.TopWindow()
  if top and top.name ~= "Welfare" or m_warmupInfo == nil then
    return
  end
  local viewedChapter = WU.GetPlayerCache("ArmWarmup/ViewedChapter") or {}
  local _, record = table.find(m_warmupInfo.chapterRecords, function(k, v)
    return not viewedChapter[tostring(v.chapterId)]
  end)
  if record == nil then
    return
  end
  for i = 0, #REF.Chapters - 1 do
    local ref = REF.Chapters[i]
    if ref["@chapter"].chapterId == record.chapterId then
      WU.SetActive(ref.Content, false)
      WU.SetActive(ref.Progress, false)
      WU.SetActive(ref.Effect, true)
      CS.SoundManager.Instance:PlaySound("Sound/se/armunlock")
      ref.Effect.EffectGenerator:Play()
      WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
      this:DelayInvokeInSeconds(2, function()
        viewedChapter[tostring(record.chapterId)] = true
        WU.SetPlayerCache("ArmWarmup/ViewedChapter", viewedChapter)
        WU.SetActive(ref.Progress, true)
        WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
      end)
      break
    end
  end
end
