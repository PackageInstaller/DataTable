local WU, DB, REF = require("Common/WindowUtil")(this)
local m_callback
local m_leftTweenerFinish = false
local m_rightTweenerFinish = false

function SetupWindow()
  CS.EventDelegate.Add(_ENV["$"](REF.NodeLeftPlayer).TweenerGroup2.UIPlayTween.onFinished, function()
    m_leftTweenerFinish = true
    if m_rightTweenerFinish and m_callback then
      this:DelayInvokeInSeconds(1.0, function()
        m_callback()
      end)
    end
  end)
  CS.EventDelegate.Add(_ENV["$"](REF.NodeRightPlayer).TweenerGroup2.UIPlayTween.onFinished, function()
    m_rightTweenerFinish = true
    if m_leftTweenerFinish and m_callback then
      this:DelayInvokeInSeconds(1.0, function()
        m_callback()
      end)
    end
  end)
end

function InitWindow()
  WU.ToggleRendering(REF.NodeLeftPlayer, false)
  WU.ToggleRendering(REF.NodeRightPlayer, false)
  WU.ToggleRendering(REF.Bg, false)
  m_callback = nil
  m_leftTweenerFinish = false
  m_rightTweenerFinish = false
  this:DelayInvokeInScaledSeconds(1, function()
    REF.EffectBg.EffectGenerator:Play()
  end)
  this:DelayInvokeInScaledSeconds(1.02, function()
    WU.ToggleRendering(REF.Bg, true)
    SetPlayers()
  end)
end

function SetPlayers()
  local fightActorInfo = this:GetData("FightActorInfo")
  if fightActorInfo then
    local leftActorInfo = fightActorInfo[1]
    local rightActorInfo = fightActorInfo[2]
    local myPlayerId = this:GetData("playerId")
    if fightActorInfo[1].playerId and fightActorInfo[1].playerId == myPlayerId then
      leftActorInfo = fightActorInfo[1]
      rightActorInfo = fightActorInfo[2]
    elseif fightActorInfo[2].playerId and fightActorInfo[2].playerId == myPlayerId then
      leftActorInfo = fightActorInfo[2]
      rightActorInfo = fightActorInfo[1]
    end
    if leftActorInfo and leftActorInfo.actors then
      local actors = ResetActors(leftActorInfo.actors)
      WU.ToggleRendering(REF.NodeLeftPlayer, true)
      _ENV["$"](REF.NodeLeftPlayer).LabelPlayerName.UILabel.text = leftActorInfo.name
      _ENV["$"](REF.NodeLeftPlayer).LabelPlayerLv.UILabel.text = WU.GetString("Window_Level", leftActorInfo.level)
      _ENV["$"](REF.NodeLeftPlayer).WidgetDungeonGroup["$DontShowQuality"]()
      _ENV["$"](REF.NodeLeftPlayer).WidgetDungeonGroup["$SetViewByActors"](actors)
      _ENV["$"](REF.NodeLeftPlayer).TweenerGroup2.UIPlayTween:Play(true)
    end
    if rightActorInfo and rightActorInfo.actors then
      local actors = ResetActors(rightActorInfo.actors)
      WU.ToggleRendering(REF.NodeRightPlayer, true)
      _ENV["$"](REF.NodeRightPlayer).LabelPlayerName.UILabel.text = rightActorInfo.name
      _ENV["$"](REF.NodeRightPlayer).LabelPlayerLv.UILabel.text = WU.GetString("Window_Level", rightActorInfo.level)
      _ENV["$"](REF.NodeRightPlayer).WidgetDungeonGroup["$DontShowQuality"]()
      _ENV["$"](REF.NodeRightPlayer).WidgetDungeonGroup["$SetViewByActors"](actors, true, true)
      _ENV["$"](REF.NodeRightPlayer).TweenerGroup2.UIPlayTween:Play(true)
    end
  end
end

function SetCallback(callback)
  m_callback = callback
end

function ResetActors(rawActors)
  local actors = {}
  for i = 1, #rawActors do
    local actor = rawActors[i]
    if actor then
      actor.quality = nil
      actor.star = nil
      actor.level = nil
      table.insert(actors, actor)
    end
  end
  return actors
end
