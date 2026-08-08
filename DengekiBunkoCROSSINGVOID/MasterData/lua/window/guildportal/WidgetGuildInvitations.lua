local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_guildInvitations, m_selectedIndex

function Awake()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
end

function Start()
  WU.BindButtonEvent(REF.ButtonIgnore, OnIgnoreClick)
  WU.BindButtonEvent(REF.ButtonJoin, OnJoinClick)
  for i = 0, #REF.WrapContent - 1 do
    REF.WrapContent[i]["$$SetClickCallback"](OnSlotClick)
  end
end

function OnEnable()
  this:Bind("fci/guild-player/invited/", OnGuildInvitationChange)
end

function OnDisable()
  this:Unbind("fci/guild-player/invited/", OnGuildInvitationChange)
end

function OnGuildInvitationChange(guildInvitation)
  m_guildInvitations = guildInvitation
  local invitationCount = 0
  if m_guildInvitations then
    invitationCount = #m_guildInvitations
  end
  REF.NodeEmpty.gameObject:SetActive(invitationCount <= 0)
  REF.NodeGuildList.gameObject:SetActive(0 < invitationCount)
  REF.RIGHT.gameObject:SetActive(0 < invitationCount)
  m_selectedIndex = nil
  this:DelayInvokeInFrames(1, function()
    LU.Set(REF.WrapContent, invitationCount)
    if 0 < invitationCount then
      OnSlotClick(REF.WrapContent[0]["$gameObject"])
    end
  end)
end

function UpdateRow(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if m_guildInvitations == nil or itemIndex > #m_guildInvitations then
    return
  end
  refRow["@index"] = itemIndex
  refRow["$$SetData"](m_guildInvitations[itemIndex])
  refRow["$$SetHighlight"](itemIndex == m_selectedIndex)
end

function OnSlotClick(slot)
  local newIndex = _ENV["$"](slot)["@index"]
  if newIndex ~= m_selectedIndex then
    for i = 0, #REF.WrapContent - 1 do
      if REF.WrapContent[i]["@index"] == m_selectedIndex then
        REF.WrapContent[i]["$$SetHighlight"](false)
      end
    end
    m_selectedIndex = newIndex
    _ENV["$"](slot)["$$SetHighlight"](true)
    REF.WidgetGuildPeek["$SetData"](m_guildInvitations[m_selectedIndex])
  end
end

function OnIgnoreClick()
  WU.RecordButtonClick(160008)
  if m_guildInvitations and m_selectedIndex then
    local guild = m_guildInvitations[m_selectedIndex]
    this:GameRequest("fci/guild-player/invited/" .. guild.id):Delete(function(result)
      table.remove(m_guildInvitations, m_selectedIndex)
      this:SetData("fci/guild-player/invited/", m_guildInvitations)
    end)
  end
end

function OnJoinClick()
  WU.RecordButtonClick(160007)
  if m_guildInvitations and m_selectedIndex then
    local guild = m_guildInvitations[m_selectedIndex]
    this:GameRequest("fci/guild/" .. guild.id .. "/members/"):Put({
      playerId = this:GetData("playerId")
    }, function(result)
    end)
  end
end
