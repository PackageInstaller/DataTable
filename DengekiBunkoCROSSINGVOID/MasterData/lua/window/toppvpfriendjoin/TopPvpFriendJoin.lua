local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local DU = require("Common/DungeonUtil")
local ACU = require("Common/ActivityUtil")
local TPU = require("Common/TopPvpUtil")
local m_level, m_groupId, m_timeElapse, m_dungeonId, m_callback, m_invoke, m_isMatched, m_data
local m_isWaiting = false
local m_timeOut = 0
local m_ac
local quitUrl = "fci/friendpvp/invite/"
local m_playerId

function SetupWindow()
  WU.BindButtonEvent(REF.Close, function(go)
    if m_isMatched then
      return
    end
    CancelWaiting()
  end)
  WU.BindButtonEvent(REF.Close2, function(go)
    if m_isMatched then
      return
    end
    CancelWaiting()
  end)
  WU.BindButtonEvent(REF.BtnMin, function()
    if m_isMatched then
      return
    end
    SetMaximi(false)
  end)
end

function InitWindow()
  m_timeElapse = nil
  m_isMatched = false
  m_isWaiting = false
  REF.PanelSearched.gameObject:SetActive(false)
  SetMaximi(false)
  REF.Time.gameObject:SetActive(false)
  REF.Time2.gameObject:SetActive(false)
  m_playerId = this:GetData("TopPvpFriendOpPlayerId")
  StartCount()
  DB:GameRequest("fci/friendpvp/invite/"):Post({friendId = m_playerId}, nil, function()
    CancelWaiting(nil, true)
    return false
  end)
end

function SetMaximi(b)
  REF.TopMax.gameObject:SetActive(b)
  REF.TopMin.gameObject:SetActive(not b)
end

function StartCount()
  if m_invoke then
    this:StopCoroutine(m_invoke)
    m_invoke = nil
  end
  REF.Time.gameObject:SetActive(true)
  REF.Time2.gameObject:SetActive(true)
  m_isWaiting = true
  m_timeElapse = 0
  local strTime = string.format("%02d:%02d:%02d", 0, 0, 0)
  REF.Time.UILabel.text = strTime
  REF.Time2.UILabel.text = strTime
  this:SetData("DungeonTeam/TopPvpFriendJoin", true)
  m_invoke = this:RepeatInvokeInSeconds(1, function()
    m_timeElapse = m_timeElapse + 1
    local timeSpan = CS.System.TimeSpan(0, 0, m_timeElapse)
    local strTime = string.format("%02d:%02d:%02d", timeSpan.Hours, timeSpan.Minutes, timeSpan.Seconds)
    REF.Time.UILabel.text = strTime
    REF.Time2.UILabel.text = strTime
  end)
end

function StopCount()
  if m_invoke then
    this:StopCoroutine(m_invoke)
    m_invoke = nil
  end
end

function UninitWindow()
  if m_isWaiting then
    m_isWaiting = false
    this:SetData("DungeonTeam/TopPvpFriendJoin", false)
    this:GameRequest(quitUrl .. m_playerId):Delete()
  end
end

function OnWebSocketKick(webSocket)
  local message = ""
  if webSocket.BanReason ~= nil and webSocket.BanReason ~= "" then
    message = webSocket.BanReason .. "\n" .. WU.GetString("Error_UnBanTime", WU.RenderTime2(webSocket.BanTime, 5))
  else
    message = WU.GetString(PB.enum.ErrorMessageBox.__keys[webSocket.DisconnectReason])
  end
  WU.ShowMessageOK(message, function()
    CS.Restifizer.RestifizerManager.Instance:StopWebSocket(CS.Restifizer.WebSocketTag.DungeonTeamService)
    WU.RecycleWindow(this)
  end)
end

function onErrorCode(error)
  if error.isBox then
    WU.ShowMessageOK(WU.GetString(error.code))
  else
    WU.ShowHintText(WU.GetString(error.code))
  end
  if error.isReset then
    CS.Restifizer.RestifizerManager.Instance:StopWebSocket(CS.Restifizer.WebSocketTag.DungeonTeamService)
    WU.RecycleWindow(this)
  end
end

function OnRoomMatched(message)
  m_isMatched = true
  m_isWaiting = false
  EnterFight(message)
end

function EnterFight(response)
  TPU.EnterTopPvpFriendReady(response)
end

function CancelWaiting(callback, bForce)
  m_callback = callback
  if bForce then
    m_isWaiting = false
    this:SetData("DungeonTeam/TopPvpFriendJoin", false)
    WU.RecycleWindow(this)
  else
    DB:GameRequest(quitUrl .. m_playerId):Delete(function(response)
      if response.invitingFriendId == "" then
        m_isWaiting = false
        this:SetData("DungeonTeam/TopPvpFriendJoin", false)
        WU.RecycleWindow(this)
        if m_callback then
          m_callback()
        end
      else
        WU.ShowHintText(WU.GetString("TopPvpJoin_Tips66"))
      end
    end)
  end
end
