local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local m_actorUid, m_equipPos, m_equipUid, m_clickCallback
local m_showHighlight = true

function Start()
  WU.BindButtonEvent(REF["$"], OnButtonClick)
end

function OnEnable()
end

function OnDisable()
end

function SetShowHighlight(showHighlight)
  m_showHighlight = showHighlight
end

function SetEquipPos(pos)
  if not pos or m_equipPos ~= pos then
    m_equipPos = pos
    if m_equipPos then
      REF.SpritePos.UISprite.spriteName = EU.EquipPosSpriteNameTable[m_equipPos + 1]
    end
    REF.SpritePos.gameObject:SetActive(m_equipPos)
    REF.NodeContent.gameObject:SetActive(false)
    REF.SpriteRedPoint.gameObject:SetActive(false)
  end
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function OnButtonClick(go)
  if m_equipPos and m_clickCallback then
    this:SetData("Actor/Equip/SelectedPos", m_equipPos)
    m_clickCallback(m_equipPos)
  end
end

function OnEquipChange(equip)
  if equip then
    m_equipUid = equip.uid
    REF.NodeContent.gameObject:SetActive(true)
    local equipInfo = PB.get("EquipInfo", equip.id)
    if equipInfo then
      REF.TextureIcon.UITexture.mainTexturePath = "Texture/EquipIcon/" .. equipInfo.icon
      REF.SpriteFrame.UISprite.spriteName = "icon_bg_" .. equipInfo.quality
    end
    REF.LabelLevel.UIHtmlLabel.text = WU.GetString("Window_Level", equip.level)
  else
    m_equipUid = nil
    REF.NodeContent.gameObject:SetActive(false)
  end
  UpdateHighlight()
end

function UpdateHighlight()
  REF.SpriteHighlight.gameObject:SetActive(m_showHighlight and m_equipPos and m_equipPos == this:GetData("Actor/Equip/SelectedPos"))
end
