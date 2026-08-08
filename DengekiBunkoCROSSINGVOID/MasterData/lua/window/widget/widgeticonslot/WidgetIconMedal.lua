inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_id, m_custom
local m_nameVisible = true
local m_spriteIconAtlas

function ResetState()
  REF.SpriteIcon.UISprite.solidColor = false
  REF.SpriteIcon.UISprite.alpha = 1
  REF.NameNode.gameObject:SetActive(false)
  REF.SpriteNew.gameObject:SetActive(false)
  REF.SpriteEquipedMedal.gameObject:SetActive(false)
  m_id = nil
  m_custom = nil
  SetNameVisible(false)
end

function SetNameVisible(b)
  m_nameVisible = b
end

function Draw()
  if m_id and 0 < m_id then
    local medalInfo = PB.get("MedalInfo", m_id)
    REF.SpriteIcon.UISprite.atlasPath = m_spriteIconAtlas
    REF.SpriteIcon.UISprite.spriteName = "medal_icon_" .. m_id
    REF.NameNode.gameObject:SetActive(m_nameVisible)
    REF.NameLabel.UILabel.text = WU.GetString("MedalName_" .. m_id)
    if medalInfo then
      REF.SpriteIconBG.UISprite.spriteName = "icon_bg_" .. medalInfo.quality
    else
      error("MedalInfo", "Cannot find MedalInfo by id: " .. tostring(m_id))
    end
  end
  if m_custom ~= nil then
    local solidIcon = m_custom.obtained ~= nil and not m_custom.obtained
    REF.SpriteIcon.UISprite.solidColor = solidIcon
    REF.SpriteIcon.UISprite.alpha = fif(solidIcon, 0.5, 1)
    REF.SpriteNew.gameObject:SetActive(m_custom.isNew or false)
    REF.SpriteEquipedMedal.gameObject:SetActive(m_custom.isFight)
  end
end

function SetData(id)
  m_id = id
  m_spriteIconAtlas = fif(8000 <= id and id < 10000, "MedalIcon2", "MedalIcon")
  MarkAsDirty()
end

function ShowCustom(data)
  m_custom = data
  MarkAsDirty()
end
