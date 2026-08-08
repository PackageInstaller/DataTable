inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local RU = require("Common/RedMarkUtil")
local LU = require("Common/ListUtil")
local m_selectedSlot, m_pendingMembers
local m_windowsOnTop = {}

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
  for i = 0, #REF.WrapContent - 1 do
    REF.WrapContent[i]["$$SetClickCallback"](OnSlotClick)
  end
  WU.BindButtonEvent(REF.ButtonRejectAll, OnRejectAllClick)
end

function InitWindow()
  this:Bind("guildId", ValidateRestrictions)
  this:Bind("fci/guild-player/", OnGuildPlayerChange)
  this:Bind("fci/guild/pending-members/", OnGuildPendingMembersChange)
  RU.SetRedMark("Relation/Guild/Pending", false)
end

function UninitWindow()
  CancelSelection()
  ClearTopWindows()
end

function ClearTopWindows()
  for key, _ in pairs(m_windowsOnTop) do
    WU.RecycleWindow(key)
  end
  m_windowsOnTop = {}
end

function OnGuildPlayerChange(guildPlayer)
  if not guildPlayer or guildPlayer.guildId ~= 0 and not GU.IsGuildManager(guildPlayer) then
    WU.ShowMessageOK(WU.GetString("Window_GuildMemberDemotedNoAuthority"), function(result)
      WU.RecycleWindow(this)
    end)
  end
end

function OnGuildPendingMembersChange(pendingMembers)
  m_pendingMembers = pendingMembers or {}
  table.sort(m_pendingMembers, function(a, b)
    return a.applyTime > b.applyTime
  end)
  local pendingMemberCount = #m_pendingMembers
  REF.LabelPendingMemberCount.UILabel.text = WU.GetString("Window_GuildApplicationCount") .. pendingMemberCount
  LU.Set(REF.WrapContent, pendingMemberCount)
  WU.SetActive(REF.ButtonRejectAll, 0 < #m_pendingMembers)
end

function UpdateRow(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if m_pendingMembers == nil or itemIndex > #m_pendingMembers then
    return
  end
  refRow["@index"] = itemIndex
  refRow["$$SetData"](m_pendingMembers[itemIndex])
end

function OnSlotClick(slot)
  m_selectedSlot = slot
  _ENV["$"](m_selectedSlot)["$$SetHighlight"](true)
  WU.ShowPlayerOption(m_pendingMembers[_ENV["$"](m_selectedSlot)["@index"]], OnHideOperations)
  m_windowsOnTop.PlayerOption = true
end

function OnHideOperations()
  m_windowsOnTop.PlayerOption = nil
  CancelSelection()
end

function CancelSelection()
  if m_selectedSlot then
    _ENV["$"](m_selectedSlot)["$$SetHighlight"](false)
    m_selectedSlot = nil
  end
end

function OnRejectAllClick()
  if GU.IsGuildManager() then
    this:GameRequest("fci/guild/{guildId}/pending-members/"):Delete()
  end
end
