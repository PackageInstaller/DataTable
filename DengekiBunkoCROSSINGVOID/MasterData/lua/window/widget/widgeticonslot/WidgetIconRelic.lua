inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_id, m_custom
local m_nameVisible = true

function ResetState()
  REF.TextureIcon.gameObject:SetActive(false)
  REF.SpriteIconBG.gameObject:SetActive(false)
  REF.ShowLock.gameObject:SetActive(false)
  m_id = nil
  m_custom = nil
end

function Draw()
  if m_id and 0 < m_id then
    local hollowInfo = PB.get("MazeEquipmentInfo", m_id)
    if hollowInfo == nil then
      error("MazeEquipmentInfo.xlsx has no id " .. m_id)
      return
    end
    REF.TextureIcon.UITexture.mainTexturePath = "Texture/HollowIcon/" .. hollowInfo.icon
    if hollowInfo then
      REF.SpriteIconBG.UISprite.spriteName = "icon_bg_3"
    else
      error("MazeEquipmentInfo", "Cannot find MazeEquipmentInfo by id: " .. tostring(m_id))
    end
  end
  if m_custom ~= nil then
    REF.ShowLock.gameObject:SetActive(m_custom.isLock == true)
  end
  REF.TextureIcon.gameObject:SetActive(true)
  REF.SpriteIconBG.gameObject:SetActive(true)
end

function SetData(id)
  ResetState()
  m_id = id
  MarkAsDirty()
end

function ShowCustom(data)
  m_custom = data
  MarkAsDirty()
end
