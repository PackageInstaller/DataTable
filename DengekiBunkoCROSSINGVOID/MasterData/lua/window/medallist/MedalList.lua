local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local m_allMedals, m_categoriedMedals
local m_curCategory = 0
local m_showAll = true
local m_newMedals

function SetupWindow()
  m_allMedals = PB.all("MedalInfo"):select(function(m)
    return {
      id = m.id,
      category = m.category,
      order = m.order,
      hide = m.hide
    }
  end)
  table.sort(m_allMedals, function(a, b)
    if a.order ~= b.order then
      return a.order < b.order
    else
      return a.id < b.id
    end
  end)
  for type = 0, PB.enum.MedalCategory.Count - 1 do
    local goRef = REF.TypeTabs[type]
    local content = WU.GetString("MedalCategory_" .. type)
    local spriteName = "medal_category_" .. type
    goRef["$$SetTab"](content, "MedalIcon", spriteName, false)
    goRef["$$SetClickCallback"](function(go)
      m_curCategory = type
      Show()
    end)
  end
  CS.EventDelegate.Add(REF.ToggleShowNotObtain.UIToggle.onChange, function()
    m_showAll = CS.UIToggle.current.value
    if m_categoriedMedals ~= nil then
      CategoryMedals()
      Show()
    end
  end)
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_categoriedMedals and m_categoriedMedals[m_curCategory][dataIndex]
    end,
    updateSlot = UpdateMedalSlot,
    delta = 0.01,
    slotsName = "Grid"
  })
end

function InitWindow()
  m_newMedals = {}
  WU.ToggleRendering(REF.Content, false)
  REF.TypeTabs[0].root["$SetSelected"]()
  this:Bind("fci/medal/", OnListChange)
end

function UninitWindow()
  SU.ClearNewFlag(PB.enum.ResourceType.ResMedal, m_newMedals)
end

function OnListChange(list)
  if list == nil then
    return
  end
  WU.ToggleRendering(REF.Content, true)
  local collectedCountStr = tostring(#list)
  local firstletterCollected = string.sub(collectedCountStr, 1, 1)
  local otherLetterCollected = string.sub(collectedCountStr, 2, string.len(collectedCountStr))
  REF.LabelNowCountFirst.UILabel.text = firstletterCollected
  REF.LabelNowCountOthers.UILabel.text = otherLetterCollected
  for _, m in pairs(m_allMedals) do
    local _, obtainedMedal = table.find(list, function(k, v)
      return v.id == m.id
    end)
    if obtainedMedal == nil then
      m.obtained = false
      m.isNew = false
      m.expireTime = 0
    else
      m.obtained = true
      m.isNew = obtainedMedal.isNew
      m.expireTime = obtainedMedal.expireTime
    end
  end
  for i = 1, #list do
    if list[i].isNew then
      table.insert(m_newMedals, list[i])
    end
  end
  CategoryMedals()
  Show()
end

function UpdateMedalSlot(ref, info)
  if info == nil then
    ref["$$ClearSlot"]()
  else
    ref["$$SetData"](PB.enum.ResourceType.ResMedal, info.id)
    ref["$$ShowCustom"]({
      isNew = info.isNew,
      name = true,
      obtained = info.obtained
    })
    ref["$$SetClickCallback"](function()
      WU.RecordButtonClick(100136501)
      WU.ShowMedalDetail(info.id, info.obtained, info.expireTime, "MedalList")
    end)
    ref["$$SetNameVisible"](true)
  end
end

function CategoryMedals()
  m_categoriedMedals = {}
  m_categoriedMedals[0] = {}
  local isPreCommit = WU.IsPreCommit()
  for _, m in pairs(m_allMedals) do
    local hideSpecial = false
    hideSpecial = m.id == 80005
    if m.obtained or not m.hide and not hideSpecial and m_showAll then
      if m_categoriedMedals[m.category] == nil then
        m_categoriedMedals[m.category] = {}
      end
      if isPreCommit then
        if m.category ~= 4 then
          table.insert(m_categoriedMedals[m.category], m)
          table.insert(m_categoriedMedals[0], m)
        end
      else
        table.insert(m_categoriedMedals[m.category], m)
        table.insert(m_categoriedMedals[0], m)
      end
    end
  end
end

function Show()
  local noMedal = m_categoriedMedals == nil or m_categoriedMedals[m_curCategory] == nil or #m_categoriedMedals[m_curCategory] == 0
  WU.ToggleRendering(REF.DragBG, not noMedal)
  WU.ToggleRendering(REF.NodeEmpty, noMedal)
  if not noMedal then
    LU.Set(REF.WrapContent, math.ceil(#m_categoriedMedals[m_curCategory] / #REF.WrapContent[0].Grid))
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001365, on)
end
