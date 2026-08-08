local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local DU = require("Common/DungeonUtil")
local m_level, m_groupId, m_timeElapse, m_activityId, m_dungeonId, m_callback

function SetupWindow()
  WU.BindButtonEvent(REF.Close, function(go)
    WU.RecordButtonClick(100128201)
    CancelWaiting()
  end)
end

function InitWindow()
  REF.Black.gameObject:SetActive(true)
  m_timeElapse = nil
  REF.Content.gameObject:SetActive(false)
  CS.Restifizer.RestifizerManager.Instance:RegisterWebSocketKickCallback(CS.Restifizer.WebSocketTag.DungeonTeamService, OnWebSocketKick)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.DungeonTeamService, "ScClientError", onErrorCode)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.DungeonTeamService, "ScTeamDungeonFastJoin", OnWaiting)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.DungeonTeamService, "ScTeamDungeonFastMatchSuccess", OnRoomMatched)
end

function UninitWindow()
  this:SetData("DungeonTeam/OnFastJoin", false)
end

function FastJoin(groupId, level, activityId, dungeonId, activityType)
  m_dungeonId = dungeonId
  m_level = level
  m_groupId = groupId
  m_activityId = activityId
  this:WebSocketSendLua(CS.Restifizer.WebSocketTag.DungeonTeamService, "CsTeamDungeonFastJoin", {
    level = level,
    dungeonGroup = groupId,
    isCancel = false,
    activityType = activityType
  })
  if activityType == PB.enum.ActivityType.DungeonTeamWelfare then
    REF.LabelTitle.UILabel.text = WU.GetString("DungeonTeamWelfare_FastJoinTitle")
  else
    REF.LabelTitle.UILabel.text = WU.GetString("DungeonTeam_FastJoinTitle")
  end
  this:SetData("DungeonTeamActivityType", activityType)
end

function UpdateWindow(deltaTime)
  if m_timeElapse ~= nil then
    m_timeElapse = m_timeElapse + deltaTime
    REF.Time.UILabel.text = math.floor(m_timeElapse) .. "s"
  end
end

function OnWaiting(message)
  if message.isCancel then
    this:SetData("DungeonTeam/OnFastJoin", false)
    if m_callback then
      m_callback()
    end
    WU.RecycleWindow(this)
  else
    local activityName = this:GetData("DungeonTeam/ActivityName") or ""
    REF.DungeonLabel.UIHtmlLabel.text = "<l width=100%><c width=60% align=left>" .. HU.ApplyFontStyle(activityName, nil, "#FFFFFFFF", 36) .. "</c><c width=40% align=right>" .. WU.GetString("DungeonTeam_DifficultLevel", m_level) .. "</c></l>"
    m_timeElapse = 1
    REF.Content.gameObject:SetActive(true)
    REF.Black.gameObject:SetActive(false)
    this:SetData("DungeonTeam/OnFastJoin", true)
  end
end

function OnWebSocketKick(webSocket)
  local message = ""
  if webSocket.BanReason ~= nil and webSocket.BanReason ~= "" then
    message = webSocket.BanReason .. "\n" .. WU.GetString("Error_UnBanTime", WU.RenderTime2(webSocket.BanTime, false, false, true))
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
  DU.IsInDungeonTeamPrepare(function()
    WU.AcquireWindowAsync("DungeonTeamPrepare", function(ui)
      _ENV["$"](ui)["$$FastJoinRoom"](m_activityId, m_dungeonId)
      _ENV["$"](ui)["$$InitBackAndHomeCallback"]()
    end)
  end)
end

function CancelWaiting(callback)
  m_callback = callback
  this:WebSocketSendLua(CS.Restifizer.WebSocketTag.DungeonTeamService, "CsTeamDungeonFastJoin", {
    level = m_level,
    dungeonGroup = m_groupId,
    isCancel = true
  })
end
