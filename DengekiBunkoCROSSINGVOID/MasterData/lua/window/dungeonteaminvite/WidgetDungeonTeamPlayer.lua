local PB = require("Common/PbHelper")
local WU, DB, REF = require("Common/WindowUtil")(this)
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local CooldownInterval = 10
local m_cooldown, m_type, m_roomInfo, m_isCooldown
local m_inGroup = false
local m_playerId

function Start()
  WU.BindButtonEvent(REF.ButtonSprite, function(go)
    if not table.find(m_roomInfo.memberList, function(k, v)
      return U.trim(v) == ""
    end) then
      WU.ShowHintText(WU.GetString("DungeonTeam_GroupIsFull"))
      return
    end
    local ref = _ENV["$"](go)
    m_cooldown[m_playerId] = CooldownInterval
    m_isCooldown = false
    this:BroadcastGameEvent("DungeonTeamInvite", {m_playerId}, m_type)
  end)
end

function OnEnable()
  this:RegisterGameEvent("InGroupCheck", InGroupCheck)
end

function OnDisable()
  this:UnregisterGameEvent("InGroupCheck", InGroupCheck)
end

function CooldownTag(flag)
  m_isCooldown = flag
end

function Update()
  if m_cooldown ~= nil and not m_isCooldown and not m_inGroup then
    SetCooldown(m_cooldown[m_playerId] == nil or m_cooldown[m_playerId] < 0)
  end
end

function SetData(data, type)
  if data ~= nil then
    m_type = type
    REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](data)
    REF.PlayerName.UILabel.text = data.name
    REF.PlayerLevel.UILabel.text = data.level
    REF["$UIPlayTween"]:Play(true)
    m_playerId = data.playerId
    REF["@playerId"] = data.playerId
    m_cooldown = this:GetData("DungeonTeamInvite/Cooldown")
    InGroupCheck()
  end
end

function SetCooldown(isCooldown, inGroup)
  if inGroup ~= nil then
    m_inGroup = true
  else
    m_inGroup = false
    m_isCooldown = isCooldown
    local text = fif(isCooldown, WU.GetString("DungeonTeam_InvitePlayer"), WU.GetString("DungeonTeam_InviteCooldown", math.floor(m_cooldown[m_playerId] or 0) + 1))
    REF.Label.UILabel.text = text
    REF.ButtonSprite.gameObject:SetActive(isCooldown)
    REF.HasInvite.gameObject:SetActive(not isCooldown)
  end
  local alpha = fif(isCooldown and not m_inGroup, 1, 0.5)
  REF["$UIWidget"].alpha = alpha
end

function InGroupCheck()
  if m_cooldown then
    m_roomInfo = this:GetData("DungeonTeam/RoomInfo")
    local inGroup = table.find(m_roomInfo.memberList, function(k, v)
      return v == m_playerId
    end)
    REF.InGroup.gameObject:SetActive(inGroup ~= nil)
    REF.NotInGroup.gameObject:SetActive(inGroup == nil)
    SetCooldown(m_cooldown[m_playerId] == nil or m_cooldown[m_playerId] < 0, inGroup)
  end
end
