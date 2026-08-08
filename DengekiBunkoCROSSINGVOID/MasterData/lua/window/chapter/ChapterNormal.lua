local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local S = require("Common/Singleton")
local RU = require("Common/RedMarkUtil")
local ACU = require("Common/ActivityUtil")
local m_tutorialManager = S:Get("TutorialManager")
local m_centeredPageIndex
local m_nameToTypeMap = {ChapterStory = 1, ChapterNormal = 2}
local m_type, m_chapterInfos, m_showChapterInfos, m_lastBookRef, m_dragDelta, m_curChapterID, m_bFirstOpen, m_oldChapter, m_resetPosition
local m_hasBroad = false
local m_showChip, m_showPlan, m_curChapter

function SetupWindow()
  m_bFirstOpen = true
  m_type = 2
  m_chapterInfos = PB.all("ChapterInfo"):where(function(k, v)
    return v.type == m_type
  end):toarray()
  table.sort(m_chapterInfos, function(a, b)
    return a.chapterIndex < b.chapterIndex
  end)
  WU.BindButtonEvent(REF.WidgetLeft, function(go)
    WU.RecordButtonClick(129008)
    NavigateRelative(-1)
  end)
  WU.BindButtonEvent(REF.WidgetRight, function(go)
    WU.RecordButtonClick(129009)
    NavigateRelative(1)
  end)
  WU.BindButtonEvent(REF.SpriteNavigation, function(go)
    WU.RecordButtonClick(129010)
    OpenChapterList()
  end)
  WU.BindButtonEvent(REF.ContainerReward, function(go)
    WU.RecordButtonClick(129001)
    OpenReward()
  end)
  WU.BindButtonEvent(REF.ButtonChipDungeon, OpenChipDungeon)
  REF.LabelStarNum.UILabel.text = ""
  CS.EventDelegate.Add(REF.DunMainScrollView.UIScrollView.onNext, onNext)
  WU.BindButtonEvent(REF.ButtonSlot, OnTaskClick)
end

function onNext()
  this:BroadcastGameEvent("TurnChapterBottom")
end

function OpenChipDungeon()
  WU.RecordButtonClick(129005)
  REF.TipChipDungeon.gameObject:SetActive(false)
  WU.AcquireWindowAsync("ChapterDungeonChip")
  WU.SetGameDataCache("TipChipDungeonShow" .. DB:GetData("playerId"), true)
end

function OpenChapterList()
  WU.AcquireWindowAsync("WidgetChapterList")
end

function OpenReward()
  REF.WidgetChapterRewardEntry["$OnEntryClick"]()
end

function InitWindow()
  WU.SetActive(REF.NextChapterSaku, false)
  m_showPlan = nil
  m_showChip = nil
  WU.SetActive(REF.SpriteNewerPlanBg, false)
  WU.SetActive(REF.EffectNewerPlanBg, false)
  this:Bind("ProgressTask/PTList", function(list)
    local _, v = table.find(list, function(k1, v1)
      return v1.ptName == "TaskPresent"
    end)
    SetTaskView(v)
    if m_showPlan ~= v then
      m_showPlan = v
      AdjustCenterUI()
    end
  end)
  this:SetData("ChapterRewardMode", "ChapterNormal")
  m_centeredPageIndex = nil
  REF.EffectBox.gameObject:SetActive(false)
  REF.SpriteRed.gameObject:SetActive(false)
  REF.TipChipDungeon.gameObject:SetActive(false)
  REF.ButtonChipDungeon.gameObject:SetActive(false)
  this:Bind("fci/dungeon/chapter-summary", OnChapterSummaryChanged)
  this:RegisterGameEvent("ChapterPageTo", NavigateAbsolute)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  RU.BindRedMark(this, "ChapterReward", OnRewardRedMark)
  m_resetPosition = REF.DunMainScrollView.UIScrollView.transform.localPosition
  this:RegisterGameEvent("TurnChapter", function(preChapterId, chapterId)
    local scrollView = REF.DunMainScrollView.UIScrollView
    local curPosition = scrollView.transform.localPosition
    scrollView:ResetPosition()
    local resetPosition = scrollView.transform.localPosition
    m_resetPosition = resetPosition
    local relative = curPosition - resetPosition
    this:SetData("NormalChapterPosition" .. preChapterId, relative)
  end)
  this:RegisterGameEvent("SetChapterPos", function(ps)
    local scrollView = REF.DunMainScrollView.UIScrollView
    scrollView:ResetPosition()
    scrollView:MoveRelative(ps)
    scrollView:RestrictWithinBounds(true)
  end)
  this:RegisterGameEvent("SaveChapterPos", function(chapterId)
    local scrollView = REF.DunMainScrollView.UIScrollView
    local curPosition = scrollView.transform.localPosition
    local relative = curPosition - m_resetPosition
    this:SetData("NormalChapterPosition" .. chapterId, relative)
  end)
  this:RegisterGameEvent("LocateChapterPos", LocateChapter)
  GetActorChipData()
end

function LocateChapter(position)
  if REF.DunMainScrollView.UIScrollView.enabled then
    local scrollView = REF.DunMainScrollView.UIScrollView
    local offset = -REF.DunMainScrollView.transform:InverseTransformPoint(position)
    local bounds
    if m_curChapter then
      bounds = m_curChapter["$$GetBounds"]()
    end
    
    local function call()
      offset.y = 0
      offset.z = 0
      local bounds = -1
      if m_curChapter then
        bounds = m_curChapter["$$GetBounds"]()
      end
      if bounds ~= -1 then
        local width = bounds - REF.WindowSize.UIWidget.width
        if 0 < width then
          offset.x = -math.min(width, math.abs(offset.x))
        end
      end
      scrollView:ResetPosition()
      scrollView:MoveRelative(offset)
      scrollView:RestrictWithinBounds(true)
    end
    
    if bounds ~= -1 then
      this:DelayInvokeEndOfFrame(function()
        call()
      end)
    else
      call()
    end
  end
end

function OnRewardRedMark(flag)
  this:DelayInvokeInSeconds(0.1, function()
    REF.EffectBox.gameObject:SetActive(flag)
    REF.SpriteRed.gameObject:SetActive(flag)
    if flag then
      REF.EffectBox.EffectGenerator:Play()
    end
  end)
end

function OpenChapter(chapterId, index)
  if m_curChapterID ~= chapterId then
    if m_curChapterID then
    end
    local preChapterId = m_curChapterID
    m_curChapterID = chapterId
    UpdateTotalStar()
    REF.LabelChapterTitle.UILabel.text = WU.GetString("Window_DungeonChapterIndex", chapterId)
    REF.WidgetChapterRewardEntry["$SetChapterId"](m_curChapterID)
    if m_curChapterID then
      if chapterId == 15 then
        REF.SpriteMask.gameObject:SetActive(true)
      else
        REF.SpriteMask.gameObject:SetActive(false)
      end
      this:BroadcastGameEvent("TurnChapter", preChapterId, m_curChapterID)
      do
        local function openFun()
          local chapter = CS.ResourceManager.Instance:InstantiateWindowPrefab("ChapterNormal/WidgetChapter" .. m_curChapterID)
          
          if chapter then
            local transform = chapter.transform
            transform.parent = REF.DunMainScrollView.transform
            transform.localPosition = CS.UnityEngine.Vector3.zero
            transform.localRotation = CS.UnityEngine.Quaternion.identity
            transform.localScale = CS.UnityEngine.Vector3.one
            local refChapter = _ENV["$"](chapter)
            if m_oldChapter then
              m_oldChapter["$$DisableContainer"]()
            end
            m_curChapter = refChapter
            refChapter["$$SetOldNode"](m_oldChapter, preChapterId)
            refChapter["$$SetChapterId"](chapterId)
            m_oldChapter = refChapter
            if REF.DunMainScrollView then
              WU.HandleGameObjectAttached(REF.DunMainScrollView.gameObject)
            end
            WU.ToggleRendering(chapter, true)
            if not m_hasBroad and index == 2 then
              m_hasBroad = true
            end
          else
            error("Chapter", "ChapterNormal/WidgetChapter" .. m_curChapterID .. " doesn't exist.")
          end
        end
        
        if m_bFirstOpen then
          this:DelayInvokeEndOfFrame(openFun)
          m_bFirstOpen = false
        else
          openFun()
        end
      end
    end
  else
    local chapter = REF.DunMainScrollView.transform:GetChild(0)
    _ENV["$"](chapter)["$$SetChapterId"](chapterId)
  end
  this:DelayInvokeInSeconds(0.5, function()
    WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, false)
  end)
end

function NavigateRelative(offset)
  local index = m_centeredPageIndex + offset
  NavigateAbsolute(index)
end

function UpdateShowChapaters()
  local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
  if chapterSummary then
    m_showChapterInfos = m_chapterInfos:where(function(k, v)
      return DU.IsChapterUnlocked(chapterSummary, v.chapterId)
    end):toarray()
    if #m_showChapterInfos == 0 then
      error("Dungeon", "server chapter not match client chapter")
      return
    end
  end
end

function OnChapterSummaryChanged(chapterSummary)
  if chapterSummary then
    local chipList = DU.GetChipDungeonList()
    if chipList and 0 < #chipList then
      DU.IsDungeonUnlocked(chapterSummary, chipList[1].dungeonId, function(unlocked)
        REF.ButtonChipDungeon.gameObject:SetActive(unlocked)
        if m_showChip ~= unlocked then
          m_showChip = unlocked
          AdjustCenterUI()
        end
        this:DelayInvokeInSeconds(0.5, function()
          REF.TipChipDungeon.gameObject:SetActive(unlocked and not WU.GetGameDataCache("TipChipDungeonShow" .. DB:GetData("playerId")))
        end)
      end)
    end
    m_showChapterInfos = m_chapterInfos:where(function(k, v)
      return DU.IsChapterUnlocked(chapterSummary, v.chapterId)
    end):toarray()
    if #m_showChapterInfos == 0 then
      error("Dungeon", "server chapter not match client chapter")
      return
    end
    table.sort(m_showChapterInfos, function(a, b)
      return a.chapterIndex < b.chapterIndex
    end)
    local lastChapterInfo = m_showChapterInfos:last()
    local newFinishedChapter = this:GetData("ChapterFinished")
    local preChapterId = lastChapterInfo.chapterId
    local t = this:GetData("fci/dungeon/chapter/" .. preChapterId)
    if t then
      local k, v = table.find(t.recordChapter.starRewardGot, function(k, v)
        return v == 0
      end)
      if not t.recordChapter.finished or k then
        preChapterId = preChapterId - 1
      end
    end
    if 0 < preChapterId then
      local prechapterInfo = this:GetData("fci/dungeon/chapter/" .. preChapterId)
      local prechapterRecord
      if prechapterInfo then
        prechapterRecord = prechapterInfo.recordChapter
      end
      if prechapterRecord then
        local _, v = table.find(prechapterRecord.starRewardGot, function(k, v)
          return v == 0
        end)
        if v == nil and prechapterRecord.finished then
          newFinishedChapter = preChapterId
        end
      end
    end
    if newFinishedChapter then
      this:SetData("Chapter1Finished", newFinishedChapter == 1)
      this:SetData("ChapterFinished", nil)
      NavigateAbsolute(newFinishedChapter)
      WU.ToggleRendering(REF.MainNode, true)
      GetChapterReward()
    else
      if not DU.IsChapterFinished(chapterSummary, lastChapterInfo.chapterId) then
        this:SetData("WaitChapter" .. lastChapterInfo.chapterId .. "Finished", true)
      elseif this:GetData("WaitChapter" .. lastChapterInfo.chapterId .. "Finished") then
        this:SetData("WaitChapter" .. lastChapterInfo.chapterId .. "Finished", nil)
      end
      local unlockedChapterIndex = #m_showChapterInfos
      local enteredChapterId = m_showChapterInfos[#m_showChapterInfos].chapterId
      if WU.IsStandaloneGame() then
        unlockedChapterIndex = 1
      end
      local noNewChapterUnlocked = this:GetData("NoNewChapterUnlocked")
      this:SetData("NoNewChapterUnlocked", nil)
      if noNewChapterUnlocked == false then
      else
        local paged = this:GetData("HasTurnPage")
        if noNewChapterUnlocked or paged then
          enteredChapterId = this:GetData("EnteredChapterId")
          if enteredChapterId then
            for i = 1, #m_showChapterInfos do
              if m_showChapterInfos[i].chapterId == enteredChapterId then
                unlockedChapterIndex = i
                break
              end
            end
          end
        end
      end
      NavigateAbsolute(m_centeredPageIndex or unlockedChapterIndex)
      UpdateTotalStar()
      WU.ToggleRendering(REF.MainNode, true)
    end
  end
end

function NavigateAbsolute(index)
  if m_showChapterInfos == nil or index < 0 then
    return
  end
  UpdateShowChapaters()
  if index > #m_showChapterInfos then
    local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
    local lastChapter = m_showChapterInfos:last()
    local chapterToUnlock = m_chapterInfos[index]
    if index > #m_chapterInfos then
      local str = WU.GetString("NewChapterTips4")
      WU.ShowHintText(str)
      return
    end
    if chapterSummary and chapterToUnlock then
      local unlockTips
      local storyInfo = PB.get("ChapterInfo", chapterToUnlock.storyChapterId)
      local chapterId = chapterToUnlock.preChapterId
      if storyInfo then
        chapterId = storyInfo.preChapterId
      end
      local isNextChapterUnlock, openTime = DU.IsChapterUnlocked(chapterSummary, chapterToUnlock.chapterId)
      local isPreChapterUnlock = DU.IsChapterUnlocked(chapterSummary, chapterId)
      if openTime and not isNextChapterUnlock then
        unlockTips = WU.GetString("Window_DungeonOpenTime", openTime)
      elseif 0 < chapterId and not DU.IsChapterFinished(chapterSummary, chapterId) then
        unlockTips = WU.GetString("Window_ChapterUnlockPreChapterLimit", WU.GetString("ChapterName_" .. chapterId))
      elseif chapterToUnlock.preChapterStar > chapterSummary.totalNormalStar and not isPreChapterUnlock then
        unlockTips = WU.GetString("Window_ChapterUnlockStarLimit", chapterToUnlock.preChapterStar - chapterSummary.totalNormalStar)
      end
      if unlockTips then
        WU.ShowHintText(unlockTips)
      end
    end
  elseif m_centeredPageIndex ~= index then
    if index == 0 then
      local str = WU.GetString("NewChapterTips3")
      WU.ShowHintText(str)
      return
    end
    if index > #m_chapterInfos then
      local str = WU.GetString("NewChapterTips4")
      WU.ShowHintText(str)
      return
    end
    local chapterInfo = m_chapterInfos[index]
    if chapterInfo == nil then
      return
    end
    WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, true)
    local chapterId = chapterInfo.chapterId
    this:SetData("EnteredChapterId", chapterId)
    this:SetData("HasTurnPage", true)
    OpenChapter(chapterId, index)
    m_centeredPageIndex = index
    m_curChapterID = chapterId
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_ChapterChange")
  end
end

function GetActorChipData()
  S:Get("ActivityManager").GetActivityByType(PB.enum.ActivityType.ActorChipExchange, function(activity)
    if activity and activity[1] and ACU.GetStatus(activity[1]) == PB.enum.ActivityStatus.Started then
      this:BindRemote(DB:GameRequest("fci/chipexchange/"), function(result)
        if result == nil then
          return
        end
        this:BroadcastGameEvent("UpdateChapterRewardSlot")
      end)
    elseif this:GetData("fci/chipexchange/") ~= nil then
      this:BroadcastGameEvent("UpdateChapterRewardSlot")
    end
  end)
end

function GetChapterReward()
  if m_curChapterID then
    local chapter = this:GetData("fci/dungeon/chapter/" .. m_curChapterID)
    local chapterRecord
    if chapter then
      chapterRecord = chapter.recordChapter
    end
    if chapterRecord == nil then
      warning("NoRecord in chapter" .. m_curChapterID)
      return
    end
    this:DelayInvokeInSeconds(0.5, function()
      WU.AcquireWindowAsync("ChapterFinishPopup", function(win)
        _ENV["$"](win)["$$SetChapter"](chapterRecord)
      end)
    end)
  end
end

function Focus(on)
  WU.RecordWindowFocus(100129, on)
  AdjustCenterUI()
end

function OnWindowUninited(window)
  if window.name == "ChapterFinishPopup" then
    local curTutorial = this:GetData("CurrentTutorial")
    if curTutorial and curTutorial ~= -1 then
      return
    end
    if m_curChapterID < #m_chapterInfos then
      REF.LabelNext.UILabel.text = WU.GetString("Window_NextChapter")
      WU.SetActive(REF.NextChapterGuide, true)
      _ENV["$"](REF.NextChapterGuide).Content.TweenScale:ResetToBeginning()
      _ENV["$"](REF.NextChapterGuide).Content.TweenPosition:ResetToBeginning()
      _ENV["$"](REF.NextChapterGuide).Content.TweenScale:PlayForward()
      this:DelayInvokeInSeconds(0.5, function()
        _ENV["$"](REF.NextChapterGuide).Content.TweenPosition:PlayForward()
      end)
      this:DelayInvokeInSeconds(5, function()
        WU.SetActive(REF.NextChapterGuide, false)
      end)
    end
  end
end

function UpdateTotalStar()
  if m_curChapterID then
    local sum = 0
    local chapterInfoes = PB.get("ChapterInfo", m_curChapterID)
    if chapterInfoes then
      for i, v in ipairs(chapterInfoes.dungeonId) do
        if DU.IsShowStar(v) then
          local dungeonReward = PB.get("DungeonReward", v)
          sum = sum + #dungeonReward.target
        end
      end
    end
    local record = this:GetData("fci/dungeon/chapter/" .. m_curChapterID)
    local curStar = record.recordChapter.totalStar
    REF.LabelStarNum.UILabel.text = curStar .. "/" .. sum
  end
end

function AdjustCenterUI()
  WU.SetActive(REF.SpriteNewerPlanBg, m_showPlan)
  if m_showPlan then
    local leftRelativeGo
    if m_showChip then
      leftRelativeGo = REF.RelativeLeft2
    else
      leftRelativeGo = REF.RelativeLeft1
    end
    local rightRelativeGo = REF.RelativeRight1
    local rlocPos = rightRelativeGo.transform.localPosition
    local lWldPos = leftRelativeGo.transform.position
    local llocPos = _ENV["$"](REF.Right).Group.transform:InverseTransformPoint(lWldPos)
    local distance = rlocPos - llocPos
    local width = math.floor(math.abs(distance.x))
    REF.SpriteNewerPlanBg.UISprite.width = width
    local pos = REF.WidgetProgressTask.transform.localPosition
    REF.WidgetProgressTask.transform.localPosition = CS.UnityEngine.Vector3(llocPos.x + width * 0.5, pos.y, 0)
    local descLabel = _ENV["$"](REF.WidgetProgressTask).LabelDesc
    local testLabel = _ENV["$"](REF.WidgetProgressTask).LabelDescTestWidth
    testLabel.UILabel.text = descLabel.UILabel.text
    testLabel.UILabel:ProcessText()
    local limitWidth = width - 300
    if limitWidth < testLabel.UILabel.width then
      descLabel.UILabel.overflowMethod = CS.UILabel.Overflow.ShrinkContent
      descLabel.UILabel.width = limitWidth
    else
      descLabel.UILabel.overflowMethod = CS.UILabel.Overflow.ResizeFreely
    end
    descLabel.UILabel:ProcessText()
    local contentWidth = descLabel.transform.localPosition.x + descLabel.UILabel.width
    REF.ContentPos.transform.localPosition = CS.UnityEngine.Vector3(-contentWidth * 0.5, 0, 0)
    local width = REF.SpriteNewerPlanBg.UISprite.width
    REF.EffectNewerPlanBg.UISprite.width = width + 20
    local pos = REF.WidgetProgressTask.transform.localPosition
    REF.EffectNewerPlanBg.transform.localPosition = pos
  end
end

function SetTaskView(task)
  if task then
    local actorId = task.actorId
    local hasActor = actorId ~= nil and actorId ~= 0
    WU.SetActive(REF.NodeSakuNormal, not hasActor and not task.canGet)
    WU.SetActive(REF.EffectSaku, not hasActor and task.canGet)
    WU.SetActive(REF.NodeActor, hasActor)
    WU.SetActive(REF.EffectActor, hasActor and task.canGet)
    WU.SetActive(REF.Holder, true)
    local kind
    if hasActor then
      kind = PB.get("ActorConfig", actorId).kind
      if kind == 1 then
        REF.TextureActorHeadMain.UITexture.mainTexturePath = string.format("Texture/ActorInfightHead/main/infight_head_%sa", actorId)
      elseif kind == 2 then
        REF.TextureActorHeadSub.UITexture.mainTexturePath = string.format("Texture/ActorInfightHead/sub/infight_head_%sa", actorId)
      end
    end
    WU.SetActive(REF.TextureActorHeadMain, kind == 1)
    WU.SetActive(REF.TextureActorHeadSub, kind == 2)
    REF.LabelDesc.UILabel.text = task.text
    local showEffect = task.canGet
    WU.SetActive(REF.EffectNewerPlanBg, showEffect)
  else
    WU.SetActive(REF.Holder, false)
  end
end

function OnTaskClick()
  this:SetData("ProgressTask/Tab", "TaskPresent")
  this:SetData("NewerPlan/FromWindow", "ChapterNormal")
  WU.AcquireWindowAsync("ProgressTask")
end
