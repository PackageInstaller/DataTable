local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local IC = require("Common/IconConfig")
local PosSprites = {
  [0] = "pos_1st",
  [1] = "pos_2nd",
  [2] = "pos_3rd",
  [3] = "pos_sub",
  [4] = "pos_sub",
  [5] = "pos_sub"
}
local CheckBox = {"check_box", "check_box"}
local m_clickCallback, m_holdCallback, m_actor, m_uid, m_cultivationTotal, m_speed, m_star
local m_holdTriggerLeftTime = 0
local m_roleId, m_isNpc, m_isGuildActor1, m_hasArm

function Start()
  WU.BindPressEvent(REF.ButtonSlot, function(go, pressed)
    if pressed then
      OnSlotPress(go)
    else
      OnSlotRelease(go)
    end
  end)
  WU.BindDragStartEvent(REF.ButtonSlot, function()
    m_holdTriggerLeftTime = 0
  end)
end

function OnSlotPress(go)
  m_holdTriggerLeftTime = 0.5
end

function OnSlotRelease(go)
  if 0 < m_holdTriggerLeftTime and m_clickCallback then
    m_clickCallback(REF["$gameObject"])
  end
  m_holdTriggerLeftTime = 0
end

function OnEnable()
  m_roleId = nil
  this:Bind("ActorSelect/PeekActorUid", UpdateSelection)
end

function OnDisable()
  this:Unbind("ActorSelect/PeekActorUid", UpdateSelection)
end

function UpdateSelection()
  local top = WU.TopWindow()
  if top and top.name == "ActorPeek" then
    REF.SpriteSelected.gameObject:SetActive(this:GetData("ActorSelect/PeekActorUid") == m_uid)
  end
end

function Update(deltaTime)
  if 0 < m_holdTriggerLeftTime then
    m_holdTriggerLeftTime = math.max(0, m_holdTriggerLeftTime - deltaTime)
    if m_holdTriggerLeftTime == 0 and m_holdCallback then
      m_holdCallback(REF["$gameObject"])
    end
  end
end

local function OnActor(actor)
  if actor ~= nil then
    SetActor(actor)
  end
end

function ResetState()
  REF.SpriteTips.gameObject:SetActive(false)
  REF.SpriteSelected.gameObject:SetActive(false)
  REF.SpriteMemOrder.gameObject:SetActive(false)
  REF.SpriteIsLocked.gameObject:SetActive(false)
  REF.RecommendEffect.gameObject:SetActive(false)
  REF.ShowLock.gameObject:SetActive(false)
  REF.NodeMoreInfo.gameObject:SetActive(false)
  REF.LabelLvValue.gameObject:SetActive(true)
  REF.RightBottom.gameObject:SetActive(true)
  REF.AlphaControl.gameObject:SetActive(true)
  REF.ActorInfo.gameObject:SetActive(true)
  REF.SpriteIsSub.gameObject:SetActive(false)
  if REF.SpriteIsSubWithArm then
    REF.SpriteIsSubWithArm.gameObject:SetActive(false)
  end
  if REF.SpriteArm then
    REF.SpriteArm.gameObject:SetActive(false)
  end
  REF.ActorName.gameObject:SetActive(false)
  REF.SpriteMask.gameObject:SetActive(false)
  REF.SelectedSprite.gameObject:SetActive(false)
  REF.BuffActivityInfo.gameObject:SetActive(false)
  WU.SetActive(m_isNpc, false)
  WU.SetActive(m_isGuildActor1, false)
  m_hasArm = false
end

function BindActor(uidOrActor)
  ResetState()
  local uid = uidOrActor
  if type(uidOrActor) == "table" then
    uid = uidOrActor.uid
  end
  if m_uid ~= nil then
    this:Unbind("fci/actor/" .. m_uid, OnActor)
  end
  m_uid = uid
  this:Bind("fci/actor/" .. uid, OnActor)
  UpdateSelection()
end

function UpdateActor(actor)
  if actor == nil then
    return
  end
  ResetState()
  local uid = actor.uid
  m_uid = uid
  SetActor(actor)
  UpdateSelection()
end

function SetActorByRoleId(roleId)
  ResetState()
  REF.ActorInfo.gameObject:SetActive(false)
  if roleId and 0 < roleId then
    local role = PB.get("Role", roleId)
    if role then
      REF.SpriteBG.UISprite.spriteName = "head_bg_0"
      REF.ActorName.gameObject:SetActive(true)
      REF.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorHeadRectangle/actor_head_" .. role.animRes
      REF.ActorName.UISprite.spriteName = "actor_name_" .. role.animRes
      REF.ActorNameEn.UISprite.spriteName = "actor_name_s_" .. role.animRes
      REF.ActorName.UISprite:MakePixelPerfect()
      REF.ActorNameEn.UISprite:MakePixelPerfect()
      if m_roleId ~= roleId then
        m_roleId = roleId
        REF.Visual.UIPlayTween:Play(true)
      end
    else
      error("Actor", "Role.xlsx error, Can't find id " .. tostring(roleId))
    end
  end
end

function SetActorCustom(customActor)
  ResetState()
  if customActor ~= nil and customActor.id ~= nil then
    local actorConfig = PB.get("ActorConfig", customActor.id)
    if actorConfig then
      local quality = customActor.quality or 0
      local index = 1
      if actorConfig.kind == PB.enum.ActorType.Sub then
        index = 2
        REF.SpriteIsSub.UISprite.spriteName = "rolelist_sub_m_" .. quality
        if REF.SpriteIsSubWithArm then
          REF.SpriteIsSubWithArm.UISprite.spriteName = "rolelist_sub_" .. quality
        end
      end
      REF.SpriteSelected.UISprite.spriteName = CheckBox[index]
      REF.MainRecommend.gameObject:SetActive(true)
      REF.SpriteIsSub.gameObject:SetActive(index == 2)
      REF.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorHeadRectangle/actor_head_" .. actorConfig.animRes
      REF.RightBottom.UISprite.spriteName = "head_mask_" .. quality
      REF.SpriteBG.UISprite.spriteName = "head_bg_" .. quality
      if customActor.uniqueWeaponId and customActor.uniqueWeaponId ~= 0 and REF.SpriteArm then
        m_hasArm = true
        REF.SpriteArm.UISprite.spriteName = "impression_role_" .. customActor.uniqueWeaponId .. "_0"
      else
        m_hasArm = false
      end
    end
  end
end

function SetActor(actor)
  if actor then
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig then
      local index = 1
      if actorConfig.kind == PB.enum.ActorType.Sub then
        index = 2
        REF.SpriteIsSub.UISprite.spriteName = "rolelist_sub_m_" .. actor.quality
        if REF.SpriteIsSubWithArm then
          REF.SpriteIsSubWithArm.UISprite.spriteName = "rolelist_sub_" .. actor.quality
        end
      end
      REF.RightBottom.UISprite.spriteName = "head_mask_" .. actor.quality
      REF.SpriteBG.UISprite.spriteName = "head_bg_" .. actor.quality
      REF.SpriteSelected.UISprite.spriteName = CheckBox[index]
      REF.MainRecommend.gameObject:SetActive(true)
      REF.SpriteIsSub.gameObject:SetActive(index == 2)
      REF.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorHeadRectangle/actor_head_" .. actorConfig.animRes
    end
    REF.LabelLvValue.UILabel.text = WU.GetString("Window_Level", actor.level)
    REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. actor.id
    REF.SpriteActorTypeBG.UISprite.spriteName = "actor_type_bg_" .. actor.quality
    REF.SpriteIsLocked.gameObject:SetActive(actor.isLock)
    if m_actor ~= actor then
      m_actor = actor
      REF.Visual.UIPlayTween:Play(true)
    end
    m_cultivationTotal = actor.cultivationTotal or 0
    m_speed = actor.speed or 0
    m_star = actor.star
    if actor.uniqueWeaponId and actor.uniqueWeaponId ~= 0 then
      if REF.SpriteArm then
        m_hasArm = true
        REF.SpriteArm.UISprite.spriteName = "impression_role_" .. actor.uniqueWeaponId .. "_0"
      else
        m_hasArm = false
        warning("This icon may not be nested prefab with SpriteArm!")
      end
    else
      m_hasArm = false
    end
  end
end

function ShowCustom(data)
  REF.ShowLock.gameObject:SetActive(data.lock ~= nil and data.lock)
  if data.showLevel ~= nil then
    REF.LabelLvValue.gameObject:SetActive(data.showLevel)
  end
  REF.RightBottom.gameObject:SetActive(true)
  if data.showStar ~= false then
    _ENV["$"](REF.RightBottom).Stars.UISprite.spriteName = "actor_star"
    REF.StarLabel.UILabel.text = m_star
  elseif data.showSpeed then
    _ENV["$"](REF.RightBottom).Stars.UISprite.spriteName = "actor_speed"
    REF.StarLabel.UILabel.text = m_speed
  elseif data.showCultivationTotal then
    _ENV["$"](REF.RightBottom).Stars.UISprite.spriteName = "actor_growup"
    REF.StarLabel.UILabel.text = m_cultivationTotal
  else
    REF.RightBottom.gameObject:SetActive(false)
  end
  if data.showActorInfo ~= nil then
    REF.ActorInfo.gameObject:SetActive(data.showActorInfo)
  end
  if data.showUniqueWeapon ~= nil and m_hasArm == true and REF.SpriteArm then
    REF.SpriteArm.gameObject:SetActive(data.showUniqueWeapon)
    if REF.SpriteIsSub.gameObject.activeSelf then
      REF.SpriteIsSub.gameObject:SetActive(false)
      if REF.SpriteIsSubWithArm then
        REF.SpriteIsSubWithArm.gameObject:SetActive(true)
      end
    end
  end
end

function ShowMoreInfo(data)
  if data == nil then
    REF.NodeMoreInfo.gameObject:SetActive(false)
    return
  end
  REF.NodeMoreInfo.gameObject:SetActive(true)
  WU.TraverseChildren(REF.NodeMoreInfo, function(go, index)
    _ENV["$"](go).root.gameObject:SetActive(false)
  end)
  REF.SpriteDead.gameObject:SetActive(data.Dead)
  REF.AlphaControl.UIWidget.alpha = fif(data.Dead, 0.6, 1)
  for k, v in pairs(data) do
    if REF["Label" .. k] then
      REF.bg.gameObject:SetActive(true)
      REF["Label" .. k].UILabel.text = v
      REF["Label" .. k].gameObject:SetActive(true)
    end
  end
end

function SetTips(tipKey)
  local tipConfig = IC.TipsConfig[tipKey]
  REF.SpriteTips.gameObject:SetActive(tipConfig ~= nil)
  if tipConfig then
    REF.SpriteTips.UISprite.atlasPath = tipConfig.atlas
    REF.SpriteTips.UISprite.spriteName = tipConfig.sprite
  end
end

function SetMemberOrder(index)
  REF.SpriteMemOrder.gameObject:SetActive(true)
  REF.SpriteMemOrder.UISprite.spriteName = PosSprites[index]
end

function SetHighlighted(flag)
  REF.SpriteSelected.gameObject:SetActive(flag)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function SetHoldCallback(callback)
  m_holdCallback = callback
end

function SetMemberLink(flag)
  REF.RecommendEffect.gameObject:SetActive(flag)
end

function SetAlpha(alpha)
  REF.Visual.TweenAlpha.to = alpha
end

function SetMask(flag)
  REF.SpriteMask.gameObject:SetActive(flag)
end

function SetSelected(flag)
  REF.SelectedSprite.gameObject:SetActive(flag)
end

function SetAsNpc()
  local isNpcObj = REF.ActorInfo.transform:Find("IsNpc")
  WU.SetActive(isNpcObj, true)
  if isNpcObj == nil then
    isNpcObj = CS.UnityEngine.GameObject.Instantiate(REF.SpriteIsSub.gameObject, REF.ActorInfo.transform)
    isNpcObj.transform.name = "IsNpc"
    isNpcObj.transform.localPosition = CS.UnityEngine.Vector3(16, 116, 0)
    local npcRef = _ENV["$"](isNpcObj)
    local uisprite = npcRef["$UISprite"]
    uisprite.atlasPath = "CommonWindow"
    uisprite.spriteName = "actor_tips"
    uisprite:SnapWithoutScale()
    isNpcObj.gameObject:SetActive(true)
    m_isNpc = isNpcObj
    local labelObj = CS.UnityEngine.GameObject.Instantiate(REF.LabelLvValue.gameObject, isNpcObj.transform)
    local label = labelObj.transform:GetComponent(typeof(CS.UILabel))
    label.text = WU.GetString("Window_SemiFixedArrangeTips")
    label.effectStyle = CS.UILabel.Effect.None
    label.color = CS.NGUIMath.HexToColor(2945268223)
    label.depth = uisprite.depth + 1
    labelObj.transform.localPosition = CS.UnityEngine.Vector3(21, 9, 0)
  end
end

function ShowBuffActivityInfo(flag)
  WU.SetActive(REF.BuffActivityInfo, flag)
end
