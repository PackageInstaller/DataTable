local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_guild, m_guildMembers, m_selectedSlot

function InitWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
  for i = 0, #REF.WrapContent - 1 do
    REF.WrapContent[i]["$$SetClickCallback"](OnSlotClick)
  end
end

function UninitWindow()
  m_guild = nil
  m_guildMembers = nil
end

function SetData(guild)
  m_guild = guild
  if m_guild then
    REF.WidgetGuildProfile["$SetData"](m_guild)
    LU.Set(REF.WrapContent, 0)
    this:GameRequest("fci/guild/" .. m_guild.id .. "/members/"):Get(OnGuildMemebersChange)
  end
end

function OnGuildMemebersChange(guildMembers)
  m_guildMembers = _ENV["!"](guildMembers):values()
  table.sort(m_guildMembers, function(a, b)
    local onlineStatusA = fif(a.lastLogoutTime == 0, 1, 0)
    local onlineStatusB = fif(b.lastLogoutTime == 0, 1, 0)
    if onlineStatusA ~= onlineStatusB then
      return onlineStatusA > onlineStatusB
    elseif a.type ~= b.type then
      return a.type > b.type
    else
      return a.guildScoreRecord > b.guildScoreRecord
    end
  end)
  local memberCount = 0
  if m_guildMembers then
    memberCount = #m_guildMembers
  end
  LU.Set(REF.WrapContent, memberCount)
end

function UpdateRow(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if m_guildMembers == nil or itemIndex > #m_guildMembers then
    return
  end
  refRow["@index"] = itemIndex
  refRow["$$SetData"](m_guildMembers[itemIndex])
end

function OnSlotClick(slot)
  local guildMember = m_guildMembers[_ENV["$"](slot)["@index"]]
  if guildMember.playerId ~= this:GetData("playerId") then
    m_selectedSlot = slot
    _ENV["$"](m_selectedSlot)["$$SetHighlight"](true)
    WU.ShowPlayerOption(guildMember, OnHideOperations)
  end
end

function OnHideOperations()
  if m_selectedSlot then
    _ENV["$"](m_selectedSlot)["$$SetHighlight"](false)
    m_selectedSlot = nil
  end
end
