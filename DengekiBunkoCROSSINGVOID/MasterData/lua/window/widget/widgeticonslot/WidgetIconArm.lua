inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_id, m_callback, m_custom, m_arm, ref
local m_size = "N"
local m_mainTexture, m_content

function ResetState()
  m_id = nil
  m_arm = nil
  m_size = "N"
  m_mainTexture = nil
end

function Draw()
  if m_id and m_id ~= 0 and m_size then
    local info = PB.get("UniqueWeaponInfo", m_id)
    if info == nil then
      warning("UniqueWeaponInfo No such Id : " .. m_id)
      return
    end
    local phase
    local quality = info.quality
    local position = info.position
    local maxPhase = U.ToInt(PB.all("Misc"):first().weaponMisc.weaponMaxPhase) - 1
    local postFix = ""
    if m_arm then
      local starStr = ""
      postFix = "_" .. m_arm.cardSkinIndex
      for i = 1, maxPhase do
        starStr = starStr .. "<img src='ImpressionCard.impression_star_s" .. fif(i <= m_arm.phase, "", "_dark") .. "'/>"
      end
      WU.SetLabel(ref.LabelStar, starStr)
      WU.SetLabel(ref.LabelLevel, "Lv." .. m_arm.level)
      ref.SpriteStarBg.UISprite.spriteName = "impression_star_mask_" .. quality - 2
      ref.LevelBg.UISprite.spriteName = "impression_mask_" .. quality - 2
      ref.SpriteNew.gameObject:SetActive(m_arm.isNew)
      ref.ArmFrame.gameObject:SetActive(IsFullPhase(m_arm.phase))
      ref.SpritePos.gameObject:SetActive(m_arm.position == 2)
      ref.SpritePos.UISprite.spriteName = "impression_sub_" .. quality - 2
    end
    if m_custom then
      WU.SetLabel(ref.LabelCenter, m_custom.centerText)
      WU.SetActive(ref.SpriteUsing, m_custom.showUsing)
      WU.SetActive(ref.SpriteCenter, m_custom.centerText)
      WU.SetActive(ref.LevelBg, not m_custom.hideLevel)
      WU.SetActive(ref.SpriteSelect, m_custom.selected)
      WU.SetActive(ref.SpriteMask, m_custom.isHas == false)
      WU.SetActive(ref.SpriteStarBg, m_custom.showStar ~= false)
      if m_custom.hideNew then
        WU.SetActive(ref.SpriteNew, false)
      end
      ref.SpritePos.gameObject:SetActive(position == 2)
      ref.SpritePos.UISprite.spriteName = "impression_sub_" .. quality - 2
      if m_custom.phase then
        local full = IsFullPhase(m_custom.phase)
        ref.ArmFrame.gameObject:SetActive(full)
        postFix = fif(full, "_1", "_0")
      end
      if m_custom.showEquip and m_arm.actorId and not m_custom.showUsing then
        WU.SetActive(ref.SpriteEquip, true)
        ref.SpriteActor.UISprite.spriteName = "actor_head_" .. m_arm.actorId .. "a"
        if ref.LabelActorLevel then
          local ac = DB:GetData("fci/actor/" .. m_arm.actorUid)
          WU.SetLabel(ref.LabelActorLevel, "Lv." .. ac.level)
        end
      else
        WU.SetActive(ref.SpriteEquip, false)
      end
    end
    if ref.TextureArm then
      m_mainTexture = "Texture/ImpressionRoleM/impression_role_" .. m_id .. postFix
      ref.TextureArm.UITexture.mainTexturePath = m_mainTexture
    else
      ref.SpriteArm.UISprite.spriteName = "impression_role_" .. m_id .. postFix
    end
    ref.ArmFrame.UISprite.spriteName = "impression_list_bg_" .. quality - 2 .. "_1"
    ref.ArmBg.UISprite.spriteName = "impression_list_bg_" .. quality - 2
  else
    error("Arm id nil !")
  end
end

function SetData(id, count, type, size)
  ResetState()
  m_id = id
  m_size = size or "N"
  InstantiatePrefab()
  MarkAsDirty()
end

function SetArm(arm, size)
  ResetState()
  m_id = arm.id
  m_arm = arm
  m_size = size or "N"
  setmetatable(m_arm, {
    __index = PB.get("UniqueWeaponInfo", m_id)
  })
  InstantiatePrefab()
  HideWidget()
  MarkAsDirty()
end

function OnClick()
  if m_callback then
    m_callback()
  end
end

function ShowCustom(custom)
  m_custom = custom
  MarkAsDirty()
end

function HideWidget()
  WU.SetActive(ref.SpriteSelect, false)
  WU.SetActive(ref.SpriteCenter, false)
  WU.SetActive(ref.SpriteMask, false)
  WU.SetActive(ref.SpriteEquip, false)
  WU.SetActive(ref.SpriteUsing, false)
end

function InstantiatePrefab()
  local function func()
    WU.RemoveAllChild(REF.NodeItem)
    
    m_content = _ENV["$"](WU.InstantiateWindowPrefab(REF.NodeItem, "Widget/WidgetIconSlot/Simplified/WidgetIconArmWidget/Node" .. m_size))
    WU.HandleGameObjectAttached(m_content["$gameObject"])
    ref = reRef(REF.NodeItem)
  end
  
  if m_content then
    if m_content["$gameObject"].name ~= "Node" .. m_size then
      func()
    end
  else
    func()
  end
end

function IsFullPhase(phase)
  return phase >= PB.all("Misc")[1].weaponMisc.weaponMaxPhase - 1
end
