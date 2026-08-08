local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local m_clickCallback, m_paletteMat

function Start()
  WU.BindButtonEvent(REF.root, OnClick)
  m_paletteMat = WU.AcquireAsset("Dependencies/Material/SpritePaletteForShow")
end

function Clear()
  WU.SetActive(REF.SkinPreview, false)
  WU.SetActive(REF.SpriteIndex, false)
  SetSelected(false)
end

function SetData(actorId, skinId, unlocked)
  WU.SetActive(REF.SkinPreview, true)
  local paletteIndex = AU.GetActorPaletteIndex(actorId, skinId)
  local go = REF.SkinPreview.ActorUIPreview:ResetActor(actorId, paletteIndex)
  local innerGo = go.transform:GetChild(0)
  _ENV["$"](innerGo)["$SpriteRenderer"].material = m_paletteMat
  CS.UnityEngine.GameObject.DestroyImmediate(_ENV["$"](innerGo)["$AnimationState2D"])
  local actorConfig = PB.get("ActorConfig", actorId)
  local paletteTex = WU.AcquireAsset("Dependencies/Sprite2D/Role/" .. actorConfig.prefabRes .. "/" .. actorConfig.prefabRes .. "_palette")
  _ENV["$"](innerGo)["$SpriteRenderer"].material:SetTexture("_PaletteTex", paletteTex)
  _ENV["$"](innerGo)["$SpriteRenderer"].material:SetInt("_PaletteIndex", paletteIndex)
  local resActorSkin = PB.get("ActorSkin", skinId)
  if resActorSkin then
    WU.SetActive(REF.SpriteIndex, true)
    REF.SpriteIndex.UISprite.spriteName = string.format("ActorSkin_number_%d", resActorSkin.displayIndex)
  else
    WU.SetActive(REF.SpriteIndex, false)
  end
  local alpha = fif(unlocked, 1, 0.5)
  REF.NodeView.UIWidget.alpha = alpha
  local sprr = REF.root.transform:GetComponentInChildren(typeof(CS.UnityEngine.SpriteRenderer), true)
  local color = sprr.color
  color.a = alpha
  sprr.color = color
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function SetSelected(selected)
  WU.SetActive(REF.SpriteSelected, selected)
end

function OnClick(go)
  if m_clickCallback then
    m_clickCallback(go)
  end
end
