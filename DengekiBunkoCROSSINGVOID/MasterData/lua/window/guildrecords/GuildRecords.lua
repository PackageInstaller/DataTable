inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local RU = require("Common/RedMarkUtil")
local m_tab, m_messages
local m_systemMessages = {}
local m_recordMessages = {}
local m_blockSystemSwitch

function SetupWindow()
  WU.BindButtonEvent(REF.SwitchOpen, function()
    WU.RecordButtonClick(164004)
    WU.ToggleRendering(REF.ScrollView, true)
    this:SetData("GuildRecords/BlockSystemSwitch", false)
  end)
  WU.BindButtonEvent(REF.SwitchClose, function()
    WU.RecordButtonClick(164003)
    WU.ToggleRendering(REF.ScrollView, false)
    this:SetData("GuildRecords/BlockSystemSwitch", true)
  end)
  WU.BindButtonEvent(REF.TabRecord, function()
    WU.RecordButtonClick(164001)
  end)
  WU.BindButtonEvent(REF.TabSystem, function()
    WU.RecordButtonClick(164002)
  end)
  CS.EventDelegate.Add(REF.TabRecord.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      m_tab = REF.TabRecord
      REF.ShowSwitch1.gameObject:SetActive(false)
      REF.ShowSwitch2.gameObject:SetActive(false)
      RU.SetRedMark("Relation/Guild/Message/Record", false)
      UpdateMessages(m_recordMessages, m_tab)
    end
  end)
  CS.EventDelegate.Add(REF.TabSystem.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      m_tab = REF.TabSystem
      REF.ShowSwitch1.gameObject:SetActive(true)
      REF.ShowSwitch2.gameObject:SetActive(true)
      RU.SetRedMark("Relation/Guild/Message/System", false)
      UpdateMessages(m_systemMessages, m_tab)
    end
  end)
end

function InitWindow()
  this:SetData("GuildRecords/BlockSystemSwitch", WU.GetGameDataCache("GuildRecords/BlockSystemSwitch"))
  this:Bind("GuildRecords/BlockSystemSwitch", OnBlockSystemSwitch)
  this:Bind("guildId", ValidateRestrictions)
  WU.ToggleRendering(REF.ScrollView, false)
  DB:SetData("ApplyChatRoomHyperLink", true)
  this:RegisterGameEvent("OnLinkClick", OnLinkClick)
  RU.BindRedMark(this, "Relation/Guild/Message/Record", OnGuildRecordMsg)
  RU.BindRedMark(this, "Relation/Guild/Message/System", OnGuildSystemMsg)
  this:Bind("GuildSystemMessageRaw", OnGuildSystemMessageRaw)
  RequestGuildRecords()
end

function OnGuildRecordMsg(new)
  _ENV["$"](REF.TabRecord).SpriteNew.gameObject:SetActive(new and m_tab ~= REF.TabRecord)
  if new then
    RequestGuildRecords()
  end
end

function RequestGuildRecords()
  this:GameRequest("fci/guild/{guildId}/record/"):SyncInput(false):Get(OnGuildRecordMessageRaw)
end

function OnGuildRecordMessageRaw(messages)
  if messages and 0 < #messages then
    CU.ParseMessage(messages)
    m_recordMessages = messages
    UpdateMessages(messages, REF.TabRecord)
  end
end

function OnGuildSystemMsg(new)
  _ENV["$"](REF.TabSystem).SpriteNew.gameObject:SetActive(not m_blockSystemSwitch and new and m_tab ~= REF.TabSystem)
end

function OnGuildSystemMessageRaw(messages)
  if messages and 0 < #messages then
    CU.SystemFilterByBlacklist(messages, this:GetData("fci/blacklist/"))
    m_systemMessages = messages
    UpdateMessages(messages, REF.TabSystem)
  end
end

function UpdateMessages(messages, tab)
  if m_tab ~= tab then
    return
  end
  m_messages = messages
  
  function REF.Table.ReuseTable.onGetChildWidget(trans)
    return _ENV["$"](trans).WidgetHeight.UIWidget
  end
  
  function REF.Table.ReuseTable.onInitializeItem(go, wrapIndex, realIndex)
    if m_messages and realIndex < #m_messages then
      local ref = _ENV["$"](go)
      ref["$$SetTextSystem"](ref, m_messages[realIndex + 1])
    end
  end
  
  REF.Table.ReuseTable:SetDataCount(#messages)
  REF.Table.ReuseTable:ResetPosition()
  WU.ToggleRendering(REF.ScrollView, tab ~= REF.TabSystem or not m_blockSystemSwitch)
end

function OnLinkClick(jsonText)
  local top = WU.TopWindow()
  if top and top.name == this.name then
    local jsonObj = JsonD(jsonText)
    if jsonObj then
      CU.HandleObjectHyperLink(jsonObj)
    end
  end
end

function OnBlockSystemSwitch(value)
  m_blockSystemSwitch = value
  REF.SwitchClose.gameObject:SetActive(value ~= true)
  REF.SwitchOpen.gameObject:SetActive(value == true)
  WU.SetGameDataCache("GuildRecords/BlockSystemSwitch", value)
end

function Focus(on)
  WU.RecordWindowFocus(100164, on)
end
