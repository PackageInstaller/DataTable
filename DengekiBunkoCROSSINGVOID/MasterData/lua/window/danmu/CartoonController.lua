local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CO = require("Common/Coroutine")
local U = require("Common/Util")
local Interval = PB.index("Misc", 1).danMuIntervalSeconds
local m_switchOn = false
local m_isPause = false
local m_interval
local m_currentTime = 0
local m_submitInterval, m_danmuChannel
local m_getFinished = true
local m_postFinished = true
local m_batchInterval
local m_trigger = false
local m_seconds = 0
local m_property, m_resultCache
local m_idHasSend = {}

function DanmuIsOpen(resp)
  if resp == nil then
    return
  end
  local _, info = table.find(resp, function(_, v)
    return v.resId == m_danmuChannel
  end)
  if info and info.switchGet then
    WU.BindButtonEvent(REF.BtnDanmuSwitch, OnDanmuSwitch)
    WU.BindButtonEvent(REF.BtnDanmuPlay, OnDanmuPlay)
    WU.BindButtonEvent(REF.BtnDanmuConfirm, OnDanmuSubmit)
    WU.BindButtonEvent(REF.BtnController, OnController)
  end
end

function Start()
  this:Bind("CartoonName", function(val)
    if val then
      m_idHasSend = {}
      m_danmuChannel = val
    end
  end)
  this:BindRemote(DB:GameRequest("fci/danmu-switch"), DanmuIsOpen)
  this:RegisterGameEvent("BroadShowHintText", OnHintShow)
  CS.EventDelegate.Add(REF.InputArea.UIInput.onChange, OnDanmuInputChange)
  local showState = this:GetData("CartoonDanmu/ShowState")
  if showState ~= nil then
    m_trigger = showState
  end
  local switchState = this:GetData("CartoonDanmu/SwitchState")
  if switchState ~= nil then
    m_switchOn = switchState
  end
  local sendMsg = this:GetData("CartoonDanmu/SendMessage")
  if sendMsg ~= nil then
    REF.InputArea.UIInput.value = sendMsg
  end
  OnController()
  OnDanmuSwitch()
  REF.InputArea.UIInput.defaultText = WU.GetString("Window_DefaultTextForUIDanmu")
  REF.LabelBtnConfirm.UIHtmlLabel.text = WU.GetString("Window_DanmuConfirm")
  m_interval = Interval
  m_submitInterval = Interval
  m_batchInterval = 0
  m_property = REF.NodeDanmu.UIDanmuku
  CS.DanmukuManager.Instance:InitDanmuPool(REF.NodeDanmu.transform)
  CS.DanmukuManager.Instance:StartDanmuCoroutine()
  if CS.CartoonManager.Instance:IsBlockCartoon() then
    REF.BtnDanmuPlay.gameObject:SetActive(false)
    REF.DanmuPlay.gameObject:SetActive(false)
  end
end

function OnDestroy()
  REF.InputArea.UIInput:RemoveFocus()
end

function OnController()
  WU.ToggleRendering(REF.Triggers, m_trigger)
  WU.ToggleRendering(REF.DanmuSwitch, m_trigger)
  WU.ToggleRendering(REF.DanmuPlay, m_trigger)
  WU.ToggleRendering(REF.DanmuCmd, m_trigger)
  WU.ToggleRendering(REF.DanmuBG, m_trigger)
  if m_trigger then
    REF.Label.transform.localPosition = CS.UnityEngine.Vector3(0, -350, 0)
    REF.TitleBG.transform.localPosition = CS.UnityEngine.Vector3(0, -50, 0)
  else
    REF.Label.transform.localPosition = CS.UnityEngine.Vector3(0, -480, 0)
    REF.TitleBG.transform.localPosition = CS.UnityEngine.Vector3(0, -150, 0)
  end
  REF.BtnSkipTalk.transform.localPosition = REF.TitleBG.transform.localPosition + CS.UnityEngine.Vector3(0, -240, 0)
  m_trigger = not m_trigger
  this:SetData("CartoonDanmu/ShowState", not m_trigger)
end

function OnDanmuInputChange()
  this:SetData("CartoonDanmu/SendMessage", REF.InputArea.UIInput.value)
end

function OnHintShow()
  if m_isPause then
    OnDanmuPlay()
  end
end

function Update(delta)
  if CS.DanmukuManager.Instance.DanmuPoolReady == nil then
    return
  end
  local unscaled_delta = CS.GameTime.unscaledDeltaTime
  m_currentTime = m_currentTime + delta
  if m_getFinished and m_postFinished then
    m_interval = m_interval + unscaled_delta
  end
  if m_postFinished then
    m_submitInterval = m_submitInterval + unscaled_delta
  end
  m_batchInterval = m_batchInterval + unscaled_delta
  m_seconds = m_seconds + unscaled_delta
  if m_danmuChannel and m_interval > Interval then
    m_interval = 0
    m_getFinished = false
    local postData = {
      content = "",
      second = math.floor(m_currentTime) // Interval * Interval,
      channel = m_danmuChannel
    }
    local wireFormatTable = ProtobufT("ApiDanmu", postData)
    this:GameRequest("fci/danmu/"):SyncInput(false):Post(wireFormatTable, function(result)
      m_getFinished = true
      if result then
        for i = 1, #result do
          local data = result[i]
          local idx, val = table.find(m_resultCache, function(k, v)
            return data.content == v.content
          end)
          if idx == nil or data.time ~= val.time then
            if data.playerId == this:GetData("playerId") then
              table.insert(m_idHasSend, data.id)
            end
            CS.DanmukuManager.Instance:InputDanmu(data.content)
          end
        end
      end
    end, function()
      m_getFinished = true
    end)
  end
  if m_batchInterval > REF.NodeDanmu.UIDanmuku.BatchIntervalInUse then
    m_batchInterval = 0
    CS.DanmukuManager.Instance:ResumeDanmuCoroutine()
  end
  if 0.3 < m_seconds then
    m_seconds = 0
    for i = 0, m_property.PoolSize - 1 do
      if 0 < CS.DanmukuManager.Instance.DanmuPoolReady[i] then
        CS.DanmukuManager.Instance.DanmuPoolReady[i] = CS.DanmukuManager.Instance.DanmuPoolReady[i] - 1
      end
    end
  end
end

function OnDanmuSwitch()
  if not m_switchOn then
    REF.SpriteCheckbox.UISprite.spriteName = "danmaku_open"
    WU.ToggleRendering(REF.NodeDanmu, true)
    m_switchOn = true
  else
    REF.SpriteCheckbox.UISprite.spriteName = "danmaku_close"
    WU.ToggleRendering(REF.NodeDanmu, false)
    m_switchOn = false
  end
  this:SetData("CartoonDanmu/SwitchState", not m_switchOn)
end

function OnDanmuPlay()
  local pause = CS.CartoonManager.Instance:SetCartoonPauseState()
  if pause then
    REF.DanmuPlay.UISprite.spriteName = "danmaku_start"
  else
    REF.DanmuPlay.UISprite.spriteName = "danmaku_pause"
  end
  m_isPause = pause
end

function OnDanmuSubmit()
  local text = U.trim(REF.InputArea.UIInput.value)
  if text == "" then
    return
  end
  if m_danmuChannel and m_submitInterval > Interval then
    m_submitInterval = 0
    m_interval = 0
    m_postFinished = false
    text = string.gsub(text, "<", "&lt;")
    text = string.gsub(text, ">", "&gt;")
    local postData = {
      content = text,
      second = math.floor(m_currentTime) // Interval * Interval,
      channel = m_danmuChannel
    }
    local wireFormatTable = ProtobufT("ApiDanmu", postData)
    this:GameRequest("fci/danmu/"):Post(wireFormatTable, function(result)
      m_postFinished = true
      if result then
        m_resultCache = result
        for i = 1, #result do
          local vip = result[i].playerId == this:GetData("playerId")
          if not vip or not table.find(m_idHasSend, function(_, v)
            return v == result[i].id
          end) then
            CS.DanmukuManager.Instance:InputDanmu(result[i].content, vip)
          end
        end
        REF.InputArea.UIInput.value = ""
        this:SetData("CartoonDanmu/SendMessage", nil)
      end
    end, function()
      m_postFinished = true
      REF.InputArea.UIInput.value = ""
      this:SetData("CartoonDanmu/SendMessage", nil)
    end)
  end
end
