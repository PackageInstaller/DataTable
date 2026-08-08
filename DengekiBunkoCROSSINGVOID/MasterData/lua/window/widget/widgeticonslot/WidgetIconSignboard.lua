inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local m_id, m_callback

function ResetState()
  m_id = nil
end

function Draw()
  if m_id then
    local signboardConfig = PB.get("Signboard", m_id)
    REF.TextureHead.UITexture.mainTexturePath = "Texture/ItemIcon/ResSignBoard_" .. signboardConfig.BoardOfAnimRes
  end
end

function SetData(id)
  ResetState()
  m_id = id
  MarkAsDirty()
end

function OnClick()
  if m_callback then
    m_callback()
  end
end
