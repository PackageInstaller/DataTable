local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_kCallback
local m_bSelected = false

function Start()
  WU.BindButtonEvent(REF.ButtonSlot, OnTabClick)
end

function OnTabClick(go)
  if m_kCallback ~= nil then
    m_kCallback(go)
  end
end

function SetClickCallback(callback)
  m_kCallback = callback
end

function SetSelected(selected)
  m_bSelected = selected
  REF.BG_Selected.gameObject:SetActive(selected)
end

function IsSelected()
  return m_bSelected
end

function SetData(dataItem)
  if dataItem.isShowEmpty then
    REF.Visual.gameObject:SetActive(false)
    return
  else
    REF.Visual.gameObject:SetActive(true)
  end
  REF.IconTextureActor.UITexture.mainTexturePath = "Texture/ActorGroup/selectteam_" .. PB.get("ActorConfig", dataItem.id).animRes
  REF.IconTextureActor.UITexture.solidColor = not dataItem.unlock
  if dataItem.kind == PB.enum.ActorType.Main then
    REF.IconActorBattleType.gameObject:SetActive(false)
  else
    REF.IconActorBattleType.gameObject:SetActive(true)
  end
  if not dataItem.unlock then
    REF.IconTextureActor.UITexture.color = CS.NGUIMath.HexToColor(2931215615)
  else
    REF.IconTextureActor.UITexture.color = CS.NGUIMath.HexToColor(4294967295)
  end
  REF.IconActorName.UISprite.spriteName = "actor_name_" .. dataItem.animRes
  REF.IconActorType.UISprite.spriteName = "actor_type_" .. dataItem.id
  REF.IconActorSmallName.UISprite.spriteName = "actor_name_s_" .. dataItem.animRes
  REF.IconActorName.UISprite:SnapWithoutScale()
  REF.BGItem.UISprite.color = CS.NGUIMath.HexToColor(4294967295)
end

function SetEmpty()
  WU.SetActive(REF.BG_Selected, false)
  WU.SetActive(REF.IconTextureActor, false)
  WU.SetActive(REF.IconActorTypeBg, false)
  WU.SetActive(REF.IconActorBattleType, false)
  WU.SetActive(REF.IconActorSmallName, false)
  WU.SetActive(REF.IconActorName, false)
  REF.BGItem.UISprite.color = CS.NGUIMath.HexToColor(4294967167)
end
