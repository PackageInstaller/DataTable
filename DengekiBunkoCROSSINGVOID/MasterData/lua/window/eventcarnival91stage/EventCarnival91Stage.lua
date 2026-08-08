local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local DU = require("Common/DungeonUtil")
local m_activityList, m_activityIndex
local m_enumTab = {Carnival91Normal = 0, Carnival91Hard = 1}
local m_activedModalIndex

function SetupWindow()
  for i = 0, #REF.TabGrid - 1 do
    WU.BindButtonEvent(REF.TabGrid[i].root, function()
      OnClickTab(i)
    end)
  end
  WU.BindButtonEvent(REF.NodeArcade, OnClickArcade)
  WU.BindButtonEvent(REF.ButtonPass, OnClickPass)
  WU.BindButtonEvent(REF.ButtonReward, OnClickReward)
  for i = 0, #REF.NodeNormalChapters - 1 do
    WU.BindButtonEvent(REF.NodeNormalChapters[i].root, function()
      OnClickNormalChapter(i)
    end)
  end
  for i = 0, #REF.NodeHardDungeons - 1 do
    WU.BindButtonEvent(REF.NodeHardDungeons[i].root, function()
      OnClickHardDungeon(i)
    end)
  end
  for i = 0, #REF.ModalDungeonGrid - 1 do
    WU.BindButtonEvent(REF.ModalDungeonGrid[i].root, function()
      OnClickNormalDungeon(i)
    end)
  end
end

function InitWindow()
  InitActivityData()
  if #m_activityList == 0 then
    WU.ShowHintText(WU.GetString("Error_ActivityNotStart"))
    this:DelayInvokeInFrames(1, function()
      WU.RecycleWindow(this)
    end)
    return
  end
  for i = 0, #REF.TabGrid - 1 do
    local activity = m_activityList[i + 1]
    local openTime = WU.RenderTime2(activity.timestampStart)
    openTime = openTime .. "~" .. WU.RenderTime2(activity.timestampEnd)
    REF.TabGrid[i]["$$SetLabel"](WU.GetString(string.format("ActivityName_%s_%s", PB.enum.ActivityType.Carnival91, activity.activityId)), openTime)
    REF.TabGrid[i]["$$SetSelected"](false)
    WU.SetActive(REF.TabGrid[i].SpriteLock, not ACU.IsOpenForDoing(activity))
    RU.BindRedMark(this, "Welfare/Carnival91/Reward/" .. activity.activityId, GenOnRedMarkTab(i))
  end
  for i = 0, #REF.Content - 1 do
    WU.SetActive(REF.Content[i].root, false)
  end
  for i = 0, #REF.NodeBoxSpriteBG - 1 do
    WU.SetActive(REF.NodeBoxSpriteBG[i].root, false)
  end
  ActiveTab(this:GetData("EventCarnival91Stage/Tab"))
end

function UpdateWindow()
  if m_activityList[m_activityIndex + 1] then
    local targetTime = m_activityList[m_activityIndex + 1].timestampEnd
    local remainTime = targetTime - CS.GameTime.serverUtc
    if 0 < remainTime then
      local timeString = ACU.RenderLeftTime(remainTime)
      REF.LabelRest.UIHtmlLabel.text = timeString
    else
      REF.LabelRest.UIHtmlLabel.text = ""
    end
  end
end

function ActiveTab(index)
  DeactiveModal(m_activedModalIndex)
  SetRedMarkChest(false)
  if m_activityIndex then
    local activityId = m_activityList[m_activityIndex + 1].activityId
    this:Unbind(string.format("fci/activity/record/%s/%s", PB.enum.ActivityType.Carnival91, activityId), fif(m_activityIndex == m_enumTab.Carnival91Normal, ShowNormalContent, ShowHardContent))
    REF.TabGrid[m_activityIndex]["$$SetSelected"](false)
    WU.SetActive(REF.Content[m_activityIndex].root, false)
    WU.SetActive(REF.NodeBoxSpriteBG[m_activityIndex].root, false)
  end
  m_activityIndex = index
  local activityId = m_activityList[m_activityIndex + 1].activityId
  REF.TabGrid[m_activityIndex]["$$SetSelected"](true)
  WU.SetActive(REF.Content[m_activityIndex].root, true)
  WU.SetActive(REF.NodeBoxSpriteBG[m_activityIndex].root, true)
  this:BindRemote(this:GameRequest(string.format("fci/activity/record/%s/%s", PB.enum.ActivityType.Carnival91, activityId)), fif(m_activityIndex == m_enumTab.Carnival91Normal, ShowNormalContent, ShowHardContent))
  SetRedMarkChest(RU.GetRedMark("Welfare/Carnival91/Reward/" .. activityId))
end

function ShowNormalContent(records)
  if records then
    this:DelayInvokeInFrames(1, function()
      CS.SoundManager.Instance:PlayMusic("tijuana_91act")
    end)
    local dungeonIds = PB.get("EventDungeon", m_activityList[m_enumTab.Carnival91Normal + 1].activityId, PB.enum.ActivityType.Carnival91).dungeonId
    for i = 0, #REF.NodeNormalChapters - 1 do
      local isNew = false
      for j = 1, 3 do
        local dungeonId = dungeonIds[i * 3 + j]
        local record = GetDungeonRecord(m_activityList[m_activityIndex + 1].activityId, dungeonId)
        if record.unlocked and not record.finished then
          isNew = true
          break
        end
      end
    end
  end
end

function ShowHardContent(records)
  if records then
    this:DelayInvokeInFrames(1, function()
      CS.SoundManager.Instance:PlayMusic("Halloween")
    end)
    local dungeonIds = PB.get("EventDungeon", m_activityList[m_enumTab.Carnival91Hard + 1].activityId, PB.enum.ActivityType.Carnival91).dungeonId
    for i = 0, #REF.NodeHardDungeons - 1 do
      local dungeonId = dungeonIds[i + 1]
      local record = GetDungeonRecord(m_activityList[m_activityIndex + 1].activityId, dungeonId)
      REF.NodeHardDungeons[i].SpriteDungeon.UISprite.graify = not record.unlocked
      local refStars = REF.NodeHardDungeons[i].Stars
      for j = 0, #refStars - 1 do
        refStars[j].root.UISprite.spriteName = "star_" .. fif(j < #record.targetsDone, "light", "dark")
      end
    end
  end
end

function GenOnRedMarkTab(index)
  return function(flag)
    WU.SetActive(REF.TabGrid[index].SpriteRedMark, flag)
    if m_activityIndex == index then
      SetRedMarkChest(RU.GetRedMark("Welfare/Carnival91/Reward/" .. m_activityList[index + 1].activityId))
    end
  end
end

function SetRedMarkChest(flag)
  WU.SetActive(REF.EffectBox, flag)
  WU.SetActive(REF.SpriteRedBox, flag)
end

function InitActivityData()
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.Carnival91)
  if activities then
    m_activityList = _ENV["!"](activities):where(function(k, v)
      return v.category == PB.enum.ActivityCategory.Dungeon
    end):toarray()
  else
    m_activityList = {}
  end
end

function GetDungeonRecord(acId, dungeonId)
  local records = this:GetData(string.format("fci/activity/record/%s/%s", PB.enum.ActivityType.Carnival91, acId)).records
  local _, record = table.find(records, function(k, v)
    return v.dungeonId == dungeonId
  end)
  if record == nil then
    error("GamePlay", string.format("dungeon%s's record is not in fci/activity/record/%s/%s", dungeonId, PB.enum.ActivityType.Carnival91, acId))
  end
  return record
end

function OnClickNormalDungeon(index)
  local record = REF.ModalDungeonGrid[index]["@record"]
  local acId = m_activityList[m_activityIndex + 1].activityId
  if record.unlocked then
    this:SetData("SemiFixed/ActivityId", acId)
    this:SetData("DungeonDetailSemiFixed/DungeonId", record.dungeonId)
    WU.AcquireWindowAsync("DungeonDetailSemiFixed")
  else
    local preRecord = REF.ModalDungeonGrid[index - 1]["@record"]
    WU.AcquireWindowAsync("Carnival91UnlockDetail", function(w)
      _ENV["$"](w)["$$SetData"](preRecord, record)
    end)
  end
end

function OnClickTab(index)
  if index == m_activityIndex then
    return
  end
  local activity = m_activityList[index + 1]
  if not ACU.IsOpenForDoing(activity) then
    WU.ShowHintText(WU.GetString("Error_ActivityNotStart"))
    return
  end
  this:SetData("EventCarnival91Stage/Tab", index)
  ActiveTab(index)
end

function OnClickNormalChapter(index)
  ActiveModal(index, true)
end

function DeactiveModal()
  if m_activedModalIndex then
    WU.SetActive(REF.ModalDifficulty, false)
    WU.SetActive(REF.NodeNormalChapters[m_activedModalIndex].Effect, false)
    WU.SetActive(REF.NodeNormalChapters[m_activedModalIndex].SpriteChapter, true)
    WU.SetActive(REF.NodeNormalChapters[m_activedModalIndex].SpriteShadow, true)
    m_activedModalIndex = nil
  end
end

function ActiveModal(index)
  if index == m_activedModalIndex then
    return
  end
  DeactiveModal()
  m_activedModalIndex = index
  local refChapter = REF.NodeNormalChapters[index]
  WU.SetActive(REF.ModalDifficulty, true)
  WU.SetActive(refChapter.Effect, true)
  WU.SetActive(REF.NodeNormalChapters[m_activedModalIndex].SpriteChapter, false)
  WU.SetActive(REF.NodeNormalChapters[m_activedModalIndex].SpriteShadow, false)
  local acId = m_activityList[m_enumTab.Carnival91Normal + 1].activityId
  local dungeonIds = PB.get("EventDungeon", acId, PB.enum.ActivityType.Carnival91).dungeonId
  REF.ModalDifficulty.transform.position = refChapter.ModalHolder.transform.position
  _ENV["$"](REF.ModalDifficulty).LabelChapter.UILabel.text = refChapter.LabelArea.UILabel.text
  for i = 0, #REF.ModalDungeonGrid - 1 do
    local dungeonId = dungeonIds[index * 3 + i + 1]
    local record = GetDungeonRecord(acId, dungeonId)
    REF.ModalDungeonGrid[i]["@record"] = record
    REF.ModalDungeonGrid[i].root.UISprite.graify = not record.unlocked
    if REF.ModalDungeonGrid[i].SpriteLock then
      WU.SetActive(REF.ModalDungeonGrid[i].SpriteLock, not record.unlocked)
    end
    if REF.ModalDungeonGrid[i].SpriteNew then
      WU.SetActive(REF.ModalDungeonGrid[i].SpriteNew, record.unlocked and not record.finished)
    end
  end
end

function OnClickHardDungeon(index)
  local ac = m_activityList[m_enumTab.Carnival91Hard + 1]
  local acId = ac.activityId
  local dungeonId = PB.get("EventDungeon", acId, PB.enum.ActivityType.Carnival91).dungeonId[index + 1]
  local record = GetDungeonRecord(acId, dungeonId)
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  if not record.unlocked then
    WU.ShowHintText(WU.GetString("Error_MustFinishPreDun"))
    return
  end
  if dungeonReward.unlockLevel and this:GetData("fci/baseinfo/").level < dungeonReward.unlockLevel then
    WU.ShowHintText(WU.GetString("EventActivity_Level_Not_Enough", dungeonReward.unlockLevel))
    return
  end
  this:SetData("EventActivity/CurrentActivity", ac)
  this:SetData("WindowDungeon/DungeonId", dungeonId)
  this:SetData("ActorGroup/DungeonType", dungeonReward.type)
  WU.AcquireWindowAsync("EventStagePrepare")
end

function OnClickArcade()
  local function Open()
    DeactiveModal()
    
    WU.AcquireWindowAsync("GameCardMatch")
  end
  
  if not DU.IsWaitingForJob(Open) then
    Open()
  end
end

function OnClickPass()
  this:SetData("Welfare/ActivityType", PB.enum.ActivityType.Carnival91)
  WU.AcquireWindowAsync("Carnival91Pass")
end

function OnClickReward()
  local acId = m_activityList[m_activityIndex + 1].activityId
  local data = this:GetData(string.format("fci/activity/record/%s/%s", PB.enum.ActivityType.Carnival91, acId))
  WU.AcquireWindowAsync("PrizePreview", function(window)
    _ENV["$"](window)["$$SetPrizePreview"]("EventActivityStar", {
      activityType = PB.enum.ActivityType.Carnival91,
      activityId = acId,
      playerRecord = data.rewardSummary[acId].totalStar,
      xlsxFilter = {
        [1] = {key = "activityId", value = acId},
        [2] = {
          key = "activityType",
          value = PB.enum.ActivityType.Carnival91
        }
      }
    })
  end)
end
