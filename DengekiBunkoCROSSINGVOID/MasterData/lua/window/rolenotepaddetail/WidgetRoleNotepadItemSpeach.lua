local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local HU = require("Common/HtmlUtil")

function SetData(itemSpeachData)
  local text = WU.GetString("AnaContent_" .. itemSpeachData.id)
  if not itemSpeachData.unlocked then
    local len = string.len(text)
    text = ""
    for i = 1, len do
      text = text .. "?"
    end
  end
  REF.LabelDesc.UILabel.text = text
  WU.BindButtonEvent(REF.IconSpeaker, function()
    m_kNowAudioSource = SDU.PlayActorWiki(itemVoiceData.role)
  end)
end
