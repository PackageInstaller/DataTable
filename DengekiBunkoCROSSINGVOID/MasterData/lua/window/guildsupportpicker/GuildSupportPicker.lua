inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local NU = require("Common/NotepadUtil")
local m_selection
local m_candidates = _ENV["!"]({})
local m_widgetContentMap = _ENV["!"]({})

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonRequestSupport, OnRequestSupportClick)
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_candidates and m_candidates[dataIndex]
    end,
    updateSlot = UpdateSlot
  })
end

function InitWindow()
  this:Bind("guildId", ValidateRestrictions)
  m_selection = nil
  LU.Set(REF.WrapContent, 0)
  UpdateCandidates()
end

function UpdateCandidates()
  NU.GetCollectionsActor(function()
    local roleIdSet = {}
    local actorCollected = this:GetData("CollectionsActor/ActorsCollected")
    m_candidates = {}
    for _, actor in pairs(actorCollected) do
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        if not roleIdSet[actorConfig.role] then
          roleIdSet[actorConfig.role] = true
          local role = PB.get("Role", actorConfig.role)
          table.insert(m_candidates, {
            type = role.decomposeRes.type,
            id = role.decomposeRes.id
          })
        end
      else
        error("Actor", "actor with id: " .. actor.id .. " was not found in ActorConfig.xlsx")
      end
    end
    table.sort(m_candidates, function(a, b)
      return a.id < b.id
    end)
    local col = #REF.WidgetSlotRow7
    local row = math.ceil(#m_candidates / col)
    LU.Set(REF.WrapContent, row)
    REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContent.UIWrapContent.itemSize, 0)
  end)
end

function UninitWindow()
  m_widgetContentMap = _ENV["!"]({})
  REF.NodeOperations["$Hide"]()
end

function OnRequestSupportClick()
  WU.RecordButtonClick(161003)
  this:GameRequest("fci/guild/{guildId}/donate/request/"):Post({res = m_selection}, function(result)
    local guildDonate = this:GetData("fci/guild/donate/")
    local playerId = this:GetData("playerId")
    if guildDonate then
      guildDonate.donates[playerId] = result
    end
    this:SetData("fci/guild/donate/", guildDonate)
    WU.RecycleWindow("GuildSupportPicker")
  end)
end

function UpdateSlot(refSlot, context)
  local count = this:GetData("fci/item/" .. context.id).count
  refSlot["$$SetData"](context.type, context.id, fif(0 < count, count, nil))
  refSlot["$$ShowCustom"]({
    gray = count <= 0
  })
  refSlot["$$SetClickCallback"](OnSlotClick)
  m_widgetContentMap[refSlot] = context
  refSlot["$$SetHighlighted"](m_selection == context)
end

function OnSlotClick(go)
  WU.RecordButtonClick(161002)
  local ref = _ENV["$"](go)
  local context = ref["@context"]
  if m_selection ~= context then
    local selectedSlotRef = m_widgetContentMap:find(function(k, v)
      return v == m_selection
    end)
    if selectedSlotRef then
      selectedSlotRef["$$SetHighlighted"](false)
    end
    m_selection = context
    if m_selection then
      ref["$$SetHighlighted"](true)
      local operationRef = _ENV["$"](REF.NodeOperations)
      operationRef.WidgetIconSlot["$SetData"](m_selection.type, m_selection.id, this:GetData("fci/item/" .. m_selection.id).count)
      operationRef.LabelName.UILabel.text = WU.GetString("ItemName_" .. m_selection.id)
      operationRef.LabelDesc.UIHtmlLabel.text = WU.GetString("ItemDescribe_" .. m_selection.id)
    end
    REF.NodeOperations["$Show"]()
  end
end

function Focus(on)
  WU.RecordWindowFocus(100161, on)
end
