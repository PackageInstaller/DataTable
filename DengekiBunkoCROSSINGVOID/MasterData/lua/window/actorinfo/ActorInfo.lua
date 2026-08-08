local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local SE = require("Common/SkillEffect")
local m_actorUid, m_actor, m_tabName, m_actorList
local m_repeatedContext = {}
local m_shouldRecycle

function SetupWindow()
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        this:SetData("ActorInfoTab", go.name)
        WU.RecordButtonClick(go.name)
      end
    end)
  end)
end

function SaveContext(context)
  table.insert(m_repeatedContext, m_tabName)
end

function LoadContext(context)
  if 0 < #m_repeatedContext then
    local tabName = m_repeatedContext[#m_repeatedContext]
    table.remove(m_repeatedContext, #m_repeatedContext)
    SetSelectedTab(tabName)
  end
end

function InitWindow()
  REF.WidgetActorBarCurrent["$SetClickCallback"](nil)
  WU.SetActive(REF.SpriteOpenList, false)
  this:Bind("Actor/SelectedUid", OnCurrentActorUidChanged)
  this:RegisterGameEvent("EventSwitchTab", function(tabName)
    SetSelectedTab(tabName)
  end)
  local recomInfo = this:GetData("DungeonBalanceRecommendInfo")
  if recomInfo and recomInfo.key then
    local tabName = "Tab" .. recomInfo.key
    SetSelectedTab(tabName)
    this:SetData("DungeonBalanceRecommendInfo", nil)
  end
  this:SetData("UseGenericChipForTalentReset", nil)
  this:Bind("Actor/RollerTraverse", OnActorListChange)
end

function UninitWindow()
end

function ShowSwitch()
  REF.WidgetActorBarCurrent["$SetClickCallback"](OnActorBarClick)
  WU.SetActive(REF.SpriteOpenList, true)
end

function OnActorBarClick(actor)
  WU.AcquireWindowAsync("ActorInfoList")
end

function OnActorListChange(actorList)
  m_actorList = actorList
end

function OnCurrentActorUidChanged(uid)
  m_shouldRecycle = false
  if m_actorUid then
    this:Unbind("fci/actor/" .. m_actorUid, OnActorChange)
  end
  m_actorUid = uid
  if m_actorUid then
    this:Bind("fci/actor/" .. m_actorUid, OnActorChange)
  end
end

function OnActorChange(actor)
  m_actor = actor
  if m_actor then
    local showArm = actor.level >= PB.all("Misc"):first().weaponMisc.weaponShowLevel
    REF.TabArm.gameObject:SetActive(showArm)
    REF.TabGrid.UIGrid:Reposition()
    if not showArm and REF.NodeActorArms.gameObject.activeSelf then
      SetSelectedTab("TabDetail")
    end
    REF.WidgetActorBarCurrent["$OnActorChange"](m_actor)
    this:SetData("ActorInfo/CurrentActor", m_actor)
    _ENV["$"](REF.TabStar).SpriteNew.gameObject:SetActive(AU.UpgradeStarEnable(m_actor))
    _ENV["$"](REF.TabSkill).SpriteNew.gameObject:SetActive(SE.HasSkillToUpgrade(m_actor))
    _ENV["$"](REF.TabEquip).SpriteNew.gameObject:SetActive(EU.HasPosToEquip(m_actor))
    info("Debug", "Attr: " .. AU.GetActorCultivationDegreeAttr(actor) .. " Skill: " .. AU.GetActorCultivationDegreeSkill(actor) .. " Talent: " .. AU.GetActorCultivationDegreeTalent(actor) .. " Suit: " .. AU.GetActorCultivationDegreeSuit(actor))
  else
    m_shouldRecycle = true
  end
end

function SetSelectedTab(tabName)
  local len = #REF.TabGrid
  for i = 0, len - 1 do
    REF.TabGrid[i]["$UIToggle"].optionCanBeNone = true
    REF.TabGrid[i]["$UIToggle"].value = false
    REF.TabGrid[i]["$UIToggle"].optionCanBeNone = false
  end
  REF[tabName].UIToggle.value = true
  m_tabName = tabName
  WU.TriggerUnforcedTutorial(1107)
end

function Focus(on)
  if on and m_shouldRecycle then
    m_shouldRecycle = false
    WU.ShowHintText(WU.GetString("ForceRecycleWindow_ActorIsDecomposed"))
    WU.RecycleWindow(this)
    WU.RecordWindowFocus(100105, on)
  end
end
