local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local CO = require("Common/Coroutine")
local DBH = require("Manager/DataBindingHandler")
local m_index = 1

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.SetGameDataCache("Maze/TutorialShow" .. DB:GetData("playerId"), true)
    WU.RecycleWindow(this)
  end)
  REF.ScrollView.UIScrollView.onMomentumMove = DragFinish
  WU.TraverseChildren(REF.ButtonIndexGroup, function(go, index)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        ChangeIndex(index + 1)
        REF.ScrollView.UIScrollView:ResetPosition()
        REF.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(-1300 * index, 0, 0))
      end
    end)
  end)
  WU.BindButtonEvent(REF.ButtonLast, function()
    ChangeIndex(math.max(m_index - 1, 1))
  end)
  WU.BindButtonEvent(REF.ButtonNext, function()
    ChangeIndex(math.min(m_index + 1, 4))
  end)
end

function DragFinish()
  this:DelayInvokeInSeconds(0.7, function()
    local index = math.max(1, math.floor(math.abs(REF.ScrollView.transform.localPosition.x) / 1300 + 0.5) + 1)
    REF["ButtonIndex" .. index].UIToggle.value = true
  end)
end

function InitWindow()
  REF.ScrollView.UIScrollView:ResetPosition()
end

function ChangeIndex(idx)
  m_index = idx
  REF["ButtonIndex" .. m_index].UIToggle.value = true
  REF.ButtonNext.gameObject:SetActive(m_index < 4)
  REF.ButtonLast.gameObject:SetActive(1 < m_index)
  REF.ButtonClose.gameObject:SetActive(4 <= m_index)
end
