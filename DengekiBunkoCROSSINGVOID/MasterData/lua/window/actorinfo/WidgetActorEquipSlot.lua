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
  this:DelayInvokeInFrames(1, function()
    if not this:GetData("ActorEquipLevelup/EquipSpecified") then
      this:Bind("Actor/SelectedUid", OnSelectedActorUidChange)
    end
    this:Bind("Actor/Equip/SelectedPos", OnSelectedEquipPosChange)
  end)
end

function OnDisable()
  if not this:GetData("ActorEquipLevelup/EquipSpecified") then
    this:Unbind("Actor/SelectedUid", OnSelectedActorUidChange)
  end
  this:Unbind("Actor/Equip/SelectedPos", OnSelectedEquipPosChange)
end

function OnSelectedActorUidChange(uid)
  if m_actorUid then
    this:Unbind("fci/actor/" .. m_actorUid, OnActorChange)
  end
  m_actorUid = uid
  if m_actorUid then
    this:Bind("fci/actor/" .. uid, OnActorChange)
  end
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

function BindEquip(equipUid)
  if m_equipUid then
    this:Unbind("fci/equip/" .. m_equipUid, OnEquipChange)
  end
  m_equipUid = equipUid
  REF.NodeContent.gameObject:SetActive(false)
  if m_equipUid then
    this:Bind("fci/equip/" .. m_equipUid, OnEquipChange)
  end
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function OnButtonClick(go)
  WU.RecordButtonClick(80040)
  if m_equipPos and m_clickCallback then
    this:SetData("Actor/Equip/SelectedPos", m_equipPos)
    m_clickCallback(m_equipPos)
  end
end

function OnSelectedEquipPosChange(pos)
  UpdateHighlight()
end

function OnActorChange(actor)
  if actor then
    BindEquip(actor.bodyEquips[tostring(m_equipPos)])
    UpdateHighlight()
  end
end

function UpdateHighlight()
  REF.SpriteHighlight.gameObject:SetActive(m_showHighlight and m_equipPos and m_equipPos == this:GetData("Actor/Equip/SelectedPos"))
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
end
