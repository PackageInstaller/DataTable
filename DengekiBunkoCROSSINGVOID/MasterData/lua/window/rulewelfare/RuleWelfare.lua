local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local ShowRolePresent = 9
local m_activityManager = S:Get("ActivityManager")
local m_sealActivityInfo, m_postcardActivityInfo, m_tenChekinActivityInfo, m_rolePresents, m_everyDayCheckinId

function SetupWindow()
  CreateTab()
  local res = PB.all("DropDisplayDailySignin")
  LU.Bind(REF.WrapContent, {
    dataSource = res,
    updateSlot = OnItemSlotShow
  })
  LU.Set(REF.WrapContent, math.ceil(#res / #REF.WrapContent[0].root))
end

function InitWindow()
  GetEveryDayCheckinId()
  SetTab()
  local activeTabName = this:GetData("WelfareHelpTab")
  REF[activeTabName].UIToggle.value = true
  REF.ScrollViewTab.UIScrollView:ResetPosition()
  local index = -1
  for i = 0, REF.TabGrid.transform.childCount - 1 do
    local obj = REF.TabGrid[i].root.gameObject
    if obj.gameObject.activeSelf then
      index = index + 1
      if obj.gameObject.name == activeTabName then
        break
      end
    end
  end
  if 4 < index then
    local itemHeight = REF.TabGrid.UIGrid.cellHeight
    local m_moveDistance = index * itemHeight
    REF.ScrollViewTab.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, m_moveDistance, 0))
    REF.ScrollViewTab.UIScrollView:RestrictWithinBounds(true)
  end
end

function OnItemSlotShow(ref, item)
  _ENV["$"](ref.WidgetIconSlot)["$$SetData"](item.type, item.id, item.count)
  ref.LabelProbability.UILabel.text = string.format("%.1f%%", item.probability / 100)
end

function CreateTab()
  local allTab = PB.all("WelfareConfig")
  local go = REF.TabGrid[0].root.gameObject
  local tabCopy = {}
  local keyTabs = {}
  for k, v in pairs(allTab) do
    table.insert(keyTabs, k)
  end
  table.sort(keyTabs, function(a, b)
    return a < b
  end)
  for k, v in pairs(keyTabs) do
    table.insert(tabCopy, allTab[v])
  end
  for i, config in pairs(tabCopy) do
    local tabName = config.helpTabName
    if tabName == "" then
      tabName = config.name
    end
    local tabRef = reRef(REF.TabGrid)
    local tab = tabRef[tabName]
    local ref
    if tab == nil then
      local g = CS.NGUITools.AddChild(REF.TabGrid.gameObject, go)
      g.name = tabName
      ref = _ENV["$"](g)
      local tabLocale = config.tabLocale
      if tabLocale == "" then
        tabLocale = "WelfareTabName_" .. config.name
      end
      ref.LabelButton.UIHtmlLabel.text = WU.GetString(tabLocale)
      ref.SpriteIcon.UISprite.atlasPath = config.tabIconAtlasPath
      ref.SpriteIcon.UISprite.spriteName = config.tabIconSpriteName
      ref.SpriteIcon.UISprite:SnapWithoutScale()
    else
      ref = _ENV["$"](tab)
      tab.transform:SetSiblingIndex(i - 1)
    end
    CS.EventDelegate.Add(ref.root.UIToggle.onChange, function()
      if CS.UIToggle.current.value and tabName ~= "Checkin" then
        WU.SetActive(REF.ScrollViewText, true)
        REF.LabelHelp.UIHtmlLabel.text = WU.GetString("Help_" .. tabName)
        REF.ScrollViewHelp.UIScrollView:ResetPosition()
      end
    end)
  end
  REF.TabGrid.UIGrid:Reposition()
end

function SetTab()
  local welfareUI = WU.FindWindow("Welfare")
  local actorCultivationVisible = false
  local customActorCultivationVisible = false
  WU.TraverseChildren(_ENV["$"](welfareUI).TabGrid, function(go)
    local tabName = string.sub(go.name, #"TabSlot" + 1)
    local tab = REF[tabName]
    if tab == nil then
      if go.name:find("CustomActorCultivation") ~= nil and go.activeSelf then
        customActorCultivationVisible = true
      elseif go.name:find("ActorCultivation") ~= nil and go.activeSelf then
        actorCultivationVisible = true
      end
    else
      if go.name == "TabSlotEveryDayCheckin" then
        if m_everyDayCheckinId == 46001 or m_everyDayCheckinId == 46004 then
          _ENV["$"](tab).LabelButton.UIHtmlLabel.text = WU.GetString("WindowEveryDayCheckin_Name1")
        elseif m_everyDayCheckinId == 46003 then
          _ENV["$"](tab).LabelButton.UIHtmlLabel.text = WU.GetString("WindowEveryDayCheckin_Name3")
        end
      end
      tab.gameObject:SetActive(go.activeSelf)
    end
  end)
  if REF.ActorCultivation ~= nil then
    REF.ActorCultivation.gameObject:SetActive(actorCultivationVisible)
  end
  if REF.CustomActorCultivation ~= nil then
    REF.CustomActorCultivation.gameObject:SetActive(customActorCultivationVisible)
  end
  REF.TabGrid.UIGrid:Reposition()
end

function GetEveryDayCheckinId()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.EveryDayCheckin, function(activityList)
    if activityList and not WU.WindowIsLocked(PB.enum.UnlockWindow.Welfare) then
      for k, v in pairs(activityList) do
        if v.type == PB.enum.ActivityType.EveryDayCheckin and ACU.IsOpenForDoing(v) then
          m_everyDayCheckinId = v.activityId
          break
        end
      end
    end
  end)
end
