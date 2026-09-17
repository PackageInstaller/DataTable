local this = class("shopTimelineState")
this.timelineAssetName = {
  None = "None",
  UIDetail_To_Skill = "UIDToS",
  UISkill_Loop = "UISkill"
}
this.timelineNextClipMap = {
  [this.timelineAssetName.UIDetail_To_Skill] = this.timelineAssetName.UISkill_Loop,
  [this.timelineAssetName.UISkill_Loop] = this.timelineAssetName.UISkill_Loop
}
this.timelineAssetNameInWhichState = {
  [this.timelineAssetName.None] = L_Const.heroTimelineState.None,
  [this.timelineAssetName.UIDetail_To_Skill] = L_Const.heroTimelineState.Skill,
  [this.timelineAssetName.UISkill_Loop] = L_Const.heroTimelineState.Skill
}
this.timelineStateChangeMap = {
  [L_Const.heroTimelineState.None] = {
    [L_Const.heroTimelineState.Skill] = this.timelineAssetName.UIDetail_To_Skill
  }
}

function this:ctor()
  self.control = nil
end

function this:dispose()
  self.control = nil
end

function this:getTimelineAssetName(state)
  local timelineAssetName = self.timelineAssetName.UIDetail_Start
  if state == L_Const.heroTimelineState.Detail then
    timelineAssetName = self.timelineAssetName.UIDetail_Start
  elseif state == L_Const.heroTimelineState.Equip then
    timelineAssetName = self.timelineAssetName.UIDetail_To_Equip
  elseif state == L_Const.heroTimelineState.Skill then
    timelineAssetName = self.timelineAssetName.UIDetail_To_Skill
  end
  return timelineAssetName
end

function this:getIsStartAni(timelineAssetName)
  if timelineAssetName == self.timelineAssetName.UIDetail_Start or timelineAssetName == self.timelineAssetName.UISelect_Start then
    return true
  end
  return false
end

function this:getIsTransition(timelineAssetName)
  local curState = self.timelineAssetNameInWhichState[timelineAssetName]
  local isTransition = false
  if curState == L_Const.heroTimelineState.None then
  else
    isTransition = self.timelineNextClipMap[timelineAssetName] ~= timelineAssetName
  end
  return isTransition
end

function this:getState(timelineAssetName)
  local curState = self.timelineAssetNameInWhichState[timelineAssetName]
  if curState == nil then
    curState = L_Const.heroTimelineState.None
  end
  return curState
end

function this:getNextStateTransitionAssetName(timelineAssetName, targetState)
  local curState = self:getState(timelineAssetName)
  if self:getIsTransition(timelineAssetName) then
    if curState ~= targetState and self.timelineStateChangeMap[curState] and self.timelineStateChangeMap[curState][targetState] then
      return self.timelineStateChangeMap[curState][targetState]
    end
    return self.timelineNextClipMap[timelineAssetName]
  end
  if curState == targetState then
    return self.timelineNextClipMap[timelineAssetName]
  end
  if curState == L_Const.heroTimelineState.None then
    if targetState == L_Const.heroTimelineState.None or targetState == L_Const.heroTimelineState.Select then
      return self.timelineAssetName.UIDetail_To_Skill
    else
      return self.timelineAssetName.UIDetail_To_Skill
    end
  end
  if curState == L_Const.heroTimelineState.Select and targetState ~= L_Const.heroTimelineState.Select then
    return self.timelineAssetName.UIDetail_Start
  end
  if self.timelineStateChangeMap[curState] and self.timelineStateChangeMap[curState][targetState] then
    return self.timelineStateChangeMap[curState][targetState]
  end
  print("state change fail curState:" .. curState .. " targetState: " .. targetState)
  return self.timelineNextClipMap[timelineAssetName]
end

return this
