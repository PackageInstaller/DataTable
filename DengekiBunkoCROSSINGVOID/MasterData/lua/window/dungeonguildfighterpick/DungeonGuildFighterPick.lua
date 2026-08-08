inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_guildId, m_actors, m_selectedActor, m_lastSelectedRef, m_showPreview

function SetupWindow()
  WU.BindButtonEvent(REF.BtnFinish, OnBtnFinishClick)
  LU.Bind(REF.WrapContentActor, {
    dataSource = function(dataIndex)
      return m_actors and m_actors[dataIndex]
    end,
    updateSlot = OnUpdateSlot
  })
  for i = 0, #REF.NodeEquip - 1 do
    local slotRef = REF.NodeEquip[i]
    slotRef["$$SetEquipPos"](i)
    slotRef["$$SetShowHighlight"](false)
  end
end

function InitWindow()
  this:Bind("guildId", function(guildId)
    m_guildId = guildId
    ValidateRestrictions(guildId)
  end)
  m_selectedActor = nil
  m_lastSelectedRef = nil
  WU.ToggleRendering(REF.NodeContainerActor, false)
  REF.NodePreview["$Hide"]()
  m_showPreview = false
  this:Bind("fci/actor", UpdateActorList)
end

function Focus(on)
  if on then
    WU.SetWindowTitle("DungeonGuildFighterPick", "ItemPick")
  end
end

function UpdateActorList(actors)
  if actors == nil then
    return
  end
  m_actors = {}
  table.copy(actors, m_actors)
  m_actors = _ENV["!"](m_actors)
  if #m_actors ~= 0 then
    table.sort(m_actors, function(a, b)
      if a.level == b.level then
        if a.quality == b.quality then
          if a.cultivationTotal == b.cultivationTotal then
            if a.id == b.id then
              return a.uid < b.uid
            else
              return a.id < b.id
            end
          else
            return a.cultivationTotal > b.cultivationTotal
          end
        else
          return a.quality > b.quality
        end
      else
        return a.level > b.level
      end
    end)
  end
  local row = math.ceil(#m_actors / #REF.WrapContentActor[0]["$"])
  LU.Set(REF.WrapContentActor, row)
  REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContentActor.UIWrapContent.itemSize, 0)
  WU.ToggleRendering(REF.NodeContainerActor, true)
end

function OnUpdateSlot(ref, actor)
  ref["@info"] = actor
  ref["$$BindActor"](actor)
  ref["$$ShowCustom"]({
    showArm = actor.uniqueWeaponId and actor.uniqueWeaponId ~= 0
  })
  ref["$$SetHighlighted"](m_selectedActor and actor.uid == m_selectedActor.uid)
  ref["$$SetClickCallback"](OnActorClick)
end

function OnActorClick(go)
  local ref = _ENV["$"](go)
  local actor = ref["@info"]
  ref.HighlightedNode.gameObject:SetActive(true)
  if m_lastSelectedRef then
    m_lastSelectedRef["$$SetHighlighted"](false)
  end
  ref["$$SetHighlighted"](true)
  m_lastSelectedRef = ref
  m_selectedActor = actor
  if m_showPreview ~= true then
    REF.NodePreview["$Show"]()
    m_showPreview = true
  end
  local ref = _ENV["$"](REF.NodePreview)
  local showArmAble = actor.uniqueWeaponId and actor.uniqueWeaponId ~= 0
  _ENV["$"](ref.WidgetIconSlotGuildActor)["$$BindActor"](actor)
  REF.NodeArm.gameObject:SetActive(showArmAble)
  if showArmAble then
    REF.IconArm["$BindArm"](AU.GetArmByActor(actor), "S")
  end
  REF.ActorNameLabel.UILabel.text = WU.GetString("ActorName_" .. actor.id)
  this:SetData("Actor/SelectedUid", actor.uid)
end

function OnBtnFinishClick()
  WU.ShowMessageYesNo(WU.GetString("DungeonGuild_ReconfirmFighter"), function(result)
    if result == "YES" then
      local path = "fci/guild/" .. tostring(m_guildId) .. "/rent-actor/"
      this:GameRequest(path):Post({
        actorUid = m_selectedActor.uid
      }, function(res)
        local actorPool = this:GetData(path)
        local myPlayerId = this:GetData("playerId")
        local index, v = table.find(actorPool.rentActorInfo, function(k1, v1)
          return v1.playerId == myPlayerId
        end)
        if v then
          table.remove(actorPool.rentActorInfo, index)
        end
        table.insert(actorPool.rentActorInfo, res.rentActorInfo)
        this:SetData(path, actorPool)
        this:BroadcastGameEvent("DungeonGuildFighterSet")
        WU.RecycleWindow(this)
      end)
    end
  end)
end
