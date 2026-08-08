local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local DU = require("Common/DungeonUtil")
local m_activityList

function SetupWindow()
  WU.TraverseChildren(REF.NormalDungeon, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnDungeonClick)
  end)
  WU.TraverseChildren(REF.DangerDungeon, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnDungeonClick)
  end)
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
  for i = 1, #m_activityList do
    local activity = m_activityList[i]
    local status = ACU.GetStatus(activity)
    local isNormal = i <= 4
    local ref
    if isNormal then
      ref = REF.NormalDungeon[i - 1]
    else
      ref = REF.DangerDungeon[i - 5]
    end
    ref["@activityInfo"] = activity
    ref["@status"] = status
    ref["@isNormal"] = isNormal
    ref["@chapterIndex"] = fif(isNormal, i, i - 4)
    local showContent = ""
    if isNormal then
      showContent = WU.GetString(string.format("Christmas_NormalDungeonChapter%s", i))
    elseif status ~= PB.enum.ActivityStatus.PreHeat and status ~= PB.enum.ActivityStatus.None then
      showContent = WU.GetString(string.format("Christmas_DangerDungeonChapter%s", i - 4))
      ToggleMask(ref["@chapterIndex"], false)
    else
      local time = WU.RenderTime2(activity.timestampStart)
      showContent = time .. WU.GetString("Window_OpenTag")
      ToggleMask(ref["@chapterIndex"], true)
    end
    ref.LabelName.UILabel.text = showContent
    RU.BindRedMark(this, "Welfare/Christmas/Reward/" .. activity.activityId, function(flag)
      WU.SetActive(ref.SpriteRed, flag)
    end)
  end
end

function ToggleMask(index, visible)
  local refName = fif(index == 1, "H03", "H04")
  local texturePath
  if visible then
    texturePath = fif(index == 1, "Texture/Christmas/Christmas_SB_house3B", "Texture/Christmas/Christmas_SB_house4B")
  else
    texturePath = fif(index == 1, "Texture/Christmas/Christmas_SB_house3", "Texture/Christmas/Christmas_SB_house4")
  end
  local ref = REF[refName]
  local tex = WU.AcquireAsset(texturePath)
  ref.MeshRenderer.material:SetTexture("_MainTex", tex)
end

function InitActivityData()
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.Christmas) or _ENV["!"]({})
  local tempList = _ENV["!"](activities):where(function(k, v)
    return v.category == PB.enum.ActivityCategory.Dungeon
  end):toarray()
  m_activityList = _ENV["!"]({})
  table.copy(tempList, m_activityList)
  table.sort(m_activityList, function(a, b)
    return a.activityId < b.activityId
  end)
end

function OnDungeonClick(go)
  local ref = _ENV["$"](go)
  if ref["@status"] == PB.enum.ActivityStatus.PreHeat or ref["@status"] == PB.enum.ActivityStatus.None then
    WU.ShowHintText(WU.GetString("Activity_DungeonIsNotUnlock"))
    return
  elseif ref["@status"] == PB.enum.ActivityStatus.Finished or ref["@status"] == PB.enum.ActivityStatus.Close then
    WU.ShowHintText(WU.GetString("Window_GuildDungeonCloseTip"))
    return
  end
  this:SetData("ChristmasDungeon/Chapter", {
    activityInfo = ref["@activityInfo"],
    isNormal = ref["@isNormal"],
    chapterIndex = ref["@chapterIndex"]
  })
  WU.AcquireWindowAsync("EventChristmasStageChapter")
end
