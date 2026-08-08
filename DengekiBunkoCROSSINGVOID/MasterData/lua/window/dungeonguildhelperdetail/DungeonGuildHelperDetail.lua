inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local SE = require("Common/SkillEffect")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local m_guildId, m_curActor, m_curActorIndex, m_actorList, m_dataList, m_myPlayerId

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    dataSource = function(index)
      return m_dataList and m_dataList[index]
    end,
    updateRow = UpdateSlot
  })
  WU.BindButtonEvent(REF.BtnPre, function()
    MoveActor(-1)
  end)
  WU.BindButtonEvent(REF.BtnNext, function()
    MoveActor(1)
  end)
  WU.BindButtonEvent(REF.BtnClose, function()
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  this:Bind("guildId", function(guildId)
    m_guildId = guildId
    ValidateRestrictions(guildId)
  end)
  m_myPlayerId = this:GetData("playerId")
end

function Focus(on)
  if on then
    WU.SetWindowTitle("DungeonGuildHelperDetail", "ActorInfo")
  end
end

function SetActor(actor, isInvitee)
  m_curActor = actor
  if m_curActor then
    UpdateUI()
    m_actorList = this:GetData("DungeonGuild/HelpersInOrder")
    if m_actorList then
      m_curActorIndex = table.find(m_actorList, function(k, v)
        return v.actor.uid == m_curActor.actor.uid
      end)
      if m_curActorIndex then
        REF.BtnPre.gameObject:SetActive(1 < m_curActorIndex)
        REF.BtnNext.gameObject:SetActive(m_curActorIndex < #m_actorList)
      end
    end
  end
end

function UpdateUI()
  m_curActor.actor.cultivationDegree = m_curActor.cultivationDegree
  m_curActor.actor.isGuild = true
  REF.WidgetActorBarCurrent["$OnActorChange"](m_curActor.actor)
  m_dataList = SE.GetActorSkills(m_curActor.actor.id, true)
  m_dataList:append(AU.GetActorLinks(m_curActor.actor, this:GetData("fci/actor/")))
  if (#m_dataList - 1) * REF.WrapContent.UIWrapContent.itemSize + REF.WrapContent[0]["$UIWidget"].width < REF.ScrollView.UIPanel.finalClipRegion.z then
    REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
  else
    REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Left
  end
  LU.Set(REF.WrapContent, #m_dataList)
end

function UpdateSlot(slotRef, wrapIndex, realIndex)
  if m_dataList and realIndex and realIndex < #m_dataList then
    slotRef["$$SetData"](m_curActor.actor, m_dataList[realIndex + 1])
  end
end

function MoveActor(step)
  local t = m_curActorIndex + step
  if t <= 0 or t > #m_actorList then
    return
  end
  m_curActorIndex = t
  m_curActor = m_actorList[m_curActorIndex]
  SetActor(m_curActor)
end
