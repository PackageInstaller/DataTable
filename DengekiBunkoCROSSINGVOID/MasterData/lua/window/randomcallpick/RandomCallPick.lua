local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local m_actorList = {}
local m_rowCount = 10
local m_dungeonUid, m_teamIdx, m_curTeamIdx
local m_mainPool = {}
local m_subPool = {}
local m_allPool = {}
local m_mainSlt = {}
local m_subSlt = {}
local m_allSlt = {}
local m_maxMain = 3
local m_maxSub = 3
local m_maxAll = 0
local m_opnPool = {}
local m_endTime
local m_confirm = false
local m_curChoice = 0
local m_choiceBound = {}
local m_showLink = false
local m_showSpeed = false

function SetupWindow()
  m_maxAll = m_maxMain + m_maxSub
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    if #m_allSlt >= m_choiceBound.max then
      SendChooseInfo()
    else
      WU.ShowHintText("Still got actors haven't Choose!")
    end
  end)
  CS.EventDelegate.Add(REF.ToggleSpeed.UIToggle.onChange, function()
    m_showSpeed = CS.UIToggle.current.value
    if CS.UIToggle.current.value then
      m_showLink = false
      REF.ToggleLink.UIToggle.value = m_showLink
    end
    OnActorChange()
  end)
  CS.EventDelegate.Add(REF.ToggleLink.UIToggle.onChange, function()
    m_showLink = CS.UIToggle.current.value
    if CS.UIToggle.current.value then
      m_showSpeed = false
      REF.ToggleSpeed.UIToggle.value = m_showSpeed
    end
    OnActorChange()
  end)
end

function InitWindow()
  m_mainSlt = {}
  m_subSlt = {}
  m_allSlt = {}
  m_choiceBound = {}
  m_dungeonUid = this:GetData("RandomCall/DungeonUid")
  REF.ToggleSpeed.UIToggle.value = false
  REF.ToggleLink.UIToggle.value = true
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.FightService, "ScChooseNtf", OnChooseInfoChange)
end

function InitData(message)
  if message ~= nil then
    warning("init message : " .. table.dump(message))
  else
    warning("init message nil ! ")
  end
  NormalizeActors(message.cards)
  m_curTeamIdx = message.activeTeam
  local chooseNum = message.chooseNum
  m_endTime = message.endTimestamp
  m_teamIdx = this:GetData("RandomCall/TeamIndex")
  if m_curTeamIdx == m_teamIdx then
    CheckRound(chooseNum)
  end
  OnActorChange()
end

function OnChooseInfoChange(message)
  if message.chooseEnd then
    this:SetData("RandomCall/Actors", m_allSlt)
    this:SetData("RandomCall/ActorGroup", FakeMembersInit())
    this:SetData("RandomCall/OpnPool", m_opnPool)
    WU.AcquireWindowAsync("RandomCallActorSelect", function(ui)
    end)
  end
  warning("chooseInfoChange : " .. table.dump(message))
  m_endTime = message.endTimestamp
  local chooseCards = message.chooseCards
  if message.chooseTeam == m_teamIdx then
    for j = #m_allSlt, m_choiceBound.min, -1 do
      CheckInsertOrRemove(m_allSlt[j])
    end
    for i = 1, #chooseCards do
      Pick(chooseCards[i])
    end
  else
    for i = 1, #chooseCards do
      table.insert(m_opnPool, GetActor(chooseCards[i]))
      OnActorChange()
    end
  end
  m_curTeamIdx = message.activeTeam
  if m_curTeamIdx == m_teamIdx then
    CheckRound(message.chooseNum)
  end
end

function UpdateActors(grid, actors, showSelected, showGraify, enableButton, showLink, showSpeed)
  WU.TraverseChildren(grid, function(parGo, parIdx)
    local ref = _ENV["$"](parGo)
    WU.TraverseChildren(ref.Grid, function(gridChild, childIdx)
      local rowCount = #_ENV["$"](ref.Grid).root
      local child = _ENV["$"](gridChild)
      if actors and 0 < #actors then
        local actor = actors[parIdx * rowCount + childIdx + 1]
        if actor then
          local _, inPlayer = table.find(m_allSlt, function(k, v)
            return v.uid == actor.uid
          end)
          local _, inOpponent = table.find(m_opnPool, function(k, v)
            return v.uid == actor.uid
          end)
          child["$$SetData"](actor.id)
          child["$$ShowGraify"](showGraify and inOpponent, enableButton)
          child["$$SetSelected"](inPlayer and showSelected)
          child["$$SetClickCallBack"](function()
            if not m_confirm then
              CheckInsertOrRemove(actor)
            end
          end)
          if showLink then
            child["$$ShowLink"](actor, AU.GetActorLinks(actor, m_allSlt))
          end
          if showSpeed then
            child["$$ShowSpeed"](actor)
          end
        else
          child["$$SetEmpty"]()
        end
      else
        child["$$SetEmpty"]()
      end
    end)
  end)
  if grid ~= REF.NodeContentPlayer then
    return
  end
  HighLightPlayerBox()
end

function CheckInsertOrRemove(actor, remove)
  if actor == nil then
    return
  end
  if remove == nil then
    remove = true
  end
  local max = actor.kind == 1 and m_maxMain or m_maxSub
  local pool = actor.kind == 1 and m_mainSlt or m_subSlt
  local idxAll, ac = table.find(m_allSlt, function(k, v)
    return v.uid == actor.uid
  end)
  local idxPool, ac = table.find(pool, function(k, v)
    return v.uid == actor.uid
  end)
  if idxAll and remove then
    if idxAll >= m_choiceBound.min and idxAll <= m_choiceBound.max then
      table.remove(pool, idxPool)
      table.remove(m_allSlt, idxAll)
      m_curChoice = math.min(m_maxAll, m_curChoice + 1)
    end
  elseif max > #pool and 0 < m_curChoice then
    table.insert(pool, actor)
    table.insert(m_allSlt, actor)
    m_curChoice = math.max(0, m_curChoice - 1)
  end
  OnActorChange()
end

function GetCurrentChooseIds()
  local ids = {}
  for i = m_choiceBound.min, m_choiceBound.max do
    table.insert(ids, m_allSlt[i].uid)
  end
  return ids
end

function Pick(uid)
  if #m_allSlt == m_maxAll then
    return
  end
  local _, op = table.find(m_opnPool, function(k, v)
    return v.uid == uid
  end)
  local _, my = table.find(m_allSlt, function(k, v)
    return v.uid == uid
  end)
  if op == nil and my == nil then
    CheckInsertOrRemove(GetActor(uid), false)
  end
end

function UpdateWindow(delta)
  if m_endTime == nil then
    m_endTime = 0
  end
  local remainTime = m_endTime - CS.GameTime.serverUtc
  local seconds = math.max(0, math.floor(remainTime % 3600 % 60))
  WU.SetLabel(REF.LabelTime, seconds)
  REF.ButtonConfirm.gameObject:SetActive(not m_confirm and m_curTeamIdx == m_teamIdx)
  if m_curChoice <= 0 and not m_confirm and seconds <= 1 and m_curTeamIdx == m_teamIdx then
    SendChooseInfo()
  end
end

function SendChooseInfo()
  local message = {
    dungeonId = m_dungeonUid,
    chooseCards = GetCurrentChooseIds()
  }
  this:WebSocketSendLua(CS.Restifizer.WebSocketTag.FightService, "CsChooseRoleReq", message)
  m_confirm = true
  warning(" Send CsChooseRoleReq ... " .. table.dump(message))
end

function OnActorChange()
  UpdateActors(REF.NodeContentSub, m_subPool, true, true, nil, m_showLink, m_showSpeed)
  UpdateActors(REF.NodeContentMain, m_mainPool, true, true, nil, m_showLink, m_showSpeed)
  UpdateActors(REF.NodeContentPlayer, m_allSlt, false, false, false)
  UpdateActors(REF.NodeContentOppnent, m_opnPool, false, false, false)
end

function HighLightPlayerBox()
  WU.TraverseChildren(_ENV["$"](REF.NodeContentPlayer).Grid, function(go, idx)
    if m_choiceBound.min == nil then
      return
    end
    local ref = _ENV["$"](go)
    ref["$$SetSelected"](idx + 1 >= m_choiceBound.min and idx + 1 <= m_choiceBound.max)
  end)
end

function CheckRound(choice)
  m_confirm = false
  m_curChoice = choice
  m_choiceBound.min = #m_allSlt + 1
  m_choiceBound.max = math.min(m_maxAll, #m_allSlt + m_curChoice)
  HighLightPlayerBox()
end

function GetActor(uid)
  local _, ac = table.find(m_allPool, function(k, v)
    return v.uid == uid
  end)
  return ac
end

function NormalizeActors(cards)
  for k, v in pairs(cards) do
    local resConfig = PB.get("ActorConfig", v.actorId)
    local mKind = resConfig.kind
    local ac = {
      id = v.actorId,
      uid = v.id,
      hide = v.hide,
      speed = v.speed,
      kind = mKind,
      quality = 0,
      star = 1
    }
    if mKind == 1 and #m_mainPool < 8 then
      local idx, actor = table.find(m_mainPool, function(k, v)
        return v.uid == ac.uid
      end)
      if actor == nil then
        table.insert(m_mainPool, ac)
      end
    elseif mKind == 2 and #m_subPool < 16 then
      do
        local idx, actor = table.find(m_subPool, function(k, v)
          return v.uid == ac.uid
        end)
        if actor == nil then
          table.insert(m_subPool, ac)
        end
      end
    end
  end
  m_allPool = _ENV["!"]({})
  m_allPool:append(m_mainPool)
  m_allPool:append(m_subPool)
  return m_mainPool, m_subPool, m_allPool
end

function FakeMembersInit()
  local members = {}
  for i = 0, 5 do
    local indi = {index = i, actorUid = 0}
    table.insert(members, indi)
  end
  return members
end

function FakeOpponents()
  if #m_allPool <= 0 then
    return
  end
  local main = {}
  local sub = {}
  m_opnPool = _ENV["!"]({})
  
  local function fake(tab, limit, kind)
    while limit > #tab do
      local i = math.random(1, #m_allPool)
      if m_allPool[i].kind == kind then
        do
          local idx, ac = table.find(tab, function(k, v)
            return v.id == m_allPool[i].id
          end)
          if ac == nil then
            table.insert(tab, m_allPool[i])
          end
        end
      end
    end
  end
  
  fake(main, m_maxMain, 1)
  fake(sub, m_maxSub, 2)
  m_opnPool:append(main)
  m_opnPool:append(sub)
  return m_opnPool
end

function FakeGroups()
  local groups = {}
  for i = 1, 6 do
    groups[i] = {
      actorUid = 0,
      index = i - 1
    }
  end
  return groups
end

function TestFunc()
  FakeData()
  FakeOpponents()
  OnActorChange()
  this:RepeatInvokeInSeconds(15, function()
    RandomPick()
    if #m_allSlt < m_maxAll then
      CheckRound(2, 15)
    elseif WU.TopWindow().name == this.name then
      local groups = _ENV["!"]({})
      table.copy(m_allSlt, groups, true)
      this:SetData("RandomCall/Actors", groups)
      this:SetData("RandomCall/ActorGroup", FakeGroups())
      WU.AcquireWindowAsync("RandomCallActorSelect", function(ui)
      end)
    end
  end)
end
