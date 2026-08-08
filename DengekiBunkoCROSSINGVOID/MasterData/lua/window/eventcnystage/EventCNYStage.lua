local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local DU = require("Common/DungeonUtil")
local m_activityList
local m_normalDungeonChapterCount = 4
local m_hardUnlock, m_scrollViewInitX

function SetupWindow()
  WU.BindButtonEvent(REF.BtnToHard, OnBtnToHardClick)
  WU.TraverseChildren(REF.WrapContentDungeon, function(go)
    WU.BindButtonEvent(_ENV["$"](go).Visual, OnDungeonClick)
  end)
  LU.Bind(REF.WrapContentDungeon, {
    updateRow = UpdateDungeonSlot
  })
  REF.ScrollViewDungeon.UIPanel:AddOnClipMoveListener(OnScrollViewMove)
end

function InitWindow()
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  m_scrollViewInitX = REF.ScrollViewDungeon.transform.localPosition.x
  RU.SetRedMark("Welfare/ChineseNewYear/Reward/HardUnlockFirst", false)
  WU.RecordFirstTimeInClient("Welfare2019CNYHardDungeonUnlock")
  InitActivityData()
  if #m_activityList == 0 then
    WU.ShowHintText(WU.GetString("Error_ActivityNotStart"))
    this:DelayInvokeInFrames(1, function()
      WU.RecycleWindow(this)
    end)
    return
  end
  LU.Set(REF.WrapContentDungeon, #m_activityList)
  REF.WrapContentDungeon.UIPlayTween:Play(true)
end

function OnWindowUninited(window)
  if window.name == "EventCNYStageChapter" then
    LU.Set(REF.WrapContentDungeon, #m_activityList)
    REF.WrapContentDungeon.UIPlayTween:Play(true)
  end
end

function InitActivityData()
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.ChineseNewYear) or _ENV["!"]({})
  local tempList = _ENV["!"](activities):where(function(k, v)
    return v.category == PB.enum.ActivityCategory.Dungeon
  end):toarray()
  m_activityList = _ENV["!"]({})
  table.copy(tempList, m_activityList)
  table.sort(m_activityList, function(a, b)
    return a.activityId < b.activityId
  end)
  local _, v = table.find(m_activityList, function(k1, v1)
    local status = ACU.GetStatus(v1)
    return status ~= PB.enum.ActivityStatus.Started
  end)
  m_hardUnlock = v == nil
end

function UpdateDungeonSlot(goRef, wrapIndex, realIndex)
  if m_activityList and realIndex < #m_activityList then
    local index = realIndex + 1
    local activityInfo = m_activityList[index]
    local ref = _ENV["$"](goRef.Visual)
    ref["@activityInfo"] = activityInfo
    ref["@status"] = ACU.GetStatus(activityInfo)
    ref["@isNormal"] = index <= m_normalDungeonChapterCount
    ref["@chapterIndex"] = fif(index <= m_normalDungeonChapterCount, index, index - 4)
    ref.TextureCover.UITexture.mainTexturePath = "Texture/Welfare/new_year/new_year_menu_" .. index
    local pos = ref["$transform"].localPosition
    ref["$transform"].localPosition = {
      x = pos.x,
      y = -17 * realIndex,
      z = pos.z
    }
    local notOpen = ref["@status"] == PB.enum.ActivityStatus.PreHeat or ref["@status"] == PB.enum.ActivityStatus.None
    local preNotPass
    if index == 1 then
      preNotPass = false
    elseif index <= m_normalDungeonChapterCount then
      local preActivity = m_activityList[index - 1]
      local info = this:GetData("fci/activity/record/" .. PB.enum.ActivityType.ChineseNewYear .. "/" .. preActivity.activityId)
      if info == nil then
        preNotPass = true
      else
        local records = info.records or _ENV["!"]({})
        local t = PB.get("EventDungeon", preActivity.activityId, PB.enum.ActivityType.ChineseNewYear)
        local dungeonId = t.dungeonId[2]
        local _, record = table.find(records, function(k, v)
          return v.dungeonId == dungeonId
        end)
        preNotPass = not record.unlocked
      end
    end
    ref["@preNotPass"] = preNotPass
    WU.SetActive(ref.TextureUnlock, notOpen or preNotPass)
    local flag = RU.GetRedMark("Welfare/ChineseNewYear/Reward/" .. activityInfo.activityId)
    WU.SetActive(ref.SpriteRed, flag)
  end
end

function OnDungeonClick(go)
  local ref = _ENV["$"](go)
  if ref["@status"] == PB.enum.ActivityStatus.PreHeat or ref["@status"] == PB.enum.ActivityStatus.None then
    WU.ShowHintText(WU.GetString("Activity_DungeonIsNotUnlock"))
    return
  elseif ref["@status"] == PB.enum.ActivityStatus.Finished or ref["@status"] == PB.enum.ActivityStatus.Close then
    WU.ShowHintText(WU.GetString("Window_GuildDungeonCloseTip"))
    return
  elseif ref["@preNotPass"] then
    WU.ShowHintText(WU.GetString("Dungeon_NeedPreChapterUnlock"))
    return
  end
  this:SetData("CNYDungeon/Chapter", {
    activityInfo = ref["@activityInfo"],
    isNormal = ref["@isNormal"],
    chapterIndex = ref["@chapterIndex"]
  })
  WU.AcquireWindowAsync("EventCNYStageChapter")
end

function OnBtnToHardClick()
  local itemWidth = REF.WrapContentDungeon.UIWrapContent.itemSize
  local scrollDistance = itemWidth * (m_normalDungeonChapterCount - 1)
  REF.ScrollViewDungeon.UIScrollView:ResetPosition()
  REF.ScrollViewDungeon.UIScrollView:DisableSpring()
  REF.ScrollViewDungeon.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(-scrollDistance, 0, 0))
  REF.ScrollViewDungeon.UIScrollView:RestrictWithinBounds(true)
end

function OnScrollViewMove()
  if m_hardUnlock ~= true then
    WU.SetActive(REF.BtnToHard, false)
    return
  end
  local showButton = false
  local offSet = 6 * REF.WrapContentDungeon.UIWrapContent.itemSize
  local currentScrollViewOffsetX = m_scrollViewInitX - REF.ScrollViewDungeon.transform.localPosition.x
  local fromViewTop = offSet - currentScrollViewOffsetX
  local showButton = fromViewTop > REF.ScrollViewDungeon.UIPanel.finalClipRegion.z
  WU.SetActive(REF.BtnToHard, showButton)
end
