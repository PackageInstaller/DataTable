local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_actorUid, m_actor
local m_selectedIds = _ENV["!"]({})

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFinish, OnClickFinish)
  LU.Bind(REF.WrapContentPreview, {
    dataSource = function(dataIndex)
      local skinIds = this:GetData("actor2skin")[m_actor.id] or {}
      return skinIds[dataIndex]
    end,
    updateSlot = UpdatePreviewSlot
  })
end

function InitWindow()
  this:Bind("Actor/SelectedUid", OnCurrentActorUidChanged)
end

function OnCurrentActorUidChanged(uid)
  if uid then
    if m_actorUid then
      this:Unbind("fci/actor/" .. m_actorUid, OnActorChange)
      this:Unbind("fci/random-skin/" .. m_actorUid, OnRandomSkinChange)
    end
    m_actorUid = uid
    if m_actorUid then
      this:Bind("fci/actor/" .. m_actorUid, OnActorChange)
    end
  end
end

function OnActorChange(actor)
  if actor then
    m_actor = actor
    this:BindRemote(this:GameRequest("fci/random-skin/" .. m_actorUid), OnRandomSkinChange)
  end
end

function OnRandomSkinChange(result)
  if result then
    m_selectedIds = _ENV["!"](result.skinList):duplicate()
    local skinIds = this:GetData("actor2skin")[m_actor.id] or {}
    LU.Set(REF.WrapContentPreview, math.ceil(#skinIds / 5))
  end
end

function UpdatePreviewSlot(ref, skinId)
  ref["$$Clear"]()
  ref["$$SetSelected"](table.has(m_selectedIds, skinId))
  ref["$$SetClickCallback"](OnClickSlot)
  ref["@skinId"] = skinId
  local unlocked = this:GetData("fci/unlockedSkins")[skinId]
  ref["@unlocked"] = unlocked
  this:DelayInvokeInFrames(1, function()
    ref["$$SetData"](m_actor.id, skinId, unlocked)
  end)
end

function OnClickSlot(go)
  if not _ENV["$"](go)["@unlocked"] then
    return
  end
  local idx, skinId = table.find(m_selectedIds, function(k, v)
    return v == _ENV["$"](go)["@skinId"]
  end)
  if idx then
    table.remove(m_selectedIds, idx)
  else
    table.insert(m_selectedIds, _ENV["$"](go)["@skinId"])
  end
  _ENV["$"](go)["$$SetSelected"](not idx)
end

function OnClickFinish()
  if m_selectedIds:count() > 1 then
    this:GameRequest("fci/random-skin/" .. m_actor.uid):Post(ProtobufT("ApiActorRandomSkin", {skinList = m_selectedIds, onlySetList = true}), function(resp)
      this:SetData("fci/random-skin/" .. m_actor.uid, resp)
      WU.RecycleWindow(this)
    end)
  else
    WU.ShowHintText(WU.GetString("Window_ActorSkinRandomHint4"))
  end
end
