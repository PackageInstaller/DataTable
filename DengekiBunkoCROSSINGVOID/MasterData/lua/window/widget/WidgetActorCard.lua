inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local EU = require("Common/EquipUtil")
local SE = require("Common/SkillEffect")
local m_hasSkillUp, m_hasStarUp, m_hasEquipOn, m_clickCallback, m_actor, m_showRedMark, m_uid
local CheckBox = {
  "check_box",
  "check_box_assist"
}
local EmptyBG = {
  "actor_group_bg_main",
  "actor_group_bg_sub"
}
local SpriteNamePrefix = {
  "rolelist_bg_",
  "rolelist_bg_sub_"
}
local GroupTags = {
  [0] = "actor_group_tag_1",
  [1] = "actor_group_tag_2",
  [2] = "actor_group_tag_3",
  [3] = "actor_group_tag_sub",
  [4] = "actor_group_tag_sub",
  [5] = "actor_group_tag_sub"
}
local SABC = {
  "C",
  "B",
  "A",
  "S"
}
local m_selected, m_showRedPoint, m_showLock, m_showNew, m_showStar, m_showLevel, m_groupBG, m_groupTag, m_lock, m_spriteActorType, m_star, m_labelLevel, m_spriteActorName, m_spriteSelected, m_actorHead, m_spriteNameBG, m_contentBG, m_content, m_empty, m_new, m_redPoint, m_tweenSwitch, m_cultivationTotal, m_speed, m_showCultivationTotal, m_showSpeed, m_showEquips, m_showName, m_showArm
local m_equips = {}
local m_showGroup, m_actorKind, m_scard2V3, m_needMesh, m_notMyCard, m_equipNotClick, m_isGuildActor

local function SetActor(actor, notMyCard, isGuildActor)
  if actor ~= nil then
    m_actor = actor
    m_new = actor.isNewCard
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig then
      local index = 1
      if actorConfig.kind == PB.enum.ActorType.Sub then
        index = 2
      end
      m_actorKind = actorConfig.kind
      m_spriteNameBG = SpriteNamePrefix[1] .. actor.quality
      m_actorHead = "Texture/ActorHeadBig/actor_head_big_" .. actorConfig.animRes
      m_spriteSelected = CheckBox[1]
      m_spriteActorName = "actor_name_" .. actorConfig.animRes
    end
    m_labelLevel = actor.level
    m_star = actor.star
    m_spriteActorType = "actor_type_" .. actor.id
    m_lock = actor.isLock
    m_cultivationTotal = actor.cultivationTotal or 0
    m_speed = actor.speed or 0
    m_equips = {}
    m_notMyCard = notMyCard
    m_isGuildActor = isGuildActor
    if not notMyCard then
      m_equips = EU.GetEquips(actor)
    elseif isGuildActor then
      for k, v in pairs(actor.posEquip) do
        table.insert(m_equips, {id = v})
      end
    end
    MarkAsDirty()
  end
end

function Start()
  WU.BindButtonEvent(REF.ButtonSlot, function(go)
    if m_clickCallback then
      m_clickCallback(REF["$gameObject"])
    end
  end)
  WU.BindButtonEvent(REF.ShowEquips, function()
    if m_notMyCard or m_equipNotClick then
      return
    end
    this:SetData("Actor/SelectedUid", m_uid)
    local actorInfoList = WU.FindWindow("ActorInfoList")
    if actorInfoList and actorInfoList.gameObject.activeSelf then
      WU.RecycleWindow("ActorInfoList")
    end
    local top = WU.TopWindow()
    if top and top.name == "ActorInfo" then
      _ENV["$"](top)["$$SetSelectedTab"]("TabEquip")
    else
      WU.AcquireWindowAsync("ActorInfo", function(window)
        _ENV["$"](window)["$$SetSelectedTab"]("TabEquip")
        _ENV["$"](window)["$$ShowSwitch"]()
      end)
    end
  end)
end

function Draw()
  REF.SpriteSelected.gameObject:SetActive(m_selected)
  REF.ShowRedPoint.gameObject:SetActive(m_showRedPoint and m_showRedMark)
  REF.ShowLock.gameObject:SetActive(m_showLock)
  REF.SpriteRedPoint.gameObject:SetActive(m_redPoint)
  REF.SpriteNew.gameObject:SetActive(m_showNew ~= false and m_new)
  if REF.ShowArm then
    REF.ShowArm.gameObject:SetActive(false)
  end
  if m_actor then
    REF.SABCLabel.UILabel.text = SABC[m_actor.quality]
    REF.LevelLabel.UILabel.text = " - " .. WU.GetString("Window_Level", m_actor.level)
    REF.RightBottom.UISprite.spriteName = "rolelist_mask_" .. m_actor.quality
    REF.SpriteActorTypeQuality.UISprite.spriteName = "actor_type_bg_" .. m_actor.quality
    REF.SpriteActorType.UISprite.spriteName = m_spriteActorType
    REF.SpriteActorType1.UISprite.spriteName = "rolelist_sub_" .. m_actor.quality
    REF.SpriteActorType1.gameObject:SetActive(m_actorKind == PB.enum.ActorType.Sub)
    REF.SCard1.gameObject:SetActive(m_needMesh and not m_empty and m_actor.quality == PB.enum.ActorQuality.Orange)
    REF.SCard2.gameObject:SetActive(not m_needMesh and not m_empty and m_actor.quality == PB.enum.ActorQuality.Orange)
    if m_scard2V3 ~= nil then
      REF.SCard2.transform.localScale = m_scard2V3
    end
    if REF.ShowArm and not m_empty then
      REF.ShowArm.gameObject:SetActive(m_showArm)
      if m_showArm then
        REF.SpriteArmBg.UISprite.spriteName = "rolelist_mask_" .. m_actor.quality
        if m_actor.uniqueWeaponId and m_actor.uniqueWeaponId ~= 0 then
          REF.TextureArm.gameObject:SetActive(true)
          REF.TextureArm.UITexture.mainTexturePath = "Texture/ImpressionGroupRole/impression_group_role_" .. m_actor.uniqueWeaponId .. "_" .. m_actor.uniqueWeaponSkin
        else
          REF.TextureArm.gameObject:SetActive(false)
        end
      end
    end
  end
  REF.EmptyNode.gameObject:SetActive(m_empty)
  REF.AlphaControl.gameObject:SetActive(m_content)
  REF.SpriteBG.gameObject:SetActive(m_contentBG)
  REF.SpriteBG.UISprite.spriteName = m_spriteNameBG
  REF.TextureActorHead.UITexture.mainTexturePath = m_actorHead
  REF.SpriteSelected.UISprite.spriteName = m_spriteSelected
  REF.SpriteActorName.UISprite.spriteName = m_spriteActorName
  REF.SpriteActorName.UISprite:MakePixelPerfect()
  REF.SpriteIsLocked.gameObject:SetActive(m_lock and not m_showEquips)
  if m_showLevel ~= nil then
    REF.LevelLabel.gameObject:SetActive(not m_empty and m_showLevel)
  end
  REF.GroupTag.UISprite.spriteName = m_groupTag
  REF.GroupBG.UISprite.spriteName = m_groupBG
  REF.ValueGrowth.gameObject:SetActive(not m_empty and m_showCultivationTotal)
  REF.ValueSpeed.gameObject:SetActive(not m_empty and m_showSpeed)
  REF.ValueStar.gameObject:SetActive(not m_empty and m_showStar)
  REF.ValueLabel.UILabel.fontSize = 52
  if m_showCultivationTotal then
    REF.ValueLabel.UILabel.text = m_cultivationTotal
  elseif m_showSpeed then
    REF.ValueLabel.UILabel.text = m_speed
  else
    REF.ValueStar.gameObject:SetActive(not m_empty)
    REF.ValueLabel.UILabel.text = m_star
    REF.ValueLabel.UILabel.fontSize = 60
  end
  if m_showGroup ~= nil then
    m_showGroup = nil
    m_showEquips = true
  end
  REF.ShowEquips.gameObject:SetActive(not m_empty and m_showEquips)
  REF.ActorName.gameObject:SetActive(not m_empty and m_showName)
  if m_showEquips then
    for i = 0, #REF.ShowEquips - 1 do
      local ref = REF.ShowEquips[i]
      ref["$UISprite"].spriteName = "icon_bg_1"
      ref["$UISprite"].solidColor = true
      ref["$UISprite"].color = CS.NGUIMath.IntToColor(4294967118)
      ref.Texture.UITexture.enabled = false
      ref.LevelLabel.UILabel.text = ""
    end
    for i = 1, #m_equips do
      local equipInfo = PB.get("EquipInfo", m_equips[i].id)
      if equipInfo then
        local ref = REF.ShowEquips[equipInfo.pos]
        ref["$UISprite"].solidColor = false
        ref["$UISprite"].color = CS.NGUIMath.IntToColor(4294967295)
        ref["$UISprite"].spriteName = "icon_bg_" .. equipInfo.quality
        ref.Texture.UITexture.enabled = true
        ref.Texture.UITexture.mainTexturePath = "Texture/EquipIcon/" .. equipInfo.icon
        ref.LevelLabel.UILabel.text = m_equips[i].level
      else
        warning("EquipInfo.xlsx", "Can't find id " .. m_equips[i].id)
      end
    end
  end
  REF.ShowGroup.gameObject:SetActive(m_showGroup ~= nil)
  if m_showGroup then
    local empty = table.empty(m_showGroup)
    REF.ShowGroupGrid.gameObject:SetActive(not empty)
    REF.NoGroup.gameObject:SetActive(empty)
    if not empty then
      for i = 0, #REF.ShowGroupGrid - 1 do
        REF.ShowGroupGrid[i]["$gameObject"]:SetActive(false)
      end
      for i = 1, #m_showGroup do
        local index = tonumber(m_showGroup[i]) - 1
        if index < #REF.ShowGroupGrid then
          REF.ShowGroupGrid[index]["$gameObject"]:SetActive(true)
        end
      end
      REF.ShowGroupGrid.UIGrid:Reposition()
    end
  end
end

local function OnActor(actor)
  if actor ~= nil then
    if m_tweenSwitch then
      REF.SpriteBG.UIPlayTween:Play(true)
      REF.PlayTweenDown.UIPlayTween:Play(true)
      REF.PlayTweenUp.UIPlayTween:Play(true)
    end
    m_actor = actor
    m_showRedMark = GU.IsShowRedMark(actor.uid)
    if m_showRedMark then
      m_hasSkillUp = SE.HasSkillToUpgrade(actor)
      m_hasStarUp = AU.UpgradeStarEnable(actor)
      m_hasEquipOn = EU.HasPosToEquip(actor)
      m_redPoint = m_hasSkillUp or m_hasStarUp or m_hasEquipOn
    end
    SetActor(actor)
  end
end

function SetMazeActor(actor)
  ResetState()
  m_uid = actor.uid
  OnActor(actor)
end

function ResetState()
  m_redPoint = false
  m_new = false
  m_empty = false
  m_selected = false
  m_showRedPoint = false
  m_showLock = false
  m_showNew = true
  m_showLevel = true
  m_showStar = true
  m_showName = true
  m_content = true
  m_contentBG = true
end

function OnEnable()
  this:Bind("fci/resource/ResPlayerGold_0", CheckSkill)
  this:Bind("fci/item/", CheckStar)
  this:Bind("fci/item/", CheckSkill)
  this:Bind("equipMinRequireLevelPosMap", CheckEquip)
end

function OnDisable()
  this:Unbind("fci/resource/ResPlayerGold_0", CheckSkill)
  this:Unbind("fci/item/", CheckStar)
  this:Unbind("fci/item/", CheckSkill)
  this:Unbind("equipMinRequireLevelPosMap", CheckEquip)
end

function CheckSkill()
  if m_actor and m_showRedMark then
    m_hasSkillUp = SE.HasSkillToUpgrade(m_actor)
    m_redPoint = m_hasEquipOn or m_hasSkillUp or m_hasStarUp
    MarkAsDirty()
  end
end

function CheckEquip()
  if m_actor and m_showRedMark then
    m_hasEquipOn = EU.HasPosToEquip(m_actor)
    m_redPoint = m_hasEquipOn or m_hasSkillUp or m_hasStarUp
    MarkAsDirty()
  end
end

function CheckStar()
  if m_actor and m_showRedMark then
    m_hasStarUp = AU.UpgradeStarEnable(m_actor)
    m_redPoint = m_hasEquipOn or m_hasSkillUp or m_hasStarUp
    MarkAsDirty()
  end
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
  this:Bind("fci/actor/" .. m_uid, OnActor)
end

function SetActorOnce(actor, notMyCard, isGuildActor)
  ResetState()
  SetActor(actor, notMyCard, isGuildActor)
end

function SetEmpty(index)
  ResetState()
  m_empty = true
  m_content = false
  m_contentBG = false
  if index ~= nil then
    m_groupTag = GroupTags[index]
    local checkBoxIndex = 2
    if GU.IsMainIndex(index) then
      checkBoxIndex = 1
    end
    m_spriteSelected = CheckBox[1]
    m_groupBG = EmptyBG[1]
  else
    m_groupBG = EmptyBG[1]
  end
  MarkAsDirty()
end

function ShowCustom(data)
  m_showRedPoint = data.redPoint
  m_showLock = data.lock
  m_showNew = data.showNew
  m_showLevel = data.showLevel
  m_showEquips = data.showEquips
  m_showName = data.showName
  m_showGroup = data.showGroup
  m_showArm = data.showArm
  m_showStar = data.showStar
  m_showCultivationTotal = data.showCultivationTotal
  m_showSpeed = data.showSpeed
  MarkAsDirty()
end

function SetHighlighted(flag)
  m_selected = flag
  MarkAsDirty()
end

function SetSCardEffect(flag)
  m_needMesh = flag
end

function SetListTweenSwitch(flag)
  m_tweenSwitch = flag
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function SetSCard2Scacle(v3)
  m_scard2V3 = v3
end

function SetEquipUnClickAble(flag)
  m_equipNotClick = flag
end
