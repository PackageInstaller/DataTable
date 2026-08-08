local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local m_clickCallback

function Start()
  WU.BindButtonEvent(REF.ButtonSlot, function()
    if m_clickCallback then
      m_clickCallback(REF.root.gameObject)
    end
  end)
end

function SetData(playerData)
  REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](playerData)
  REF.LabelName.UILabel.text = playerData.name
  REF.LabelLevel.UILabel.text = "Lv." .. playerData.level
end

function SetSelected(selected)
  WU.SetActive(REF.SpriteSelected, selected)
end

function SetSent(sent)
  WU.SetActive(REF.LabelSent, sent)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end
