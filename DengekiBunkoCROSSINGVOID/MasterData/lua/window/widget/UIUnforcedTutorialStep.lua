local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_window, m_tutorialId, m_stepId, m_duration

function Init(tutorialId)
  m_tutorialId = tutorialId
  m_stepId = math.floor(tonumber(string.split(REF.root.gameObject.name, "_")[2]))
  m_duration = PB.get("UnforcedTutorial", m_tutorialId).durations[m_stepId]
  m_window = REF["$transform"]:GetComponentInParent(typeof(CS.UILuaWindow)).gameObject
  REF.LabelContent.UIHtmlLabel.text = WU.GetString(string.format("Tutorial_%s_%s", m_tutorialId, m_stepId))
end

function StartStep()
  WU.SetActive(REF.root, true)
  for i = 0, #REF.root - 1 do
    local refTip = REF.root[i]
    local tipName = refTip.root.gameObject.name
    if tipName == "UnforcedTutorialTip" or tipName == "UnforcedTutorialTipUpward" then
      PlayAnimNormal(refTip)
    end
    if tipName == "UnforcedTutorialTipSaku" then
      PlayAnimSaku(refTip)
    end
    if tipName == "UnforcedTutorialTipRim" then
      PlayAnimRim(refTip)
    end
  end
  this:DelayInvokeInSeconds(m_duration, function()
    this:BroadcastGameEvent("UnforcedTutorialNextStep", m_tutorialId)
  end)
end

function PlayAnimNormal(refTip)
  refTip.root.TweenScale:ResetToBeginning()
  refTip.root.TweenPosition:ResetToBeginning()
  refTip.root.TweenScale:PlayForward()
  this:DelayInvokeInSeconds(0.5, function()
    refTip.root.TweenPosition:PlayForward()
  end)
end

function PlayAnimSaku(refTip)
  refTip.NodeTweenScale.TweenScale:ResetToBeginning()
  refTip.SpriteRim.TweenAlpha:ResetToBeginning()
  refTip.NodeTweenScale.TweenScale:PlayForward()
  refTip.SpriteRim.TweenAlpha:PlayForward()
end

function PlayAnimRim(refTip)
  refTip.SpriteBG.TweenAlpha:ResetToBeginning()
  refTip.SpriteBG.TweenAlpha:PlayForward()
end

function EndStep()
  WU.SetActive(REF.root, false)
end
