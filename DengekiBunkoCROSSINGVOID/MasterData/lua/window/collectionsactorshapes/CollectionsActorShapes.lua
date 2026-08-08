local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local SU = require("Common/SortUtil")
local NU = require("Common/NotepadUtil")
local AU = require("Common/ActorUtil")
local m_kActorShapes
local m_iPreSetLen = 6
local m_kNowActor, m_kNowSelectedActor

function SetupWindow()
  WU.BindButtonEvent(REF.BtnClose, function()
    if m_kNowActor.id ~= m_kNowSelectedActor.id then
      this:BroadcastGameEvent("OnActorDataChange", m_kNowSelectedActor)
    end
    WU.RecycleWindow(this)
  end)
end

function InitData(nowActor)
  m_kNowActor = nowActor
  m_kNowSelectedActor = m_kNowActor
  m_kActorShapes = {}
  local acquredActors = this:GetData("Collections/Actors/")
  for _, v in pairs(acquredActors) do
    if nowActor.roleId == v.roleId then
      table.insert(m_kActorShapes, v)
    end
  end
  local len = #m_kActorShapes
  local delta = math.floor((m_iPreSetLen - len) / 2)
  WU.TraverseChildren(REF.GridShapes, function(go, i)
    local ref = _ENV["$"](go)
    if i < #m_kActorShapes then
      local actorData = m_kActorShapes[i + 1]
      ref["$$SetData"](actorData)
      if m_kNowActor.id == actorData.id then
        ref["$$SetSelected"](true)
      else
        ref["$$SetSelected"](false)
      end
      ref["$$SetClickCallback"](function(go)
        for i = 1, #REF.GridShapes do
          local refOther = REF.GridShapes[i - 1]["$"]
          _ENV["$"](refOther)["$$SetSelected"](false)
        end
        m_kNowSelectedActor = actorData
        ref["$$SetSelected"](true)
      end)
    else
      CS.UnityEngine.GameObject.Destroy(ref["$gameObject"])
    end
    if i == m_iPreSetLen - 1 then
      REF.GridShapes.UIGrid.enabled = true
    end
  end)
  REF.GridShapes.UIGrid:Reposition()
  REF.GridShapes.UIGrid.enabled = true
  REF.GridShapes.UIPlayTween:Play(true)
end
