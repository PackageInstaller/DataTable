local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_maxWait = 0
local m_waitTime = 0
local m_timeStr = ""

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  m_waitTime = 0
  REF.MatchNode.gameObject:SetActive(true)
  REF.NoMatchNode.gameObject:SetActive(false)
  this:MatchRequest("match/RDPVPMatch"):Post({}, function(response)
    warning("RDPVP Matching...")
    m_maxWait = response.maxWaitTime
    WU.SetLabel(REF.LabelTime, response.matchTime)
    if response then
      warning(table.dump(response))
    end
  end)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScMatchNtf", OnMatchSuccess)
  this:RepeatInvokeInSeconds(1, RenderTime)
end

function RenderTime()
  m_waitTime = m_waitTime + 1
  WU.SetLabel(REF.LabelCounter, m_waitTime)
end

function OnMatchSuccess(matchInfo)
  if matchInfo == nil then
    return
  end
  warning(" matching success! ")
  for k, v in pairs(matchInfo.dungeonInfo.teams) do
    if v.members[1].playerId == DB:GetData("playerId") then
      this:SetData("RandomCall/TeamIndex", k)
      break
    end
  end
  local dungeonUid = matchInfo.dungeonInfo.dungeonUid
  this:SetData("RandomCall/MatchInfo", matchInfo)
  this:SetData("RandomCall/DungeonUid", dungeonUid)
  CS.Restifizer.RestifizerManager.Instance:SetFightWebSocketUrl(matchInfo.fightsvrUrl)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.FightService, "ScChooseStartNtf", OnChooseStart)
  local message = {
    dungeonId = dungeonUid or 0,
    dungeonType = PB.enum.DungeonType.RD
  }
  this:WebSocketSendLua(CS.Restifizer.WebSocketTag.FightService, "CsInitChooseReq", message)
end

function OnMatchFail()
end

function OnChooseStart(message)
  warning(" in choose start! ")
  WU.AcquireWindowAsync("RandomCallPick", function(ui)
    _ENV["$"](ui)["$$InitData"](message)
  end)
end

function UninitWindow()
end
