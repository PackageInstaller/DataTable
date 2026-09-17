local this = class("rogueEntryTimelineState")
this.timelineAssetName = {
  UIRogue_Start = "uirogue_start",
  UIRogue_loop_action01 = "uirogue_loop_action01",
  UIRogue_loop_action02 = "uirogue_loop_action02",
  UIRogue_loop = "uirogue_loop"
}

function this:setStateMap()
end

this.timelineNextClipMap = {
  [this.timelineAssetName.UIRogue_Start] = this.timelineAssetName.UIRogue_loop,
  [this.timelineAssetName.UIRogue_loop] = this.timelineAssetName.UIRogue_loop,
  [this.timelineAssetName.UIRogue_loop_action01] = this.timelineAssetName.UIRogue_loop,
  [this.timelineAssetName.UIRogue_loop_action02] = this.timelineAssetName.UIRogue_loop
}
this.timelineAssetNameInWhichState = {
  [this.timelineAssetName.UIRogue_Start] = L_Const.RogueEntryTimelineState.Start,
  [this.timelineAssetName.UIRogue_loop] = L_Const.RogueEntryTimelineState.Loop,
  [this.timelineAssetName.UIRogue_loop_action01] = L_Const.RogueEntryTimelineState.action1,
  [this.timelineAssetName.UIRogue_loop_action02] = L_Const.RogueEntryTimelineState.action2
}
this.timelineStateChangeMap = {
  [L_Const.RogueEntryTimelineState.Start] = {
    [L_Const.RogueEntryTimelineState.Loop] = this.timelineAssetName.UIRogue_loop,
    [L_Const.RogueEntryTimelineState.Action1] = this.timelineAssetName.UIRogue_loop_action01,
    [L_Const.RogueEntryTimelineState.Action2] = this.timelineAssetName.UIRogue_loop_action02
  },
  [L_Const.RogueEntryTimelineState.Loop] = {
    [L_Const.RogueEntryTimelineState.Action1] = this.timelineAssetName.UIRogue_loop_action01,
    [L_Const.RogueEntryTimelineState.Action2] = this.timelineAssetName.UIRogue_loop_action02
  },
  [L_Const.RogueEntryTimelineState.Action1] = {
    [L_Const.RogueEntryTimelineState.Loop] = this.timelineAssetName.UIRogue_loop
  },
  [L_Const.RogueEntryTimelineState.Action2] = {
    [L_Const.RogueEntryTimelineState.Loop] = this.timelineAssetName.UIRogue_loop
  }
}

function this:ctor()
  self.control = nil
end

function this:dispose()
  self.control = nil
end

function this:getIsStartAni(timelineAssetName)
  if timelineAssetName == self.timelineAssetName.UIRogue_Start or timelineAssetName == self.timelineAssetName.UIRogue_Start then
    return true
  end
  return false
end

function this:getIsTransition(timelineAssetName)
  local curState = self.timelineAssetNameInWhichState[timelineAssetName]
  local isTransition = false
  if curState == L_Const.RogueEntryTimelineState.Start then
    return false
  else
    isTransition = self.timelineNextClipMap[timelineAssetName] ~= timelineAssetName
  end
  return isTransition
end

function this:getState(timelineAssetName)
  local curState = self.timelineAssetNameInWhichState[timelineAssetName]
  if curState == nil then
    curState = L_Const.RogueEntryTimelineState.Start
  end
  return curState
end

function this:getNextStateTransitionAssetName(timelineAssetName, targetState, isAction, actionId)
  local curState = self:getState(timelineAssetName)
  if self:getIsTransition(timelineAssetName) and curState ~= targetState and self.timelineStateChangeMap[curState] and self.timelineStateChangeMap[curState][targetState] then
    return self.timelineStateChangeMap[curState][targetState]
  end
  if curState == targetState then
    return self.timelineNextClipMap[timelineAssetName]
  end
  if curState == L_Const.RogueEntryTimelineState.Start then
    return self.timelineAssetName.UIRogue_Start
  end
  if curState == L_Const.RogueEntryTimelineState.Start then
    if targetState == L_Const.RogueEntryTimelineState.Loop then
      return self.timelineAssetName.UIRogue_loop
    elseif targetState == L_Const.RogueEntryTimelineState.Action1 then
      return self.timelineAssetName.UIRogue_loop_action01
    elseif targetState == L_Const.RogueEntryTimelineState.Action2 then
      return self.timelineAssetName.UIRogue_loop_action02
    end
  end
  if self.timelineStateChangeMap[curState] and self.timelineStateChangeMap[curState][targetState] then
    return self.timelineStateChangeMap[curState][targetState]
  end
  if isAction then
    self.timelineNextClipMap[this.timelineAssetName.UIRogue_loop] = string.format("uirogue_loop_action0%d", actionId)
  else
    self.timelineNextClipMap[this.timelineAssetName.UIRogue_loop] = this.timelineAssetName.UIRogue_loop
  end
  print("state change fail curState:" .. curState .. " targetState: " .. targetState)
  return self.timelineNextClipMap[timelineAssetName]
end

return this
