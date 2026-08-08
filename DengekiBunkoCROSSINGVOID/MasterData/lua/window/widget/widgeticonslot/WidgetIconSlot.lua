local base = inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local IC = require("Common/IconConfig")
local EU = require("Common/EquipUtil")
local Content = REF.Content
local m_pressCallback, m_releaseCallback, m_clickCallback, m_removeCallback
local m_elapsedTime = 0
local m_interval = {
  start = 1,
  min = 0.05,
  acceleration = 0.3,
  current = 1
}
local m_holdSlot = false
local m_holdRemove = false
local m_slotContent, m_bindVal, m_contentType
local m_seq = 0
local CheckBox = {
  "icon_selected",
  "icon_selected"
}
local m_widgetMap = _ENV["!"]({
  [PB.enum.ResourceType.ResItem] = "WidgetIconItem",
  [PB.enum.ResourceType.ResEquip] = "WidgetIconEquip",
  [PB.enum.ResourceType.ResPlayerHeadPhoto] = "WidgetIconPlayerHeadPhoto",
  [PB.enum.ResourceType.ResActor] = "WidgetIconActor",
  [PB.enum.ResourceType.ResMedal] = "WidgetIconMedal",
  [PB.enum.ResourceType.ResNovelCover] = "WidgetIconNovelCover",
  [PB.enum.ResourceType.ResEmoji] = "WidgetIconEmoji",
  [PB.enum.ResourceType.ResActorSkin] = "WidgetIconSkin",
  [PB.enum.ResourceType.ResSignboard] = "WidgetIconSignboard",
  [PB.enum.ResourceType.ResExtremeChallengeItem] = "WidgetIconPill",
  [PB.enum.ResourceType.ResExtremeChallengeScore] = "WidgetIconTowerScore",
  [PB.enum.ResourceType.ResUniqueWeapon] = "WidgetIconArm",
  [PB.enum.ResourceType.ResPlayerHeadFrame] = "WidgetIconPlayerHeadFrame",
  [PB.enum.ResourceType.ResMazeHollow] = "WidgetIconRelic",
  UnknownEquip = "WidgetIconUnknownEquip"
})

function Awake()
  if #REF.Content > 0 then
    m_slotContent = REF.Content[0]
    if m_slotContent ~= nil then
      local resourceName = m_slotContent["$gameObject"].name
      m_contentType = m_widgetMap:find(function(k, v)
        return v == resourceName
      end)
    end
  end
end

function Start()
  base.Start()
  WU.BindPressEvent(REF.ButtonSlot, function(go, pressed)
    if pressed then
      OnSlotPress(go)
    else
      OnSlotRelease(go)
    end
  end)
  WU.BindDragStartEvent(REF.ButtonSlot, function()
    m_holdSlot = false
  end)
  if REF.ButtonRemove ~= nil then
    WU.BindPressEvent(REF.ButtonRemove, function(go, pressed)
      if pressed then
        OnRemovePress(go)
      else
        OnRemoveRelease(go)
      end
    end)
    WU.BindDragStartEvent(REF.ButtonRemove, function()
      m_holdRemove = false
    end)
  end
end

function Update(deltaTime)
  if m_holdRemove or m_holdSlot then
    m_elapsedTime = m_elapsedTime + deltaTime
    if m_elapsedTime > m_interval.current then
      if m_holdSlot then
        m_holdSlot = m_clickCallback(REF["$gameObject"])
      end
      if m_holdRemove then
        m_holdRemove = m_removeCallback(REF["$gameObject"])
      end
      if m_interval.current > m_interval.min then
        m_interval.current = math.max(m_interval.min, m_interval.current * (1 - m_interval.acceleration))
      end
      m_elapsedTime = m_elapsedTime - m_interval.current
    end
  end
end

function InstantiateDataPrefab(type)
  if type == m_contentType and m_slotContent ~= nil then
    return true
  end
  if m_slotContent ~= nil then
    WU.RecycleCacheObject(m_slotContent["$gameObject"])
    m_slotContent = nil
  end
  local resourceName
  if WU.IsResource(type) then
    resourceName = "WidgetIconResource"
  else
    resourceName = m_widgetMap[type]
  end
  if resourceName == nil then
    warning("WidgetIconSlot", "unknow type: " .. tostring(type) .. ", \229\166\130\230\158\156\230\152\175Resource\239\188\140\233\130\163\228\185\136\229\156\168WindowUtil\231\154\132IsResource\233\135\140\233\157\162\230\138\138\232\191\153\228\184\170Resource\229\138\160\228\184\138")
    return false
  end
  m_slotContent = _ENV["$"](WU.InstantiateWindowPrefab(Content, "Widget/WidgetIconSlot/" .. resourceName))
  m_contentType = type
  WU.HandleGameObjectAttached(m_slotContent["$gameObject"])
  return true
end

local m_bottomText, m_bottomBgColor, m_bottomFontColor, m_tipConfig
local m_showSelect = false
local m_showHightlight = false
local m_showEmpty = false
local m_emptyConfig
local m_count = 0
local m_content
local m_contentChanged = false
local m_ownerBoxId
local m_alpha = 1
local m_checkComposeInfo = false

function ResetState()
  m_tipConfig = nil
  m_showSelect = false
  m_showHightlight = false
  m_showEmpty = false
  m_emptyConfig = nil
  m_count = 0
  m_content = nil
  m_contentChanged = false
  m_ownerBoxId = nil
  m_alpha = 1
end

function Draw()
  if m_bottomText ~= nil and m_bottomText ~= "" then
    REF.LabelBottom.UILabel.text = m_bottomText
    if m_bottomBgColor ~= nil then
      REF.SpriteBottomBg.UISprite.color = m_bottomBgColor
    else
      REF.SpriteBottomBg.UISprite.color = CS.NGUIMath.HexToColor(1198102728)
    end
    if m_bottomFontColor ~= nil then
      REF.LabelBottom.UILabel.color = m_bottomFontColor
    else
      REF.LabelBottom.UILabel.color = CS.NGUIMath.HexToColor(4294967295)
    end
    WU.SetActive(REF.BottomNode, true)
  else
    WU.SetActive(REF.BottomNode, false)
  end
  WU.SetActive(REF.TipsNode, m_tipConfig ~= nil)
  if m_tipConfig then
    REF.SpriteTips.UISprite.atlasPath = m_tipConfig.atlas
    REF.SpriteTips.UISprite.spriteName = m_tipConfig.sprite
  end
  WU.SetActive(REF.SelectedNode, m_showSelect)
  if m_showSelect and REF.LabelSeq and 0 < m_seq then
    REF.LabelSeq.UILabel.text = m_seq
  end
  WU.SetActive(REF.HighlightedNode, m_showHightlight)
  if m_showHightlight then
    REF.SelectedSprite.UISprite.spriteName = CheckBox[REF.Content[0]["@index"] or 1]
  end
  WU.SetActive(REF.EmptyNode, m_showEmpty)
  if m_showEmpty and m_emptyConfig ~= nil then
    local ref = _ENV["$"](REF.EmptyNode)
    ref.Empty.UISprite.spriteName = m_emptyConfig.spriteBG or ""
    ref.Sprite.UISprite.atlasPath = m_emptyConfig.atlasPath or ""
    ref.Sprite.UISprite.spriteName = m_emptyConfig.sprite or ""
  end
  WU.SetActive(REF.CountNode, 0 < m_count)
  if 0 < m_count then
    REF.CountLabel.UILabel.text = tostring(m_count)
  else
    m_holdRemove = false
    m_holdSlot = false
  end
  WU.SetActive(REF.TextureOwnerBoxId, m_ownerBoxId ~= nil)
  if m_ownerBoxId ~= nil then
    local itemInfo = PB.get("ItemInfo", m_ownerBoxId)
    if itemInfo then
      REF.TextureOwnerBoxId.UITexture.mainTexturePath = "Texture/ItemIcon/" .. itemInfo.icon
    else
      error("GamePlay", "Cannot find itemInfo with owerBoxId: " .. m_ownerBoxId)
    end
  end
  WU.ToggleRendering(REF.Content, m_content ~= nil)
  REF.Content.UIWidget.alpha = m_alpha
  if m_content and m_contentChanged then
    PlayTween()
    m_contentChanged = false
  end
end

local function OnActor(actor)
  SetActor(actor)
end

local function OnEquip(equip)
  SetEquip(equip)
end

local function OnItem(item)
  SetItem(item)
end

local function OnArm(arm, size)
  size = size or "S"
  SetArm(arm, size)
end

function ClearSlot()
  if m_bindVal ~= nil then
    if m_contentType == PB.enum.ResourceType.ResEquip then
      this:Unbind("fci/equip/" .. m_bindVal, OnEquip)
    elseif m_contentType == PB.enum.ResourceType.ResItem then
      this:Unbind("fci/item/" .. m_bindVal, OnItem)
    elseif m_contentType == PB.enum.ResourceType.ResActor then
      this:Unbind("fci/actor/" .. m_bindVal, OnActor)
    elseif m_contentType == PB.enum.ResourceType.ResUniqueWeapon then
      this:Unbind("fci/arms/" .. m_bindVal, function(arm)
        OnArm(arm, size)
      end)
    end
    m_bindVal = nil
  end
  m_clickCallback = nil
  ResetState()
  m_bottomText = nil
  m_bottomBgColor = nil
  m_bottomFontColor = nil
  MarkAsDirty()
end

local function UpdateContent(content)
  local changed = m_content ~= content
  ResetState()
  m_content = content
  m_contentChanged = changed
  return m_content ~= nil
end

function SetData(type, id, count, size)
  if UpdateContent(tostring(type) .. tostring(id)) and InstantiateDataPrefab(type) then
    m_slotContent["$$ResetState"]()
    m_slotContent["$$SetData"](id, count, type, size)
    SetClickCallback(function()
      WU.ShowResourceDetail(type, id)
    end)
  end
  MarkAsDirty()
end

function SetActorCustom(customActor)
  if UpdateContent(customActor) and InstantiateDataPrefab(PB.enum.ResourceType.ResActor) then
    m_slotContent["$$SetActorCustom"](customActor)
  end
  MarkAsDirty()
end

function SetActorByRoleId(roleId)
  if UpdateContent(roleId) and InstantiateDataPrefab(PB.enum.ResourceType.ResActor) then
    m_slotContent["$$SetActorByRoleId"](roleId)
  end
  MarkAsDirty()
end

function SetActorDataById(actorId)
  if UpdateContent(actorId) and InstantiateDataPrefab(PB.enum.ResourceType.ResActor) then
    m_slotContent["$$SetData"](actorId)
  end
  MarkAsDirty()
end

function BindEquip(uidOrEquip)
  if InstantiateDataPrefab(PB.enum.ResourceType.ResEquip) then
    local uid = uidOrEquip
    m_slotContent["$$ResetState"]()
    if type(uidOrEquip) == "table" then
      uid = uidOrEquip.uid
    end
    m_bindVal = uid
    this:Bind("fci/equip/" .. uid, OnEquip)
  end
end

function BindItem(idOrItem, checkCompose)
  if InstantiateDataPrefab(PB.enum.ResourceType.ResItem) then
    local id = idOrItem
    m_slotContent["$$ResetState"]()
    if type(idOrItem) == "table" then
      id = idOrItem.id
    end
    m_bindVal = id
    m_checkComposeInfo = checkCompose
    this:Bind("fci/item/" .. id, OnItem)
  end
end

function BindActor(uidOrActor)
  if InstantiateDataPrefab(PB.enum.ResourceType.ResActor) then
    local uid = uidOrActor
    m_slotContent["$$ResetState"]()
    if type(uidOrActor) == "table" then
      uid = uidOrActor.uid
    end
    m_bindVal = uid
    this:Bind("fci/actor/" .. uid, OnActor)
  end
end

function BindArm(idOrArm, size)
  if InstantiateDataPrefab(PB.enum.ResourceType.ResUniqueWeapon) then
    local id = idOrArm
    size = size or "N"
    m_slotContent["$$ResetState"]()
    if type(idOrArm) == "table" then
      id = idOrArm.id
    end
    m_bindVal = id
    this:Bind("fci/arms/" .. id, function(arm)
      OnArm(arm, size)
    end)
  end
end

function SetActor(actor)
  if UpdateContent(actor) and InstantiateDataPrefab(PB.enum.ResourceType.ResActor) then
    m_slotContent["$$ResetState"]()
    m_slotContent["$$SetActor"](actor)
  end
  MarkAsDirty()
end

function SetArm(arm, size)
  if UpdateContent(arm) and InstantiateDataPrefab(PB.enum.ResourceType.ResUniqueWeapon) then
    m_slotContent["$$ResetState"]()
    m_slotContent["$$SetArm"](arm, size)
  end
  MarkAsDirty()
end

function SetHeadBox(headId, headFrameId, frameRemainTime, lockFrame)
  local type = PB.enum.ResourceType.ResPlayerHeadPhoto
  if UpdateContent(tostring(type) .. tostring(headId)) and InstantiateDataPrefab(type) then
    m_slotContent["$$ResetState"]()
    m_slotContent["$$SetHeadBox"](headId, headFrameId, frameRemainTime, lockFrame)
    SetClickCallback(function()
      WU.ShowResourceDetail(type, headId)
    end)
  end
  MarkAsDirty()
end

function SetItem(item)
  if UpdateContent(item) and InstantiateDataPrefab(PB.enum.ResourceType.ResItem) then
    m_slotContent["$$ResetState"]()
    m_slotContent["$$SetItem"](item)
    if m_checkComposeInfo then
      local allComposeInfo = PB.all("ResourceCompose")
      local index, composeInfo = table.find(allComposeInfo, function(k, v)
        local materialRes = v.materialRes
        if materialRes and materialRes[1].id == item.id and materialRes[1].type == PB.enum.ResourceType.ResItem then
          return true
        end
        return false
      end)
      if composeInfo then
        m_slotContent["$$ShowComposeRequire"](composeInfo.materialRes[1].count)
      end
    end
  end
  MarkAsDirty()
end

function SetEquip(equip)
  if UpdateContent(equip) and InstantiateDataPrefab(PB.enum.ResourceType.ResEquip) then
    m_slotContent["$$ResetState"]()
    m_slotContent["$$SetEquip"](equip)
  end
  MarkAsDirty()
end

function SetEmpty(choose)
  ClearSlot()
  m_showEmpty = true
  m_emptyConfig = IC.WidgetIconSlot.Emtpy[choose]
  MarkAsDirty()
end

function ShowCustom(data)
  if UpdateContent(data) and m_slotContent["$$ShowCustom"] then
    m_slotContent["$$ShowCustom"](data)
  end
  MarkAsDirty()
end

function ShowExpReturn(data)
  if m_slotContent and m_slotContent["$$ShowExpReturn"] then
    m_slotContent["$$ShowExpReturn"](data)
  end
  MarkAsDirty()
end

function SetCountFontSize(size)
  if m_slotContent and m_slotContent["$$SetCountFontSize"] then
    m_slotContent["$$SetCountFontSize"](size)
  end
end

function SetNameVisible(b)
  if m_slotContent and m_slotContent["$$SetNameVisible"] then
    m_slotContent["$$SetNameVisible"](b)
  end
end

function SetBottomText(text, bgColor, fontColor)
  m_bottomText = text and U.trim(text)
  m_bottomBgColor = bgColor
  m_bottomFontColor = fontColor
  MarkAsDirty()
end

function SetTips(tipKey)
  m_tipConfig = IC.TipsConfig[tipKey]
  MarkAsDirty()
end

function SetSeq(seq)
  m_seq = seq
  MarkAsDirty()
end

function SetCount(val)
  m_count = val
  MarkAsDirty()
end

function SetSelected(flag)
  m_showSelect = flag
  if flag ~= true then
    m_seq = 0
  end
  MarkAsDirty()
end

function SetHighlighted(flag)
  m_showHightlight = flag
  MarkAsDirty()
end

function SetContentAlpha(value)
  m_alpha = value
  MarkAsDirty()
end

function SetOwnerBox(ownerBoxId)
  m_ownerBoxId = ownerBoxId
  MarkAsDirty()
end

function OnSlotPress(go)
  if m_pressCallback then
    m_pressCallback(REF["$gameObject"])
  end
  if m_clickCallback then
    m_holdSlot = true
    m_interval.current = m_interval.start
  end
end

function OnSlotRelease(go)
  if m_holdSlot then
    m_holdSlot = false
    if m_interval.current == m_interval.start and m_clickCallback then
      m_clickCallback(REF["$gameObject"])
    end
  end
  if m_releaseCallback then
    m_releaseCallback(REF["$gameObject"])
  end
end

function OnRemovePress(go)
  if m_removeCallback then
    m_holdRemove = true
    m_interval.current = m_interval.start
  end
end

function OnRemoveRelease(go)
  if m_holdRemove then
    m_holdRemove = false
    if m_interval.current == m_interval.start and m_removeCallback then
      m_removeCallback(REF["$gameObject"])
    end
  end
end

function SetPressCallback(pressCallback)
  m_pressCallback = pressCallback
end

function SetReleaseCallback(releaseCallback)
  m_releaseCallback = releaseCallback
end

function SetClickCallback(clickCallback)
  m_clickCallback = clickCallback
end

function SetRemoveCallback(removeCallback)
  m_removeCallback = removeCallback
end

function SetHighlightType(actorType)
  if type(actorType) == "number" and actorType <= #CheckBox and 0 < actorType then
    m_checkBoxIndex = actorType
  end
end

function PlayTween()
  local playTween = REF.Visual.UIPlayTween
  if playTween ~= nil then
    playTween:Play(true)
  end
end
