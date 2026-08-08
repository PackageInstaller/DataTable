local PB = require("Common/PbHelper")
local WU, DB, REF = require("Common/WindowUtil")(this)
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local m_clickCallback, m_playerId

function Start()
  local function OnActorCardClick(go)
    if m_clickCallback ~= nil then
      m_clickCallback(go)
    end
  end
  
  WU.BindButtonEvent(REF.Ready, function()
    this:BroadcastGameEvent("DungeonTeamReady", true)
  end)
  WU.BindButtonEvent(REF.ReadyCancel, function()
    this:BroadcastGameEvent("DungeonTeamReady", false)
  end)
  WU.BindButtonEvent(REF.SwitchPosition, OnSwitchPosition)
  WU.BindButtonEvent(REF.DragDropNodeMain, OnActorCardClick)
  WU.BindButtonEvent(REF.DragDropNodeSub, OnActorCardClick)
  WU.BindButtonEvent(REF.KickOut, OnKickOut)
  local scale = REF.WidgetGroupMemberLink.transform.localScale
  local v3 = CS.UnityEngine.Vector3(scale.x, scale.y, scale.z)
  REF.WidgetGroupMemberLink["$SetSCardScale"](v3)
end

function SetPlayer(playerId, showKick, isLeader, isReady)
  local showPlayer = playerId ~= nil and U.trim(playerId) ~= ""
  REF.PlayerName.UILabel.text = ""
  REF.PlayerLevel.UILabel.text = ""
  REF.PlayerInfo.gameObject:SetActive(showPlayer and m_playerId == playerId)
  REF.WaitingPlayerLabel.gameObject:SetActive(not showPlayer)
  REF.WidgetIconPlayerHeadPhoto.gameObject:SetActive(false)
  if showPlayer then
    local function SetByPlayerInfo(playerInfo)
      if playerInfo then
        local cachedPlayerInfo = this:GetData("DungeonTeam/CachePlayerInfo") or {}
        
        cachedPlayerInfo[playerId] = playerInfo
        this:SetData("DungeonTeam/CachePlayerInfo", cachedPlayerInfo)
        REF.WidgetIconPlayerHeadPhoto.gameObject:SetActive(true)
        REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](playerInfo, 0.5)
        REF.PlayerLevel.UILabel.text = WU.GetString("Window_Level", playerInfo.level)
        REF.PlayerName.UILabel.text = playerInfo.name
        REF.PlayerInfo.gameObject:SetActive(true)
      end
    end
    
    local isFriend, friendPlayerInfo = table.find(this:GetData("fci/friendlist/"), function(_, v)
      return v.playerId == playerId
    end)
    local prepareCache = this:GetData("DungeonTeam/PrepareCache") or {}
    if isFriend then
      SetByPlayerInfo(friendPlayerInfo)
    elseif prepareCache[playerId] then
      SetByPlayerInfo(prepareCache[playerId])
    else
      this:GameRequest("fci/playersummary/" .. playerId):Query("byid", 1):SyncInput(false):Get(function(result)
        SetByPlayerInfo(result)
        prepareCache[playerId] = result
        this:SetData("DungeonTeam/PrepareCache", prepareCache)
      end)
    end
  end
  m_playerId = playerId
  REF.KickOut.gameObject:SetActive(not isLeader and showKick and showPlayer)
  REF.TeamLeader.gameObject:SetActive(isLeader)
  if playerId == this:GetData("playerId") then
    REF.Me.gameObject:SetActive(true)
    REF.OtherPlayer.gameObject:SetActive(false)
    REF.Ready.gameObject:SetActive(not isReady)
    REF.ReadyCancel.gameObject:SetActive(isReady)
  else
    REF.Me.gameObject:SetActive(false)
    REF.OtherPlayer.gameObject:SetActive(true)
    local iAmReady = this:GetData("DungeonTeam/IAmReady")
    REF.SwitchPosition.gameObject:SetActive(not isReady and not iAmReady)
    REF.NoSwitchPosition.gameObject:SetActive(isReady or iAmReady)
    REF.OtherPlayerIsReady.gameObject:SetActive(isReady)
  end
end

function SetActors(actors, clickCallback, notMyActors)
  local function ClearSlot(ref, i)
    ref["@actor"] = nil
    
    ref["@roleId"] = nil
    ref["@uid"] = nil
    ref.WidgetActorCard["$SetEmpty"](i)
    ref["$UIDragDropItem"].enabled = false
  end
  
  local position = REF["@position"]
  ClearSlot(REF.WidgetGroupMemberLink[0], 0 + position)
  ClearSlot(REF.WidgetGroupMemberLink[1], 3 + position)
  REF.WidgetGroupMemberLink["$SetActorsDungeonTeam"](actors[1], actors[2], notMyActors)
  REF.WidgetGroupMemberLink[0].ButtonSlot.BoxCollider2D.enabled = false
  REF.WidgetGroupMemberLink[1].ButtonSlot.BoxCollider2D.enabled = false
  m_clickCallback = clickCallback
end

function OnSwitchPosition()
  this:BroadcastGameEvent("DungeonTeamPositionChange", REF["@position"])
end

function ShowCustom(customs)
  REF.WidgetGroupMemberLink[0].WidgetActorCard["$ShowCustom"](customs)
  REF.WidgetGroupMemberLink[1].WidgetActorCard["$ShowCustom"](customs)
  REF.Button.gameObject:SetActive(customs.showButton or false)
end

function OnKickOut()
  WU.ShowMessageYesNo(WU.GetString("DungeonTeam_ConfirmKickOut", REF.PlayerName.UILabel.text), function(result)
    if result == "YES" then
      this:BroadcastGameEvent("DungeonTeamKickOut", m_playerId)
    end
  end)
end
