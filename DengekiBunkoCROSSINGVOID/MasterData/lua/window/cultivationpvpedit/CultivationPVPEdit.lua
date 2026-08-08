local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local LU = require("Common/ListUtil")
local m_ratios = {}
local m_members
local m_Pos2Index = {
  [0] = {0, 3},
  [1] = {1, 4},
  [2] = {2, 5}
}
local m_selectedIndex = 0
local m_modeGroup = false
local m_selectedCardGasket
local m_groupRatio = 1

function SetupWindow()
  CS.EventDelegate.Add(REF.CultivationSlider.UISlider.onChange, OnRatioChanged)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    this:SetData("ActorGroup/CurrentCultivationRatios/" .. this:GetData("ActorGroupCultivationPVP/DungeonId"), m_ratios)
    SaveConfigsToCache()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.CheckboxModifyGroup, function()
    m_modeGroup = not m_modeGroup
    REF.CheckboxModifyGroup.UISprite.spriteName = fif(m_modeGroup, "checkbox_s", "checkbox_n")
    REF.CultivationSlider.UISlider.value = m_groupRatio
    OnRatioChanged()
  end)
  WU.BindButtonEvent(REF.ButtonAdd, function()
    REF.CultivationSlider.UISlider.value = math.clamp(REF.CultivationSlider.UISlider.value, 0.01, 1) + 0.001
  end)
  WU.BindButtonEvent(REF.ButtonSubtract, function()
    REF.CultivationSlider.UISlider.value = math.clamp(REF.CultivationSlider.UISlider.value, 0.01, 1) - 0.001
  end)
  WU.BindButtonEvent(REF.ButtonHelp, function()
    WU.AcquireWindowAsync("RuleCommon", function(ui)
      _ENV["$"](ui)["$$SetLabel"](WU.GetString("Help_CultivationPVPEdit"))
    end)
  end)
  m_selectedCardGasket = _ENV["$"](REF.WidgetGroupMembers).WidgetActorCard
  REF.WidgetGroupMembers["$DisplayAttrs"](true)
end

function InitWindow()
  local dungeonId = this:GetData("ActorGroupCultivationPVP/DungeonId")
  m_modeGroup = WU.GetGameDataCache("ActorGroup/ModeGroup/" .. dungeonId)
  m_ratios = _ENV["!"](this:GetData("ActorGroup/CurrentCultivationRatios/" .. dungeonId)):duplicate()
  m_groupRatio = WU.GetGameDataCache("ActorGroup/GroupCultivationRatios/" .. dungeonId) or 1
  REF.CheckboxModifyGroup.UISprite.spriteName = fif(m_modeGroup, "checkbox_s", "checkbox_n")
  REF.CultivationSlider.UISlider.value = fif(m_modeGroup, m_groupRatio, m_ratios[m_selectedIndex])
end

function SetMembers(members)
  m_members = members
  REF.WidgetGroupMembers["$SetGroupMembers"](m_members, m_ratios)
  if not m_modeGroup then
    m_selectedCardGasket["$SetHighlighted"](true)
  end
  SetCultivationDisplay()
end

function SetCultivationDisplay()
  local groupDegree = 0
  local memberDegree = 0
  local memberRatio = 0
  local memberName = ""
  for i = 0, 2 do
    local posDegree = 0
    for j = 1, 2 do
      local _, member = table.find(m_members, function(k, v)
        return v.index == m_Pos2Index[i][j]
      end)
      local degree = AU.GetActorCultivationDegree(this:GetData("fci/actor/" .. member.actorUid), m_ratios[member.index])
      posDegree = posDegree + degree
      if member.index == m_selectedIndex then
        memberRatio = m_ratios[member.index]
        memberDegree = degree
        memberName = ""
        if member.actorUid ~= 0 then
          memberName = WU.GetString("ActorName_" .. this:GetData("fci/actor/" .. member.actorUid).id)
        end
      end
    end
    groupDegree = groupDegree + posDegree
    REF.CultivationTips[i].LabelCultivationDegree.UILabel.text = WU.GetString("Window_ActorCultivationDegree", posDegree)
  end
  local text = string.format("%.1f%%(%s%s)", fif(m_modeGroup, m_groupRatio, memberRatio) * 100, fif(m_modeGroup, "", memberName .. " "), WU.GetString(fif(m_modeGroup, "Window_GroupCultivationDegree", "Window_ActorCultivationDegree"), fif(m_modeGroup, groupDegree, memberDegree)))
  REF.LabelGroupCultivationDegree.UILabel.text = text
end

function OnRatioChanged()
  if m_members then
    local a = REF.CultivationSlider.UISlider.value
    local ratio = math.clamp(math.floor(REF.CultivationSlider.UISlider.value * 1000 + 0.5) / 1000, 0.01, 1)
    if m_modeGroup then
      m_groupRatio = ratio
      for i = 0, 5 do
        m_ratios[i] = ratio
      end
    else
      m_ratios[m_selectedIndex] = ratio
    end
    SetMembers(m_members)
  end
end

function OnActorGroupButtonClick(go)
  if not m_modeGroup then
    REF.WidgetGroupMembers["$ClearSelection"]()
    _ENV["$"](go).WidgetActorCard["$SetHighlighted"](true)
    m_selectedIndex = _ENV["$"](go)["@index"]
    m_selectedCardGasket = _ENV["$"](go).WidgetActorCard
    local oldVal = REF.CultivationSlider.UISlider.value
    REF.CultivationSlider.UISlider.value = m_ratios[m_selectedIndex]
    if REF.CultivationSlider.UISlider.value == oldVal then
      OnRatioChanged()
    end
  end
end

function SaveConfigsToCache()
  local res = {}
  for i = 0, 5 do
    res[i + 1] = m_ratios[i]
  end
  local dungeonId = this:GetData("ActorGroupCultivationPVP/DungeonId")
  WU.SetGameDataCache("ActorGroup/CurrentCultivationRatios/" .. dungeonId, res)
  WU.SetGameDataCache("ActorGroup/GroupCultivationRatios/" .. dungeonId, m_groupRatio)
  WU.SetGameDataCache("ActorGroup/ModeGroup/" .. dungeonId, m_modeGroup)
end
