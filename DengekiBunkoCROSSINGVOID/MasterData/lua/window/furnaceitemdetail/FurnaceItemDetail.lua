local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local LU = require("Common/ListUtil")
local S = require("Common/Singleton")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local m_item
local m_count = 0
local m_init = true
local m_showTip = false
local m_pressTime = 0
local m_hideTime = 1

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonIncrease, function()
    SetCount(1)
  end)
  WU.BindButtonEvent(REF.ButtonDecrease, function()
    SetCount(-1)
  end)
  WU.BindButtonEvent(REF.ButtonMax, function()
    SetCount(m_item.count)
  end)
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    WU.RecycleWindow(this)
  end)
  CS.EventDelegate.Add(REF.CountSlider.UISlider.onChange, OnSlider)
end

function SetItem(item)
  m_item = item
  m_count = m_item.selectCnt
  m_init = true
  m_showTip = false
  local detailText = "<font size=46>" .. WU.GetString("ItemName_" .. m_item.id) .. "</font><br><br>"
  detailText = detailText .. WU.GetItemDesc(m_item.id)
  REF.LabelDetail.UIHtmlLabel.text = detailText
  REF.LabelCount.UIHtmlLabel.text = WU.GetString("WindowItem_OwnCount") .. ": " .. m_item.count
  REF.ItemUse["$SetData"](m_item.type, m_item.id, m_count)
  REF.CountSlider.UISlider.value = m_count / m_item.count
  UpdateCount()
  m_init = false
end

function SetCount(pace)
  m_count = m_count + pace
  REF.CountSlider.UISlider.value = m_count / m_item.count
  UpdateCount()
end

function OnSlider()
  if m_item == nil then
    return
  end
  local val = REF.CountSlider.UISlider.value
  if U.CutNum(val, 3) == U.CutNum(m_count / m_item.count, 3) then
    return
  end
  if not m_init then
    m_count = math.floor(m_item.count * val + 0.5)
  end
  REF.CountSlider.UISlider.value = m_count / m_item.count
  UpdateCount()
end

function ShowTip()
  m_pressTime = 0
  m_showTip = true
end

function UpdateCount()
  m_count = math.clamp(m_count, 0, m_item.count)
  m_item.selectCnt = m_count
  WU.SetLabel(REF.LabelCountTip, m_count)
  this:BroadcastGameEvent("Furnace/OnCountChange")
  REF.ItemUse["$SetData"](m_item.type, m_item.id, m_count)
  local itemBack = WU.GetFurnaceItemBack(m_item)
  REF.ItemGet["$SetData"](itemBack.type, itemBack.id, itemBack.count)
  if not m_init then
    ShowTip()
  end
end

function UpdateWindow(deltaTime)
  m_pressTime = m_pressTime + deltaTime
  if m_pressTime > m_hideTime then
    m_showTip = false
  end
  REF.SpriteCountTip.gameObject:SetActive(m_showTip)
end
