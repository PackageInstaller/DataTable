local WU, DB, REF = require("Common/WindowUtil")(this)
local m_willTime, m_maxWaitTime, m_count

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonOK, Retry)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelMatch)
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecordButtonClick(100127301)
    OnCancelMatch()
  end)
  WU.BindKeyEvent(REF.ButtonClose, OnCancelMatch)
end

function CounterTime()
  if m_willTime and m_maxWaitTime and m_maxWaitTime ~= 0 then
    if m_count >= m_maxWaitTime then
      OnTimeOut()
      return
    end
    m_count = m_count + 1
    local remainTime = m_count
    if 0 <= remainTime then
      REF.LabelCounter.UIHtmlLabel.text = string.format("%02d", remainTime)
    end
  end
end

function OnTimeOut()
  ShowFaild()
end

function Show(params)
  m_willTime = params.matchTime
  m_maxWaitTime = params.maxWaitTime
  m_count = 0
  REF.PanelEffect.gameObject:SetActive(true)
  REF.PanelEffect.EffectGenerator:Play()
  if params.matchTime == 0 or params.maxWaitTime == 0 then
    REF.MatchNode.gameObject:SetActive(false)
  else
    REF.MatchNode.gameObject:SetActive(true)
    REF.LabelTime.UIHtmlLabel.text = string.format("%02d", m_willTime)
    REF.LabelCounter.UIHtmlLabel.text = string.format("%02d", m_count)
  end
end

function Retry()
  WU.RecycleWindow(this)
  this:BroadcastGameEvent("BurstLink/StartMatching")
end

function InitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", true)
  this:RegisterGameEvent("BurstLinkMatchSuccess", OnBurstLinkMatchSuccess)
  this:RegisterGameEvent("BurstLinkMatchFail", function()
    WU.ShowHintText(WU.GetString("PVPREALRACE_TIPS22"))
    OnCancelMatch()
  end)
  this:RegisterGameEvent("FightSvrErr", function()
    WU.ShowHintText(WU.GetString("PVPREALRACE_TIPS21"))
    OnCancelMatch()
  end)
  this:RepeatInvokeInSeconds(1, function()
    CounterTime()
  end)
  REF.MatchNode.gameObject:SetActive(false)
  REF.NoMatchNode.gameObject:SetActive(false)
end

function UninitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", nil)
end

function OnCancelMatch()
  this:MatchRequest("match/BurstLinkPVPMatch/"):Put({}, function(response)
    info("Cancel BurstLinkPvp Matching!", table.dump(response))
    WU.RecycleWindow(this)
  end)
end

function ShowFaild()
  m_willTime = nil
  m_maxWaitTime = nil
  REF.PanelEffect.gameObject:SetActive(false)
  REF.MatchNode.gameObject:SetActive(false)
  REF.NoMatchNode.gameObject:SetActive(true)
end

function OnBurstLinkMatchSuccess()
  WU.RecycleWindow(this)
end

function Focus(on)
  WU.RecordWindowFocus(1001273, on)
end
