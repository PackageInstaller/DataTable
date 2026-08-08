local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local SU = require("Common/SortUtil")
local TU = require("Common/TaskUtil")
local IconSwitch = {
  Normal = {
    atlasName = "Common",
    advancedSprite = "filter",
    normalSprite = "sort"
  },
  Small = {
    atlasName = "ActorUI",
    advancedSprite = "filter",
    normalSprite = "sort"
  }
}
local AlternativeCompare = {
  [32] = 1,
  [33] = 2,
  [34] = 3,
  [35] = 20,
  [36] = 21,
  [37] = 5,
  [38] = 4,
  [39] = 40
}
local DefaultFilter = {
  kind = 0,
  tags1 = 0,
  tags2 = 0
}
local m_sortLocalContext, m_sortMate, m_advancedFilters

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonSortAdvanced, function()
    OpenSortFullScreen()
  end)
  WU.BindButtonEvent(REF.ButtonSort, function()
    REF.DropList.gameObject:SetActive(true)
  end)
  WU.BindButtonEvent(REF.DropListButtonMask, function()
    REF.DropList.gameObject:SetActive(false)
  end)
  WU.TraverseChildren(REF.DropListGrid, function(go, index)
    WU.BindButtonEvent(go, function(go)
      local ref = _ENV["$"](go)
      if ref["@advancedModeBtn"] then
        TU.TaskFirstCheck(PB.enum.UseFuncMTimes.ChangeSortMethod)
        OpenSortFullScreen()
      else
        local reverse = fif(index == m_sortMate.tabIndex, not m_sortMate.reverse, true)
        this:BroadcastGameEvent("ClearNewFlags")
        this:BroadcastGameEvent("Sort/CurrentReverse", reverse)
        RecordSortOptionClick(m_sortMate.ids[index], reverse)
        ApplySortAlternative(index, reverse, m_advancedFilters)
      end
    end)
  end)
end

function InitWindow()
  REF.root.gameObject:SetActive(true)
  m_sortLocalContext = WU.GetGameDataCache("SortLocalContext") or {}
  this:Bind("SortMate/Current", OnCurrentSortMate)
  this:RegisterGameEvent("ApplySortAlternativeRemainFilters", function(index, reverse)
    ApplySortAlternative(index, reverse, m_advancedFilters)
  end)
  this:RegisterGameEvent("ApplySortAlternative", ApplySortAlternative)
  this:RegisterGameEvent("SortModeChanged", AdvancedModeDisplay)
  this:RegisterGameEvent("SortActiveChange", ChangeActive)
end

function OnCurrentSortMate(sortMate)
  this:SetData("SortName", nil)
  local toggle = sortMate ~= nil and U.ToInt(sortMate.type) ~= PB.enum.SortType.NoType
  WU.ToggleRendering(REF.ToggleSort, toggle)
  if toggle then
    m_sortMate = sortMate
    AdvancedModeDisplay()
    InitDropList(sortMate)
    InitAlternative(sortMate)
  end
end

function AdvancedModeDisplay(isAdvancedMode)
  m_sortLocalContext.advancedMode = fif(isAdvancedMode == nil, m_sortLocalContext.advancedMode, isAdvancedMode)
  local showAdvancedMode = m_sortLocalContext.advancedMode and m_sortMate.advancedMode
  REF.ButtonSortAdvanced.gameObject:SetActive(showAdvancedMode)
  REF.DropList.gameObject:SetActive(not showAdvancedMode)
  REF.ButtonSort.gameObject:SetActive(not showAdvancedMode)
end

function InitDropList(sortMate)
  REF.DropList.gameObject:SetActive(false)
  local xlsxDataSet = SU.GetXlsxSortData(sortMate)
  if table.empty(xlsxDataSet) then
    error("Sort", "SortMate ids error!")
    return
  end
  local tabCount = fif(sortMate.advancedMode, #xlsxDataSet + 1, #xlsxDataSet)
  local dropListLen = #REF.DropListGrid
  for i = 0, dropListLen - 1 do
    local btnRef = REF.DropListGrid[i]
    btnRef["$gameObject"]:SetActive(i < tabCount)
    if i < tabCount then
      local xlsxData = xlsxDataSet[i + 1]
      if xlsxData ~= nil then
        btnRef.DropListLabelItem.UILabel.text = WU.GetString(xlsxData.localization)
        btnRef.DropListLabelItemSelected.UILabel.text = WU.GetString(xlsxData.localization)
      else
        btnRef.DropListLabelItem.UILabel.text = WU.GetString("Sort_AdvancedMode")
      end
      btnRef.AdvancedSprite.gameObject:SetActive(xlsxData == nil)
      btnRef["@advancedModeBtn"] = xlsxData == nil
      btnRef["@data"] = xlsxData
    end
  end
  local height = REF.DropListGrid.UIGrid.cellHeight
  REF.DropList.UISprite.height = math.floor(height * tabCount + height * 0.5)
  local icon = fif(sortMate.smallIcon, IconSwitch.Small, IconSwitch.Normal)
  REF.ButtonSortAdvanced.UISprite.atlasPath = icon.atlasName
  REF.ButtonSortAdvanced.UISprite.spriteName = icon.advancedSprite
  REF.ButtonSort.UISprite.atlasPath = icon.atlasName
  REF.ButtonSort.UISprite.spriteName = icon.normalSprite
  REF.ButtonSortAdvanced.UISprite:SnapWithoutScale()
  REF.ButtonSort.UISprite:SnapWithoutScale()
  REF.ToggleSort.transform.localPosition = sortMate.togglePosition
end

function InitAlternative(sortMate)
  local function CreateAdvancedFilter(context)
    if sortMate.advancedMode then
      local tb = {}
      
      if context == nil then
        table.copy(DefaultFilter, tb)
        tb.contextName = sortMate.contextName
      else
        table.copy(context, tb)
      end
      return tb
    end
  end
  
  local context = m_sortLocalContext[sortMate.contextName]
  local advancedFilters = CreateAdvancedFilter(context)
  if context ~= nil then
    local dropListLen = #REF.DropListGrid
    for i = 0, dropListLen - 1 do
      local btnRef = REF.DropListGrid[i]
      if btnRef["@data"] and IsSameAlternative(btnRef["@data"].id, context.id) then
        ApplySortAlternative(i, context.reverse, advancedFilters)
        return
      end
    end
  end
  ApplySortAlternative(0, true, advancedFilters)
end

function ApplySortAlternative(tabIndex, reverse, advancedFilters)
  if advancedFilters and advancedFilters.contextName ~= m_sortMate.contextName then
    return
  end
  if tabIndex < 0 or tabIndex > #REF.DropListGrid - 1 then
    tabIndex = 0
  end
  local btnRef = REF.DropListGrid[tabIndex]
  if btnRef["@data"] == nil then
    tabIndex = 0
    btnRef = REF.DropListGrid[tabIndex]
  end
  DeselectedAllBtn()
  btnRef.DropListNodeSelected.gameObject:SetActive(true)
  btnRef.DropListSpriteSeqTagChild.UISprite.flip = fif(reverse, CS.UISprite.Flip.Nothing, CS.UISprite.Flip.Vertically)
  m_sortMate.tabIndex = tabIndex
  m_sortMate.reverse = reverse
  this:SetData("SortFinished", {
    list = SU.SortByXlsxData(btnRef["@data"], reverse),
    sortMate = m_sortMate,
    advancedFilters = advancedFilters
  })
  m_advancedFilters = advancedFilters
  SaveSortContext(btnRef["@data"], reverse)
end

function SaveSortContext(xlsxData, reverse)
  if U.trim(m_sortMate.contextName) == "" then
    return
  end
  local context = m_sortLocalContext[m_sortMate.contextName] or {}
  context.id = xlsxData.id
  context.reverse = reverse
  if m_sortMate.advancedMode then
    context.contextName = context.contextName or m_sortMate.contextName
    context.kind = context.kind or 0
    context.tags1 = context.tags1 or 0
    context.tags2 = context.tags2 or 0
  end
  m_sortLocalContext[m_sortMate.contextName] = context
  WU.SetGameDataCache("SortLocalContext", m_sortLocalContext)
end

function OpenSortFullScreen()
  WU.AcquireWindowAsync("SortFullScreen", function(ui)
    this:BroadcastGameEvent("SortModeChanged", true)
  end)
end

function DeselectedAllBtn()
  WU.TraverseChildren(REF.DropListGrid, function(go)
    _ENV["$"](go).DropListNodeSelected.gameObject:SetActive(false)
  end)
end

function IsSameAlternative(id1, id2)
  return id1 == id2 or AlternativeCompare[id1] == id2 or AlternativeCompare[id2] == id1
end

function RecordSortOptionClick(sortID, reverse)
  if sortID and reverse then
    this:SetData("SortName", sortID .. "H")
  else
    this:SetData("SortName", sortID .. "L")
  end
end

function ChangeActive(flag)
  REF.root.gameObject:SetActive(flag)
end
