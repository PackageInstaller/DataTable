local this = class("entrustTimelineState")
this.timelineAssetName = {
  None = "None",
  UIMain_Start = "uientrust_01_start",
  UIMain_Loop = "uientrust_01_loop",
  UIMain_To_None = "uientrust_01_end",
  UIShop_Start = "uientrust_shop_01_start",
  UIShop_loop = "uientrust_shop_01_loop"
}

function this:setStateMap()
end

this.timelineNextClipMap = {
  [this.timelineAssetName.None] = this.timelineAssetName.UIMain_Start,
  [this.timelineAssetName.UIMain_Start] = this.timelineAssetName.UIMain_Loop,
  [this.timelineAssetName.UIMain_Loop] = this.timelineAssetName.UIMain_Loop,
  [this.timelineAssetName.UIShop_Start] = this.timelineAssetName.UIShop_loop,
  [this.timelineAssetName.UIShop_loop] = this.timelineAssetName.UIShop_loop,
  [this.timelineAssetName.UIMain_To_None] = this.timelineAssetName.None
}
this.timelineAssetNameInWhichState = {
  [this.timelineAssetName.None] = L_Const.EntrustTimelineState.None,
  [this.timelineAssetName.UIMain_Start] = L_Const.EntrustTimelineState.Main,
  [this.timelineAssetName.UIMain_Loop] = L_Const.EntrustTimelineState.Main,
  [this.timelineAssetName.UIMain_To_None] = L_Const.EntrustTimelineState.End,
  [this.timelineAssetName.UIShop_Start] = L_Const.EntrustTimelineState.Shop,
  [this.timelineAssetName.UIShop_loop] = L_Const.EntrustTimelineState.Shop
}
this.timelineStateChangeMap = {
  [L_Const.EntrustTimelineState.None] = {
    [L_Const.EntrustTimelineState.Main] = this.timelineAssetName.UIMain_Start,
    [L_Const.EntrustTimelineState.Shop] = this.timelineAssetName.UIShop_Start,
    [L_Const.EntrustTimelineState.End] = this.timelineAssetName.UIMain_To_None
  },
  [L_Const.EntrustTimelineState.Main] = {
    [L_Const.EntrustTimelineState.Main] = this.timelineAssetName.UIMain_Loop,
    [L_Const.EntrustTimelineState.None] = this.timelineAssetName.UIMain_To_None,
    [L_Const.EntrustTimelineState.Shop] = this.timelineAssetName.UIShop_Start
  },
  [L_Const.EntrustTimelineState.Shop] = {
    [L_Const.EntrustTimelineState.Shop] = this.timelineAssetName.UIShop_loop,
    [L_Const.EntrustTimelineState.None] = this.timelineAssetName.UIMain_To_None
  },
  [L_Const.EntrustTimelineState.End] = {
    [L_Const.EntrustTimelineState.Main] = this.timelineAssetName.UIMain_Start,
    [L_Const.EntrustTimelineState.Shop] = this.timelineAssetName.UIShop_Start
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
  if curState == L_Const.EntrustTimelineState.None then
  else
    isTransition = self.timelineNextClipMap[timelineAssetName] ~= timelineAssetName
  end
  return isTransition
end

function this:getState(timelineAssetName)
  local curState = self.timelineAssetNameInWhichState[timelineAssetName]
  if curState == nil then
    curState = L_Const.EntrustTimelineState.None
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
  if curState == L_Const.EntrustTimelineState.None then
    if targetState == L_Const.EntrustTimelineState.Shop then
      return self.timelineAssetName.UIShop_Start
    elseif targetState == L_Const.EntrustTimelineState.End then
      return self.timelineAssetName.UIMain_To_None
    else
      return self.timelineAssetName.UIMain_Start
    end
  end
  if curState == L_Const.EntrustTimelineState.Main then
    if targetState == L_Const.EntrustTimelineState.Select then
      return self.timelineAssetName.UIMain_To_Select
    elseif targetState == L_Const.EntrustTimelineState.None then
      return self.timelineAssetName.UIMain_To_None
    end
  end
  if self.timelineStateChangeMap[curState] and self.timelineStateChangeMap[curState][targetState] then
    return self.timelineStateChangeMap[curState][targetState]
  end
  print("state change fail curState:" .. curState .. " targetState: " .. targetState)
  return self.timelineNextClipMap[timelineAssetName]
end

function this:getTimelineAssetName(state)
  local timelineAssetName
  if state == L_Const.EntrustTimelineState.Main then
    timelineAssetName = self.timelineAssetName.UIMain_Start
  elseif state == L_Const.EntrustTimelineState.Select then
    timelineAssetName = self.timelineAssetName.UIMain_To_Select
  elseif state == L_Const.EntrustTimelineState.None then
    timelineAssetName = self.timelineAssetName.UIMain_To_None
  elseif state == L_Const.EntrustTimelineState.End then
    timelineAssetName = self.timelineAssetName.UIMain_To_None
  end
  return timelineAssetName
end

return this
