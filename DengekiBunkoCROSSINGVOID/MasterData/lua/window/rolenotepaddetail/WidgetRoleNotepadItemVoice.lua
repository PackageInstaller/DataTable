local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_callback, m_data

function Start()
  WU.BindButtonEvent(REF.IconSpeaker, function()
    if m_data and m_data.unlocked and m_callback then
      m_callback()
    end
  end)
end

function SetCallback(callback)
  m_callback = callback
end

function SetData(data)
  m_data = data
  local text = "????????????????????????????????????????"
  if data.voiceType == PB.enum.RoleNotepadVoiceType.RVT_BOARD then
    local row = PB.get("BoardVoice2Text", data.audioText)
    if row ~= nil then
      text = ""
      for i = 1, #row.data do
        local tmp = WU.GetString(row.data[i].localizationText)
        text = text .. tmp
      end
    else
      error("RoleNotePadDetail", "\232\175\165emote\230\178\161\230\156\137\229\175\185\229\186\148\231\154\132\232\175\173\233\159\179\230\150\135\229\173\151\239\188\140\232\175\183\233\133\141\231\189\174 BoardVoice2Text ")
    end
  else
    text = WU.GetString(data.audioText)
  end
  if data.unlocked then
    REF.IconSpeaker.UISprite.color = CS.NGUIMath.HexToColor(3568812031)
  else
    REF.IconSpeaker.UISprite.color = CS.NGUIMath.HexToColor(2593823487)
    text = "????????????????????????????????????????"
  end
  REF.LabelDesc.UILabel.text = text
end
