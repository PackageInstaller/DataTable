local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local m_window, m_stepId, m_stepCount, m_tutorialId, m_ended
local m_SORTING_ORDER = 29960
local m_DEPTH = 22799

function Awake()
  WU.BindButtonEvent(REF.NodeBlock, OnClickBlock)
end

function OnEnable()
  this:RegisterGameEvent("UnforcedTutorialNextStep", OnNextStep)
end

function OnDisable()
  this:UnregisterGameEvent("UnforcedTutorialNextStep", OnNextStep)
  EndTutorial()
end

function Init()
  m_tutorialId = math.floor(tonumber(string.split(REF.root.gameObject.name, "_")[2]))
  m_window = REF["$transform"]:GetComponentInParent(typeof(CS.UILuaWindow))
  WU.TraverseChildren(REF.NodeSteps, function(go)
    _ENV["$"](go)["$$Init"](m_tutorialId)
  end)
  WU.HandleGameObjectAttached(m_window.gameObject)
end

function StartTutorial(delay)
  m_stepId = 0
  m_stepCount = REF.NodeSteps.transform.childCount
  REF["$UIPanel"].depth = m_DEPTH
  REF["$UIPanel"].sortingOrder = m_SORTING_ORDER
  this:DelayInvokeInScaledSeconds(delay, StartTutorialImpl)
  S:Get("UnforcedTutorialManager").Doing = true
end

function HideTutorial()
  for i = 0, #REF.NodeSteps - 1 do
    WU.SetActive(REF.NodeSteps[i].root, false)
  end
end

function StartTutorialImpl()
  NextStep()
end

function NextStep()
  if m_ended then
    return
  end
  m_stepId = m_stepId + 1
  if 1 < m_stepId and m_stepId - 1 <= m_stepCount then
    REF["Step_" .. m_stepId - 1]["$EndStep"]()
  end
  if m_stepId <= m_stepCount then
    REF["Step_" .. m_stepId]["$StartStep"]()
  else
    EndTutorial()
  end
end

function EndTutorial()
  this:GameRequest("fci/tutorial/" .. m_tutorialId):Put({status = 1}, function()
    local _, t = table.find(this:GetData("fci/tutorial/"), function(k, v)
      return v.id == m_tutorialId
    end)
    t.status = 1
  end)
  m_ended = true
  HideTutorial()
  WU.SetActive(REF.NodeBlock, false)
  S:Get("UnforcedTutorialManager").Doing = false
end

function OnNextStep(tutorialId)
  if tutorialId == m_tutorialId then
    NextStep()
  end
end

function OnClickBlock()
  local xlsxConfig = PB.get("UnforcedTutorial", m_tutorialId)
  if xlsxConfig.canSkip then
    EndTutorial()
  end
end
