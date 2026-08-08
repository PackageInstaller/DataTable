inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HeadAtlas = {
  "ActorHead",
  "ActorHeadSub"
}
local m_dirty = false
local m_showSpriteIcon, m_spriteIconAtlas, m_spriteIconName, m_spriteIconBGName, m_spriteIconAtlas, m_spriteIconBGAlpha, m_showActorLevel, m_actorLevel, m_showArm, m_showStar, m_starCount, m_showIsLocked, m_showActorName, m_actorName
local m_spriteIconSub = ""
local m_rightBottom
local m_graify = false

function ResetState()
  m_showArm = false
  m_showStar = false
  m_showActorLevel = false
  m_showIsLocked = false
  m_showActorName = false
  m_showSpriteIcon = true
  m_spriteIconBGAlpha = 1
  m_spriteIconSub = ""
  SetGraify(false)
end

function SetGraify(graify)
  if m_graify == graify then
    return
  end
  m_graify = graify
  REF.SpriteIconBG.UISprite.graify = graify
  REF.SpriteIcon.UISprite.graify = graify
  REF.SpriteIsSub.UISprite.graify = graify
end

function Draw()
  WU.SetActive(REF.SpriteArm, m_showArm)
  WU.SetActive(REF.RightBottom, m_showStar)
  WU.SetActive(REF.ActorLevel, m_showActorLevel)
  WU.SetActive(REF.SpriteIsLocked, m_showIsLocked)
  if REF.ActorNameNode ~= nil then
    WU.SetActive(REF.ActorNameNode, m_showActorName)
  end
  WU.SetActive(REF.SpriteIcon, m_showSpriteIcon)
  if REF.RightBottom ~= nil then
    REF.RightBottom.UISprite.spriteName = m_rightBottom
  end
  REF.SpriteIcon.UISprite.atlasPath = m_spriteIconAtlas
  REF.SpriteIcon.UISprite.spriteName = m_spriteIconName
  REF.SpriteIconBG.UISprite.spriteName = m_spriteIconBGName
  REF.SpriteIconBG.UISprite.alpha = m_spriteIconBGAlpha
  if REF.SpriteIsSub ~= nil then
    local showSub = m_spriteIconSub ~= nil and m_spriteIconSub ~= ""
    WU.SetActive(REF.SpriteIsSub, showSub)
    if showSub then
      local subIconPosition = fif(m_showStar, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3(72, 0, 0))
      REF.SpriteIsSub.transform.localPosition = subIconPosition
      REF.SpriteIsSub.UISprite.spriteName = m_spriteIconSub
    end
  end
  if m_showStar and REF.StarLabel ~= nil then
    REF.StarLabel.UILabel.text = m_starCount
  end
  if m_showActorLevel and REF.ActorLevel ~= nil then
    REF.ActorLevel.UILabel.text = m_actorLevel
  end
  if REF.NameLabel ~= nil then
    REF.NameLabel.UILabel.text = m_actorName
  end
end

function SetData(id)
  ResetState()
  m_showSpriteIcon = id and 0 < id
  if id and 0 < id then
    local actorConfig = PB.get("ActorConfig", id)
    if actorConfig then
      local kind = 1
      if actorConfig.kind == PB.enum.ActorType.Sub then
        kind = 2
        m_spriteIconSub = "rolelist_sub_s_0"
      end
      REF["@index"] = kind
      m_spriteIconAtlas = HeadAtlas[kind]
      m_spriteIconName = "actor_head_" .. actorConfig.animRes
      m_spriteIconBGName = "role_bg_0"
    else
      error("ActorConfig", "Cannot find ActorConfig by id: " .. tostring(id))
    end
    MarkAsDirty()
    return actorConfig
  elseif id == -1 then
    m_spriteIconBGName = "role_bg_0"
  elseif id == -2 then
    m_spriteIconBGName = "role_bg_0"
    m_spriteIconSub = "rolelist_sub_s_0"
  elseif id == -3 then
    m_spriteIconBGName = "icon_bg_blank"
    m_spriteIconBGAlpha = 0.3
  elseif id == -4 then
    m_spriteIconBGName = "icon_bg_blank"
  end
  MarkAsDirty()
end

function SetActor(actor)
  ResetState()
  if actor then
    local actorConfig = SetData(actor.id)
    if actorConfig and actorConfig.kind == PB.enum.ActorType.Sub then
      m_spriteIconSub = "rolelist_sub_s_" .. actor.quality
    end
    m_showActorLevel = actor.level > 0
    if m_showActorLevel then
      m_actorLevel = WU.GetString("Window_Level", actor.level)
    end
    m_showStar = true
    m_starCount = actor.star
    m_spriteIconBGName = "role_bg_" .. actor.quality
    m_rightBottom = "head_mask_" .. actor.quality
    m_showIsLocked = actor.isLock
    if actor.uniqueWeaponId and actor.uniqueWeaponId ~= 0 then
      if REF.SpriteArm then
        REF.SpriteArm.UISprite.spriteName = "impression_role_" .. actor.uniqueWeaponId .. "_0"
      else
        warning("This icon may not be nested prefab with SpriteArm!")
      end
    end
    MarkAsDirty()
  end
end

function SetActorCustom(customActor)
  ResetState()
  if customActor.id then
    local actorConfig = SetData(customActor.id)
    if customActor.quality or customActor.talentInfo then
      local quality = customActor.quality or #customActor.talentInfo
      local kind = 1
      if actorConfig and actorConfig.kind == PB.enum.ActorType.Sub then
        kind = 2
        m_spriteIconSub = "rolelist_sub_s_" .. quality
      end
      REF["@index"] = kind
      m_spriteIconBGName = "role_bg_" .. quality
      m_rightBottom = "head_mask_" .. quality
    end
    if customActor.star then
      m_showStar = true
      m_starCount = customActor.star
    end
    m_showActorLevel = customActor.level and customActor.level > 0
    if m_showActorLevel then
      m_actorLevel = WU.GetString("Window_Level", customActor.level)
    end
    m_showIsLocked = customActor.isLock ~= nil and customActor.isLock
    m_showActorName = customActor.name ~= nil
    if m_showActorName then
      m_actorName = customActor.name
    end
    if customActor.uniqueWeaponId and customActor.uniqueWeaponId ~= 0 then
      REF.SpriteArm.UISprite.spriteName = "impression_role_" .. customActor.uniqueWeaponId .. "_0"
    end
    MarkAsDirty()
  end
end

function SetActorByRoleId(roleId)
  ResetState()
  if roleId and 0 < roleId then
    local role = PB.get("Role", roleId)
    m_spriteIconBGName = "role_bg_0"
    m_showActorName = true
    m_actorName = WU.GetString("RoleName_" .. roleId)
    if role then
      m_spriteIconAtlas = HeadAtlas[1]
      m_spriteIconName = "actor_head_" .. role.animRes
    else
      error("Role", "Cannot find Role by id: " .. tostring(roleId))
    end
    MarkAsDirty()
  end
end

function ShowCustom(data)
  m_showActorName = data.name ~= nil and data.name
  m_showIsLocked = data.showLock ~= nil and data.showLock
  m_showArm = data.showArm ~= nil and data.showArm
  if data.showStar ~= nil then
    m_showStar = data.showStar ~= nil and data.showStar
  end
  if data.showActorLevel ~= nil then
    m_showActorLevel = data.showActorLevel ~= nil and data.showActorLevel
  end
  MarkAsDirty()
end

function PlayFavourEffect()
  REF.PanelEffect.EffectGenerator:Play()
end

function SetEmpty()
  WU.SetActive(REF.BG_Selected, false)
  WU.SetActive(REF.IconTextureActor, false)
  WU.SetActive(REF.IconActorTypeBg, false)
  WU.SetActive(REF.IconActorBattleType, false)
  WU.SetActive(REF.IconActorSmallName, false)
end
