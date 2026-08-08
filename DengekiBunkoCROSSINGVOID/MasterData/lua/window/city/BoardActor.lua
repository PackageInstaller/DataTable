local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local Vector2 = CS.UnityEngine.Vector2
local NU = require("Common/NotepadUtil")
local m_emotePlayer, m_emoteRender
local m_emoteLoopLabel = "waiting_roop_board_01"
local m_emoteSequencePlayer
local m_emoteIndex = -1
local m_lastEmoteIndex = 0
local m_boardActorConfig
local m_emoteAppearance = -1
local m_interactiveActions, m_lastInteractiveAction, m_idleActions, m_lastIdleAction, m_disgustActions, m_lastDisgustAction
local m_lastPressTime = 0
local m_lastTouchTime = 0
local m_touchCallback
local m_fsm = require("Common/FSM"):new()
local m_clickCount = 0
local m_lastClickTime = 0
local m_speechMode = 0
local m_speechCo
local m_forceTouched = false
local m_isPressing = false
local m_bIsNowEmoteStatic = false
local m_speechText
local m_autoPlay = true
local m_bAutoDestory = true
local m_emoteDisplay, m_windowType, m_window, m_noIdle

local function Vector2Divide(vecA, vecB)
  return Vector2(vecA.x / vecB.x, vecA.y / vecB.y)
end

local function ApplyVariable(variable, value)
  if m_emotePlayer then
    local transition = m_emotePlayer.variableTransitionTime
    local easing = m_emotePlayer.variableTransitionEasing
    m_emotePlayer:SetVariable(variable, value, transition, easing)
  end
end

local function ApplyMouseTrace(distance)
  local radius = 0.1
  ApplyVariable("face_eye_LR", math.clamp(distance.x / radius, -1, 1) * m_boardActorConfig.rangeEyeLR)
  ApplyVariable("face_eye_UD", math.clamp(distance.y / radius, -1, 1) * m_boardActorConfig.rangeEyeUD)
  ApplyVariable("face_nose_LR", math.clamp(distance.x * 0.5 / radius, -1, 1) * m_boardActorConfig.rangeNoseLR)
  ApplyVariable("head_LR", math.clamp(distance.x * 0.5 / radius, -1, 1) * m_boardActorConfig.rangeHeadLR)
  ApplyVariable("head_UD", math.clamp(distance.y * 0.5 / radius, -1, 1) * m_boardActorConfig.rangeHeadUD)
  ApplyVariable("body_LR", math.clamp(distance.x * 0.25 / radius, -1, 1) * m_boardActorConfig.rangeBodyLR)
end

function m_fsm:EnterIdle()
  self.enterIdleTime = CS.GameTime.time
end

function m_fsm:UpdateIdle()
  if CS.GameTime.time - self.enterIdleTime >= 6 and m_autoPlay then
    m_lastIdleAction = m_idleActions:random(m_lastIdleAction)
    if m_lastIdleAction ~= nil then
      PlayAnimation(m_lastIdleAction.name, m_lastIdleAction.audio, m_lastIdleAction.text)
    end
  end
end

function SetAutoPlay(b)
  m_autoPlay = b
end

function m_fsm:EnterTrace()
  local emoteCamera = m_emotePlayer.renderCamera
  local emoteScreenSize = Vector2(emoteCamera.targetTexture.width, emoteCamera.targetTexture.height)
  local uiCamera = CS.UIBaseProcess.Instance:GetCamera()
  local uiScreenSize = Vector2(uiCamera.targetTexture.width, uiCamera.targetTexture.height)
  local emotePosition = Vector2Divide(emoteCamera:WorldToScreenPoint(m_emotePlayer.transform.position), emoteScreenSize)
  local displayPosition = Vector2Divide(uiCamera:WorldToScreenPoint(m_emoteDisplay.transform.position), uiScreenSize)
  self.emotePosition = emotePosition + displayPosition
  self.uiScreenSize = uiScreenSize
  self.disgustTime = 0
  m_emoteSequencePlayer:PlayAnimation("wink")
end

function m_fsm:UpdateTrace()
  local mousePos = Vector2Divide(CS.GameUtility.DeviceToUIPoint(CS.UnityEngine.Input.mousePosition), self.uiScreenSize)
  local mouseTraceDistance = mousePos - self.emotePosition
  mouseTraceDistance.y = -mouseTraceDistance.y
  ApplyMouseTrace(mouseTraceDistance)
  local now = CS.GameTime.time
  if self.lastMouseTraceDistance ~= nil and self.lastMouseTraceTime ~= 0 then
    local deltaTime = now - self.lastMouseTraceTime
    local angle = math.abs(CS.UnityEngine.Vector2.Angle(mouseTraceDistance, self.lastMouseTraceDistance)) / deltaTime
    if 100 <= angle then
      self.disgustTime = self.disgustTime + deltaTime
    else
      self.disgustTime = math.max(0, self.disgustTime - 0.1)
    end
    if self.disgustTime >= 3 then
      m_lastDisgustAction = m_disgustActions:random(m_lastDisgustAction)
      PlayAnimation(m_lastDisgustAction.name, m_lastDisgustAction.audio, m_lastDisgustAction.text)
    end
  end
  self.lastMouseTraceDistance = mouseTraceDistance
  self.lastMouseTraceTime = now
end

function m_fsm:LeaveTrace()
  self.disgustTime = 0
  self.lastMouseTraceDistance = nil
  self.lastMouseTraceTime = 0
end

function SetSpeechText(text)
  m_speechText = text
  WU.ToggleRendering(m_speechText, false)
end

function m_fsm:UpdatePlay()
  if m_emotePlayer.mainTimelineLabel == m_emoteLoopLabel then
    m_fsm:ChangeState("Play", "Idle")
  end
end

function Awake()
  m_speechText = REF.BoardSpeechText
  WU.BindPressEvent(REF["$"], OnActorPortraitClick)
end

function Start()
  m_emoteDisplay = REF.EmoteDisplay
  InitRender()
  this:DelayInvokeInFrames(1, function()
    this:Bind("config/gamePreferences", OnGamePreferencesChanged)
  end)
  this:RegisterGameEvent("BoardActorEventVoice", OnBoardActorEventVoice)
  this:RegisterGameEvent("BoardSpeechTextOnly", OnBoardSpeechTextOnly)
end

function SetEmoteDisplay(emoteDisplay)
  m_emoteDisplay = emoteDisplay
end

function InitRender(render, index, bAutoDestory)
  if CS.EmoteManager.Instance ~= nil and m_emoteRender then
    CS.EmoteManager.Instance:DestroyRender(m_emoteRender)
    m_emoteRender = nil
  end
  if index == nil then
    index = 0
  end
  m_bAutoDestory = bAutoDestory
  if m_bAutoDestory == nil then
    m_bAutoDestory = true
  end
  if render then
    m_emoteRender = render
  else
    m_emoteRender = CS.EmoteManager.Instance:CreateRender("Emote/Render/CityEmoteRender")
  end
  m_emoteSequencePlayer = m_emoteRender:GetSequencePlayer(index)
  m_emoteSequencePlayer.m_loopLabel = m_emoteLoopLabel
end

function OnBoardSpeechTextOnly(text, time, id)
  if m_boardActorConfig == nil or m_boardActorConfig.id ~= id or m_speechMode ~= 2 then
    WU.ToggleRendering(m_speechText, false)
    return
  end
  UpdateSpeechText(text, time)
end

function OnBoardActorEventVoice(voiceName)
  local roleId = 0
  local signBoardID = this:GetData("BoardActor/RoleId")
  local allEntity = PB.all("Signboard")
  for _, v in pairs(allEntity) do
    if v.signboardId == signBoardID then
      roleId = v.roleId
      break
    end
  end
  local roleNotepads = this:GetData("fci/RoleNotePad/")
end

function OnBoardActorSpeech(speechId)
  local roleId = 0
  local signBoardID = this:GetData("BoardActor/RoleId")
  local allEntity = PB.all("Signboard")
  for _, v in pairs(allEntity) do
    if v.signboardId == signBoardID then
      roleId = v.roleId
      break
    end
  end
  local boardSpeech = PB.get("BoardSpeech", roleId, speechId)
  local cache = this:GetData("gameDataCache")
  local condition = PB.get("BoardSpeechCondition", speechId)
  if boardSpeech ~= nil and cache.boardActorSpeechTimes[condition.id] < condition.limit then
    PlayAnimation(nil, boardSpeech.emoteVoice, boardSpeech.emoteText)
    cache.boardActorSpeechTimes[condition.id] = cache.boardActorSpeechTimes[condition.id] + 1
    this:SetData("gameDataCache", cache)
    if 0 < boardSpeech.vibrateStrength then
      CS.NativeInterface.External_ForceTouchVibrate(boardSpeech.vibrateStrength - 1)
    end
  end
end

function UpdateSpeechText(text, time)
  local row = PB.get("BoardVoice2Text", text)
  if row == nil or m_speechText == nil then
    return
  end
  WU.ToggleRendering(m_speechText, true)
  for i = 1, #row.data do
    local text = row.data[i].localizationText
    local di = row.data[i].delayInvoke
    if 0 < di then
      this:DelayInvokeInSeconds(di, function()
        m_speechText.UIHtmlLabel.text = WU.GetString(text)
      end)
    else
      m_speechText.UIHtmlLabel.text = WU.GetString(text)
    end
  end
  this:DelayInvokeInSeconds(time, function()
    WU.ToggleRendering(m_speechText, false)
  end)
end

function InitBoardSpeechText()
  if m_speechText then
    WU.ToggleRendering(m_speechText, false)
    this:RegisterGameEvent("BoardSpeechText", UpdateSpeechText)
  end
end

function OnDestroy()
  if CS.EmoteManager.Instance ~= nil and m_bAutoDestory then
    CS.EmoteManager.Instance:DestroyRender(m_emoteRender)
  end
end

function OnEnable()
  m_window = REF.root.transform:GetComponentInParent(typeof(CS.UILuaWindow))
  if m_emoteSequencePlayer ~= nil and m_emotePlayer ~= nil then
    m_emotePlayer.enabled = true
  end
  InitBoardSpeechText()
  if m_window and m_window.gameObject.name == "City" then
    this:RegisterGameEvent("BoardActorSpeech", OnBoardActorSpeech)
  end
  this:BroadcastGameEvent("HasLeftCity", true)
end

function OnDisable()
  if m_emoteSequencePlayer ~= nil and m_emotePlayer ~= nil then
    m_emotePlayer.enabled = false
  end
  if m_window and m_window.gameObject.name == "City" then
    this:UnregisterGameEvent("BoardActorSpeech", OnBoardActorSpeech)
  end
  this:UnregisterGameEvent("BoardSpeechText", UpdateSpeechText)
  if this:GetData("City/CutBoardVoice") then
    this:BroadcastGameEvent("CutBoardLine")
    if m_emoteSequencePlayer then
      m_emoteSequencePlayer:StopAudio()
    end
  end
end

function Update(delta)
  m_fsm:Update()
  if not m_bIsNowEmoteStatic and m_isPressing and not m_forceTouched and CS.UnityEngine.Input.touchCount > 0 then
    local pressure = CS.GameUtility.GetPressPressure(0)
    if 1 < pressure then
      do
        local condition = NU.CheckBoardSpeech(PB.enum.SpeechType.ForceTouch, function(params)
          local pPressure = tonumber(params[1])
          return pPressure <= pressure
        end)
        if condition ~= nil and m_windowType == nil then
          this:BroadcastGameEvent("BoardActorSpeech", condition.id)
          m_forceTouched = true
        end
      end
    end
  end
end

function OnGamePreferencesChanged()
  local uiTexture = m_emoteDisplay.UITexture
  uiTexture.mainTexture = m_emoteRender.EmoteCamera.targetTexture
  uiTexture.width = m_emoteRender:GetWidth()
  m_emoteDisplay.transform.localPosition = CS.UnityEngine.Vector3(uiTexture.width, uiTexture.height, 0) * -0.5
end

function SetTouchCallback(callback)
  m_touchCallback = callback
end

function SetSpeechMode(mode)
  m_speechMode = mode
end

function PlayAnimation(action, audio, text, silent)
  if action ~= nil then
    ApplyMouseTrace(Vector2.zero)
    m_emoteSequencePlayer:PlayAnimation(action)
  end
  local dataBind = CS.DataBindingManager.Instance
  if WU.TutorialFight() and dataBind:GetData("CurrentTutorial") ~= 99 then
    silent = true
  end
  if m_boardActorConfig ~= nil and not silent and audio ~= nil and audio:len() > 0 then
    m_emoteSequencePlayer:StopAudio()
    local audioPath = string.format("Audio/Voice/%s/board_Emote/%s", m_boardActorConfig.name, audio)
    local clipData = CS.ResourceManager.Instance:GetAudioClip(audioPath)
    if clipData == nil then
      error("Board Emote Voice", audioPath .. "\228\184\141\229\173\152\229\156\168")
    end
    m_emoteSequencePlayer:PlayAudio(clipData)
    if clipData ~= nil then
      if m_speechMode == 1 then
        this:BroadcastGameEvent("BoardSpeechText", text, clipData.length)
      elseif m_speechMode == 2 then
        this:BroadcastGameEvent("BoardSpeechTextOnly", text, clipData.length, m_boardActorConfig.id)
      else
        UpdateSpeechText(text, clipData.length)
      end
    end
  end
  if not m_bIsNowEmoteStatic then
    m_fsm:ChangeState("", "Play")
  else
    m_fsm:EnterIdle()
  end
end

function PlayRandomAnimation(force, silent)
  if force == nil then
    force = false
  end
  if force or not m_boardActorConfig then
    if not m_boardActorConfig then
      SetBoardActorConfig(GetRandomBoardActorConfig())
    end
    m_lastInteractiveAction = m_interactiveActions:random(m_lastInteractiveAction)
    if m_lastInteractiveAction ~= nil then
      PlayAnimation(m_lastInteractiveAction.name, m_lastInteractiveAction.audio, m_lastInteractiveAction.text, silent)
    end
  end
end

function PlayIdleAnimation()
  m_lastIdleAction = m_idleActions:random(m_lastIdleAction)
  if m_lastIdleAction ~= nil then
    PlayAnimation(m_lastIdleAction.name, m_lastIdleAction.audio, m_lastIdleAction.text)
  end
end

function GetRandomBoardActorConfig()
  local data = PB.all("BoardActorConfig")
  if m_emoteIndex < 0 then
    m_emoteIndex = math.random(1, #data)
  else
    m_emoteIndex = m_emoteIndex % #data + 1
  end
  return data[m_emoteIndex]
end

function PlayAnimationInOrder(force, silent)
  if force == nil then
    force = false
  end
  if force or not m_boardActorConfig then
    if not m_boardActorConfig then
      SetBoardActorConfig(GetRandomBoardActorConfig())
    end
    if 0 < #m_interactiveActions then
      m_lastEmoteIndex = m_lastEmoteIndex % #m_interactiveActions + 1
      m_lastInteractiveAction = m_interactiveActions[m_lastEmoteIndex]
      if m_lastInteractiveAction ~= nil then
        PlayAnimation(m_lastInteractiveAction.name, m_lastInteractiveAction.audio, m_lastInteractiveAction.text, silent)
      end
    end
  end
end

function SetBoardActorConfig(config, noIdle)
  if not config then
    return
  end
  m_noIdle = noIdle
  m_boardActorConfig = config
  local allActions = _ENV["!"](m_boardActorConfig.actions)
  m_interactiveActions = allActions:where(function(key, value)
    return value.name:starts("boardA")
  end):toarray()
  m_idleActions = allActions:where(function(key, value)
    return value.name:starts("boardB")
  end):toarray()
  m_disgustActions = allActions:where(function(key, value)
    return value.name:starts("boardC")
  end):toarray()
  if not m_bIsNowEmoteStatic then
    local emoteFilePath = string.format("EMote/Character/%s/%s", m_boardActorConfig.emote, m_boardActorConfig.emote)
    m_emoteSequencePlayer:LoadEmoteFile(emoteFilePath)
    m_emotePlayer = m_emoteSequencePlayer.Player
    local transform = m_emoteSequencePlayer.transform
    local scale = m_boardActorConfig.scale
    transform.localPosition = CS.UnityEngine.Vector3(m_boardActorConfig.offsetX, m_boardActorConfig.offsetY, 0)
    transform.localScale = CS.UnityEngine.Vector3.one * scale
    m_emoteAppearance = -1
    NextAppearance()
  end
end

function ChangeBoardActor(force)
  SetBoardActorConfig(GetRandomBoardActorConfig())
  PlayRandomAnimation(force)
end

function StopAnimation()
  m_emoteSequencePlayer:StopAnimation()
end

function SetActor(actorId, force, silent)
  SetBoardActorConfig(PB.get("BoardActorConfig", actorId))
  PlayRandomAnimation(force, silent)
end

function SetSignBoardByID(signID, force, silent)
  local entity = PB.get("Signboard", signID)
  if entity ~= nil then
    if entity.type == PB.enum.SignboardType.Emote or entity.type == PB.enum.SignboardType.Virtual then
      m_bIsNowEmoteStatic = false
      SetBoardActorConfig(PB.get("BoardActorConfig", entity.BoardOfEmote))
      PlayRandomAnimation(force, silent)
      m_emoteDisplay.gameObject:SetActive(true)
      REF.TextureEmoteStatic.gameObject:SetActive(false)
    elseif entity.type == PB.enum.SignboardType.Erect then
      m_bIsNowEmoteStatic = true
      SetBoardActorConfig(PB.get("BoardActorConfig", entity.BoardOfEmote))
      PlayRandomAnimation(force, silent)
      m_emoteDisplay.gameObject:SetActive(false)
      REF.TextureEmoteStatic.gameObject:SetActive(true)
      local allSignboards = PB.all("Signboard")
      local _, theSignboard = table.find(allSignboards, function(k, v)
        return v.signboardId == signID
      end)
      if theSignboard.unlockType ~= PB.enum.SignboardUnlockType.ActorSignboardGift then
        local allActors = PB.all("ActorConfig")
        local _, theActor = table.find(allActors, function(k, v)
          return v.id == theSignboard.BoardOfAnimRes
        end)
        REF.TextureEmoteStatic.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. tostring(theActor.animRes)
      else
        REF.TextureEmoteStatic.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. theSignboard.roleNotepadRes
      end
      local thePortrait
      if theSignboard.unlockType ~= PB.enum.SignboardUnlockType.ActorSignboardGift then
        thePortrait = PB.get("ActorPortrait", theSignboard.BoardOfAnimRes, 0)
      else
        thePortrait = PB.get("ActorPortrait", theSignboard.BoardOfAnimRes, 1)
      end
      if thePortrait then
        if thePortrait.position[1].scale ~= 0 then
          REF.TextureEmoteStatic.transform.localScale = CS.UnityEngine.Vector3.one * thePortrait.position[1].scale
        else
          warning("Board", "ActorPortrait\232\161\168\228\184\173\230\178\161\230\156\137\229\175\185\229\186\148\231\154\132ActorId\230\136\150\229\175\185\229\186\148scale\228\184\1860\239\188\140ActorId\239\188\154" .. theSignboard.BoardOfAnimRes)
          REF.TextureEmoteStatic.transform.localScale = CS.UnityEngine.Vector3.one
        end
        REF.TextureEmoteStatic.transform.localPosition = CS.UnityEngine.Vector3(thePortrait.position[1].Xoffset, thePortrait.position[1].Yoffset, 0)
      end
    end
  else
    m_bIsNowEmoteStatic = false
    SetBoardActorConfig(GetRandomBoardActorConfig())
    PlayRandomAnimation(force, silent)
    m_emoteDisplay.gameObject:SetActive(true)
    REF.TextureEmoteStatic.gameObject:SetActive(false)
    error("BoardActor", "RoleId " .. tostring(roleId) .. " \230\178\161\230\156\137\229\175\185\229\186\148\231\154\132\231\156\139\230\157\191\229\168\152emoteActorId, \233\154\143\230\156\186\230\140\145\233\128\137\228\184\128\228\184\170\229\133\182\228\187\150\231\154\132")
  end
end

function OnActorPortraitClick(go, pressed)
  local now = CS.GameTime.time
  m_isPressing = pressed
  if m_isPressing then
    if not m_bIsNowEmoteStatic then
      local idle = m_emotePlayer.mainTimelineLabel == m_emoteLoopLabel
      m_forceTouched = false
      m_lastPressTime = now
      if idle then
        m_lastTouchTime = now
        m_fsm:ChangeState("Idle", "Trace")
      else
        m_lastTouchTime = 0
      end
    else
      m_lastPressTime = now
      m_lastTouchTime = now
    end
  else
    if not m_bIsNowEmoteStatic then
      m_fsm:ChangeState("Trace", "Idle")
    end
    if 0 < m_lastTouchTime and now - m_lastTouchTime < 0.2 and not m_emoteSequencePlayer:IsAudioPlaying() then
      PlayAnimationInOrder(true)
    end
    if 1 < now - m_lastClickTime then
      m_clickCount = 0
    end
    if now - m_lastPressTime < 0.2 then
      m_clickCount = m_clickCount + 1
      m_lastClickTime = now
    end
    local condition = NU.CheckBoardSpeech(PB.enum.SpeechType.Click, function(params)
      local pClickCount = tonumber(params[1])
      return pClickCount <= m_clickCount
    end)
    if condition ~= nil and m_windowType == nil then
      this:BroadcastGameEvent("BoardActorSpeech", condition.id)
      m_clickCount = 0
    end
  end
  if m_touchCallback then
    m_touchCallback(m_isPressing)
  end
end

function NextAppearance()
  local rangeStart = string.byte("q")
  local range = m_boardActorConfig.appearanceCount
  if 0 < range then
    m_emoteAppearance = (m_emoteAppearance + 1) % range
    for i = 0, range do
      local variable = "fade_" .. string.char(i + rangeStart)
      ApplyVariable(variable, fif(i == m_emoteAppearance, 0, 1))
    end
  end
end

function SetWindowType(windowType)
  m_windowType = windowType
end
