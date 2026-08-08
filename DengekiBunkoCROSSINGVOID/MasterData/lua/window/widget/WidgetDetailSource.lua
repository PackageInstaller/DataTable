local WU, DB, REF = require("Common/WindowUtil")(this)
local GotoUtil = require("Common/GotoUtil")
local LU = require("Common/ListUtil")
local Height = {item = 430, equip = 680}
local m_sourcesData

function Awake()
  LU.Bind(REF.WrapContentItemSource, {
    updateRow = UpdateItemSourceSlot
  })
  WU.TraverseChildren(REF.WrapContentItemSource, function(go)
    WU.BindButtonEvent(_ENV["$"](go)["$"], OnItemSourceClick)
  end)
end

function SetData(data, mode)
  m_sourcesData = data
  REF["$UIWidget"].height = Height[mode]
  WU.ToggleRendering(REF.NodeEmpty, #m_sourcesData == 0)
  LU.Set(REF.WrapContentItemSource, #m_sourcesData)
end

function UpdateItemSourceSlot(ref, wrapIndex, realIndex)
  if m_sourcesData and realIndex < #m_sourcesData then
    local sourceData = m_sourcesData[realIndex + 1]
    ref.Label.UILabel.text = WU.GetString("Goto_" .. sourceData.id)
    ref["@windowName"] = sourceData.windowName
    ref["@params"] = sourceData.params
    ref["$UIWidget"].alpha = 0.5
    GotoUtil.Goto(sourceData.windowName, sourceData.params, true, function()
      ref["$UIWidget"].alpha = 1
    end)
  end
end

function OnItemSourceClick(go)
  local windowName = _ENV["$"](go)["@windowName"]
  local params = _ENV["$"](go)["@params"]
  if windowName ~= "None" then
    GotoUtil.Goto(windowName, params)
  end
end
