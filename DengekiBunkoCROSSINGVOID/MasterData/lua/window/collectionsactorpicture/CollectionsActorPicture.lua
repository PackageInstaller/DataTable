local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SDU = require("Common/SoundUtil")
local m_initScale = 0.6
local m_scaleValue = 0.6
local m_maxScale = 0.8
local m_minScale = 0.4
local m_screenSize = {}
local m_porSetting = PB.enum.WeaponPicSituationType.PrPr
local m_scaleUnit = 0.15
local m_originDistance = 0
local m_lastDistance = 0
local m_dragDelta
local m_twoFingerd = false
local m_nowAudioSource, m_initPos
local m_changeAble = false
local m_cdTime = 0.1
local m_lastChangeTime = 0
local m_curSign = 1
local m_lastSign = 1
local m_dragOriginalX = 500
local m_dragOriginalY = 267
local m_dragDistanceX = 500
local m_dragDistanceY = 267

function SetupWindow()
  WU.BindDragEvent(REF.TextureActor, OnDraging)
  WU.BindPressEvent(REF.TextureActor, OnPress)
  WU.BindPressEvent(REF.BGDrag, OnPress)
  WU.BindDragEvent(REF.BGDrag, OnDraging)
  m_initPos = REF.TextureActor.transform.localPosition
end

function InitWindow()
  CS.UnityEngine.Input.multiTouchEnabled = true
  REF.TextureActor.transform.localPosition = m_initPos
  m_screenSize.width = REF.WindowSize.UIWidget.width
  m_screenSize.height = REF.WindowSize.UIWidget.height
  m_scaleValue = m_initScale
  m_dragDistanceX = m_screenSize.width / 1920 * m_dragOriginalX
  m_dragDistanceY = m_screenSize.height / 1024 * m_dragOriginalY
  m_maxScale = 0.8
  m_minScale = 0.4
end

function UninitWindow()
  CS.UnityEngine.Input.multiTouchEnabled = false
  if m_nowAudioSource ~= nil then
    m_nowAudioSource:Stop()
  end
end

function OnDraging(go, delta)
  local position = REF.TextureActor.transform.localPosition
  position.x = position.x + delta.x
  position.y = position.y + delta.y
  m_dragDelta = m_dragDelta + delta
  local distance, distanceX, distanceY = GetDistance(position, m_initPos)
  if distanceX <= m_dragDistanceX and distanceY <= m_dragDistanceY then
    REF.TextureActor.transform.localPosition = position
  end
end

function OnPress(go, press)
  if press then
    m_dragDelta = CS.UnityEngine.Vector2.zero
  else
    if math.abs(m_dragDelta.x) <= 30 and 30 >= math.abs(m_dragDelta.y) and not m_twoFingerd then
      WU.RecycleWindow(this)
    end
    m_twoFingerd = false
  end
end

function SetTextureScale()
  REF.TextureActor.transform.localScale = CS.UnityEngine.Vector3(m_scaleValue, m_scaleValue, m_scaleValue)
end

function SetHoldSetting(noInitPos)
  m_twoFingerd = false
  if not noInitPos then
    REF.TextureActor.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
  end
  m_scaleValue = m_initScale
  SetTextureScale()
end

function SetActor(actorConfig)
  local config = PB.get("ActorPortrait", actorConfig.id, 0)
  REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortraitFull/actor_portrait_full_" .. actorConfig.animRes
  REF.BG.UITexture.mainTexturePath = "Texture/ActorPortraitFullBG/" .. config.bg
  REF.TextureActor.UITexture.width = 2874
  REF.TextureActor.UITexture.height = 2400
  REF.TextureActor.transform.localScale = CS.UnityEngine.Vector3(0.6, 0.6, 0)
  m_initScale = 0.6
  m_maxScale = 0.8
  m_minScale = 0.4
  SetHoldSetting()
  m_nowAudioSource = SDU.PlayActorWiki(actorConfig.role)
end

function SetArmPic(arm, custom)
  local cardSkinIndex = arm.cardSkinIndex
  if custom and custom.cardSkinIndex then
    cardSkinIndex = custom.cardSkinIndex
  end
  m_initScale, m_maxScale, m_minScale = WU.ModifyWeaponPortrait(REF.TextureActor, arm.id, m_porSetting, this.name, cardSkinIndex)
  REF.BG.UITexture.mainTexturePath = "Texture/Background/impression_full_bg"
  SetHoldSetting(true)
end

function GetDistance(vector3One, Vector3Two)
  local diffX = math.abs(vector3One.x - Vector3Two.x)
  local diffY = math.abs(vector3One.y - Vector3Two.y)
  return math.sqrt(diffX * diffX + diffY * diffY), diffX, diffY
end

function UpdateWindow(delta)
  m_lastChangeTime = m_lastChangeTime + delta
  m_changeAble = m_lastChangeTime > m_cdTime
  if CS.UnityEngine.Input.touchCount >= 2 and m_changeAble then
    m_twoFingerd = true
    local touch1 = CS.UnityEngine.Input.GetTouch(0)
    local touch2 = CS.UnityEngine.Input.GetTouch(1)
    if touch1.phase == CS.UnityEngine.TouchPhase.Began or touch2.phase == CS.UnityEngine.TouchPhase.Began then
      m_originDistance = GetDistance(touch1.position, touch2.position)
      m_lastDistance = m_originDistance
    end
    if touch1.phase == CS.UnityEngine.TouchPhase.Moved or touch2.phase == CS.UnityEngine.TouchPhase.Moved then
      local distance = GetDistance(touch1.position, touch2.position)
      if distance < m_lastDistance then
        m_curSign = -1
      elseif distance > m_lastDistance then
        m_curSign = 1
      end
      if m_curSign ~= m_lastSign then
        m_lastChangeTime = 0
      end
      m_lastSign = m_curSign
      m_lastDistance = distance
      local percent = math.abs(m_originDistance - distance) / m_originDistance
      local scale = m_curSign * m_scaleUnit * percent
      m_scaleValue = math.clamp(m_scaleValue + scale, m_minScale, m_maxScale)
      SetTextureScale()
    end
  end
end
