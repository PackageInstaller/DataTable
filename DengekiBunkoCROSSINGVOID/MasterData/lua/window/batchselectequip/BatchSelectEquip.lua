local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_selectionTable = {}
local m_beginQuality = PB.enum.EquipQuality.Green

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    WU.RecordButtonClick(106012)
    OnButtonConfirm()
  end)
  WU.BindButtonEvent(REF.ButtonCancel, function()
    WU.RecordButtonClick(106013)
    OnCancelClick()
  end)
  SetupQualitySlots()
end

function SetupQualitySlots()
  for i = 0, #REF.AllQuality - 1 do
    local quality = i + m_beginQuality
    local qualityItem = REF.AllQuality[i]
    qualityItem["@quality"] = quality
    qualityItem["$$SetData"](PB.enum.ResourceType.ResEquip, -quality)
    qualityItem["$$SetBottomText"](WU.GetString("EquipQuality_" .. quality))
    qualityItem["$$SetSelected"](true)
    qualityItem["$$SetClickCallback"](OnSlotClick)
  end
end

function InitWindow()
  for i = 0, #REF.AllQuality - 1 do
    local quality = i + m_beginQuality
    m_selectionTable[quality] = false
    REF.AllQuality[i]["$$SetSelected"](m_selectionTable[quality])
  end
end

function OnSlotClick(go)
  local quality = _ENV["$"](go)["@quality"]
  WU.RecordButtonClick(106090 + quality)
  m_selectionTable[quality] = not m_selectionTable[quality]
  _ENV["$"](go)["$$SetSelected"](m_selectionTable[quality])
end

function OnButtonConfirm()
  local selectedQuality = {}
  for k, v in pairs(m_selectionTable) do
    if v then
      table.insert(selectedQuality, k)
    end
  end
  this:SetData("SelectedQuality", selectedQuality)
  OnCancelClick()
end

function OnCancelClick()
  WU.RecycleWindow("BatchSelectEquip")
end

function Focus()
  WU.RecordWindowFocus(100106, true)
end
