local this = class("timelineState")
this.timelineAssetName = {
  None = "None",
  UIDetail_Start = "UIDetail_Start",
  UIDetail_Loop = "UIDetail",
  UIDetail_To_Equip = "UIDToE",
  UIDetail_To_Skill = "UIDToS",
  UIEquip_Loop = "UIEquip",
  UIEquip_To_Detail = "UIEToD",
  UIEquip_To_Skill = "UIEToS",
  UISelect_Loop = "UISelect_Loop",
  UISelect_Start = "UISelect_Start",
  UISkill_Loop = "UISkill",
  UISkill_To_Detail = "UISToD",
  UISkill_To_Equip = "UISToE"
}
this.timelineNextClipMap = {
  [this.timelineAssetName.UIDetail_Start] = this.timelineAssetName.UIDetail_Loop,
  [this.timelineAssetName.UIDetail_To_Equip] = this.timelineAssetName.UIEquip_Loop,
  [this.timelineAssetName.UIDetail_To_Skill] = this.timelineAssetName.UISkill_Loop,
  [this.timelineAssetName.UIEquip_To_Detail] = this.timelineAssetName.UIDetail_Loop,
  [this.timelineAssetName.UIEquip_To_Skill] = this.timelineAssetName.UISkill_Loop,
  [this.timelineAssetName.UISelect_Start] = this.timelineAssetName.UISelect_Loop,
  [this.timelineAssetName.UISkill_To_Detail] = this.timelineAssetName.UIDetail_Loop,
  [this.timelineAssetName.UISkill_To_Equip] = this.timelineAssetName.UIEquip_Loop,
  [this.timelineAssetName.UISkill_Loop] = this.timelineAssetName.UISkill_Loop,
  [this.timelineAssetName.UISelect_Loop] = this.timelineAssetName.UISelect_Loop,
  [this.timelineAssetName.UIDetail_Loop] = this.timelineAssetName.UIDetail_Loop,
  [this.timelineAssetName.UIEquip_Loop] = this.timelineAssetName.UIEquip_Loop
}
this.timelineAssetNameInWhichState = {
  [this.timelineAssetName.None] = L_Const.heroTimelineState.None,
  [this.timelineAssetName.UIDetail_Start] = L_Const.heroTimelineState.Detail,
  [this.timelineAssetName.UIDetail_To_Equip] = L_Const.heroTimelineState.Equip,
  [this.timelineAssetName.UIDetail_To_Skill] = L_Const.heroTimelineState.Skill,
  [this.timelineAssetName.UIEquip_To_Detail] = L_Const.heroTimelineState.Detail,
  [this.timelineAssetName.UIEquip_To_Skill] = L_Const.heroTimelineState.Skill,
  [this.timelineAssetName.UISelect_Start] = L_Const.heroTimelineState.Select,
  [this.timelineAssetName.UISkill_To_Detail] = L_Const.heroTimelineState.Detail,
  [this.timelineAssetName.UISkill_To_Equip] = L_Const.heroTimelineState.Equip,
  [this.timelineAssetName.UISkill_Loop] = L_Const.heroTimelineState.Skill,
  [this.timelineAssetName.UISelect_Loop] = L_Const.heroTimelineState.Select,
  [this.timelineAssetName.UIDetail_Loop] = L_Const.heroTimelineState.Detail,
  [this.timelineAssetName.UIEquip_Loop] = L_Const.heroTimelineState.Equip
}
this.timelineStateChangeMap = {
  [L_Const.heroTimelineState.None] = {
    [L_Const.heroTimelineState.Select] = this.timelineAssetName.UISelect_Start,
    [L_Const.heroTimelineState.Detail] = this.timelineAssetName.UIDetail_Start
  },
  [L_Const.heroTimelineState.Detail] = {
    [L_Const.heroTimelineState.Equip] = this.timelineAssetName.UIDetail_To_Equip,
    [L_Const.heroTimelineState.Skill] = this.timelineAssetName.UIDetail_To_Skill,
    [L_Const.heroTimelineState.Select] = this.timelineAssetName.UISelect_Start
  },
  [L_Const.heroTimelineState.Equip] = {
    [L_Const.heroTimelineState.Detail] = this.timelineAssetName.UIEquip_To_Detail,
    [L_Const.heroTimelineState.Skill] = this.timelineAssetName.UIEquip_To_Skill,
    [L_Const.heroTimelineState.Select] = this.timelineAssetName.UISelect_Start
  },
  [L_Const.heroTimelineState.Skill] = {
    [L_Const.heroTimelineState.Detail] = this.timelineAssetName.UISkill_To_Detail,
    [L_Const.heroTimelineState.Equip] = this.timelineAssetName.UISkill_To_Equip,
    [L_Const.heroTimelineState.Select] = this.timelineAssetName.UISelect_Start
  },
  [L_Const.heroTimelineState.Select] = {
    [L_Const.heroTimelineState.Detail] = this.timelineAssetName.UIDetail_Start
  }
}

function this:ctor()
  self.control = nil
end

function this:dispose()
  self.control = nil
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
      return self.timelineAssetName.UISelect_Start
    else
      return self.timelineAssetName.UIDetail_Start
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
