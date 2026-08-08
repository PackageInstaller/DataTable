local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local RU = require("Common/RedMarkUtil")
local PU = require("Common/PlatformUtil")
local DU = require("Common/DungeonUtil")
local m_activityManager = S:Get("ActivityManager")
local Msdk = CS.Msdk
local m_defaultTabName = "TaskPresent"
local m_repeatedContext = {}
local m_curTabName, m_cacheMusic

function SetupWindow()
  local configs = PB.all("ProgressTaskConfig")
  for k, config in pairs(configs) do
    local goSlot = WU.InstantiateWindowPrefab(REF.TabGrid, "ProgressTask/ProgressTaskTabSlot", "TabSlot" .. config.name)
    _ENV["$"](goSlot)["$$Init"](config.name)
    WU.HandleGameObjectAttached(REF.root.gameObject)
  end
end

function InitWindow()
  local ptList = this:GetData("ProgressTask/PTList")
  local configs = PB.all("ProgressTaskConfig")
  for k, config in pairs(configs) do
    WU.SetActive(REF["TabSlot" .. config.name], false)
  end
  local tabNames = {}
  for _, pt in pairs(ptList) do
    if pt.ptName then
      tabNames[pt.ptName] = true
    end
  end
  for ptName, _ in pairs(tabNames) do
    WU.SetActive(REF["TabSlot" .. ptName], true)
  end
  WU.HandleGameObjectAttached(REF.root.gameObject)
  REF.TabGrid.UIGrid:Reposition()
  m_cacheMusic = CS.SoundManager.Instance:GetCurrentMusic()
  this:RegisterGameEvent("ProgressTask/TabClicked", OnClickTab)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChange)
  this:Bind("ProgressTask/Tab", OnPTTabChanage)
  REF.TabGrid.UIPlayTween:Play(true)
end

function OnClickTab(ptName)
  local onClickFunc = rawget(_ENV, "OnClick" .. ptName)
  if onClickFunc then
    onClickFunc()
  end
  this:SetData("ProgressTask/Tab", ptName)
end

function OnPTTabChanage(ptName)
  if ptName then
    if ptName == "CustomActorCultivation1" then
      this:SetData("CustomActorCultivation/ActivityIndex", 1)
    elseif ptName == "CustomActorCultivation2" then
      this:SetData("CustomActorCultivation/ActivityIndex", 2)
    end
    ActiveTab(ptName)
    local helpTabName = PB.get("ProgressTaskConfig", ptName).helpTabName
    this:SetData("ProgressTaskHelpTab", fif(helpTabName == "", ptName, helpTabName))
  end
end

function OnActivityStatusChange(category, id, status, type)
  local relatedConfigs = PB.all("ProgressTaskConfig"):where(function(_, v)
    return v.relatedActivityType == type
  end)
  for _, config in pairs(relatedConfigs) do
    local handleFunc = rawget(_ENV, "OnAcChange" .. config.name)
    local acStatusMap = GetAcStatusMap(config.name)
    if handleFunc then
      handleFunc(acStatusMap)
    else
      local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started)
      NotifyWelfareStatucChange(config.name, open)
    end
  end
end

function NotifyWelfareStatucChange(ptName, open)
  WU.SetActive(REF["TabSlot" .. ptName], open)
  REF.TabGrid.UIGrid:Reposition()
  REF.ScrollViewTab.UIScrollView:ResetPosition()
  if m_curTabName == ptName and not open then
    this:SetData("ProgressTask/Tab", m_defaultTabName)
  end
end

function UninitWindow()
  DeactiveTabs()
  this:SetData("ProgressTask/Tab", nil)
  m_curTabName = nil
  local curMusic = CS.SoundManager.Instance:GetCurrentMusic()
  if curMusic ~= m_cacheMusic then
    CS.SoundManager.Instance:PlayMusic(m_cacheMusic)
  end
end

function SaveContext()
  table.insert(m_repeatedContext, {ptTab = m_curTabName})
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("ProgressTask/Tab", context.ptTab)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function DeactiveTabs()
  for i = 0, #REF.TabGrid - 1 do
    REF.TabGrid[i]["$$SetSelected"](false)
  end
  for i = 0, #REF.Contents - 1 do
    WU.SetActive(REF.Contents[i].root)
  end
end

function ActiveTab(ptName)
  if ptName == m_curTabName then
    return
  end
  DeactiveTabs()
  REF["TabSlot" .. ptName]["$SetSelected"](true)
  local refContent = _ENV["$"](REF.root.transform:Find("WindowSize/Contents/" .. GetPTPrefabName(ptName))) or _ENV["$"](InstantiateContentPrefab(ptName))
  WU.SetActive(refContent.root, true)
  refContent["$Animator"]:Play("Page", -1, 0)
  m_curTabName = ptName
end

function InstantiateContentPrefab(ptName)
  local prefabName = GetPTPrefabName(ptName)
  local goContent = WU.InstantiateWindowPrefabAttached(REF.Contents, "ProgressTask/" .. prefabName, prefabName)
  WU.HandleGameObjectAttached(goContent)
  return goContent
end

function GetAcStatusMap(wlfName)
  local xlsxConfig = PB.get("ProgressTaskConfig", wlfName)
  local acStatusMap = {}
  table.insert(acStatusMap, PB.enum.ActivityStatus.Started)
  return acStatusMap
end

function GetPTPrefabName(ptName)
  if ptName then
    local prefabName = PB.get("ProgressTaskConfig", ptName).prefabName
    if prefabName == "" then
      return "PT" .. ptName
    else
      return prefabName
    end
  end
end
