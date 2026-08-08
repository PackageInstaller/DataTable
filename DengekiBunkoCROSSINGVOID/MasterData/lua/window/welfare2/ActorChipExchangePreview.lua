local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_chipList = {}
local m_actors = {}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  LU.Set(REF.WrapContent, 0)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateActorChipSlot
  })
  m_actors = this:GetData("fci/actor/")
  m_chipList = this:GetData("ActorChipExchange/OptionalChipList")
  OnActorChipChange(m_chipList)
end

function OnActorChipChange(chips)
  LU.Set(REF.WrapContent, #chips)
  m_chipList = chips
end

function UpdateActorChipSlot(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_chipList == nil or realIndex >= #m_chipList then
    return
  end
  local chip = m_chipList[realIndex + 1]
  rowRef["$$SetData"](chip)
  local wdgicon = _ENV["$"](rowRef.WidgetIconSlot)
  local data = {showChosen = false}
  wdgicon["$$ShowCustom"](data)
end
