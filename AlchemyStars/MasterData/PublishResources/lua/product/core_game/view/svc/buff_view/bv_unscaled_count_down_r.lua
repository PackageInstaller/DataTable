_class("BuffViewStartUnscaledCountDown", BuffViewBase)
BuffViewStartUnscaledCountDown = BuffViewStartUnscaledCountDown

function BuffViewStartUnscaledCountDown:PlayView(TT)
  local res = self._buffResult
  local flagID = res:GetFlagID()
  local countDownValue = res:GetCountDownValue()
  local bShowGlobalUI = res:GetShowGlobalUI()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local cdCmpt = renderBoardEntity:UnscaledCountDownRender()
  if cdCmpt and not cdCmpt:GetIsActive() then
    cdCmpt:StartCoundDown(flagID, countDownValue)
    if bShowGlobalUI then
      self._world:EventDispatcher():Dispatch(GameEventType.UIShowUnscaledCountDown, true)
      self._world:EventDispatcher():Dispatch(GameEventType.UIEnableUnscaledCountDown, true)
    end
    Log.info("UnscaledCD StartCoundDown, flagID:", flagID, " timeMs:", countDownValue)
  end
end

_class("BuffViewStopUnscaledCountDown", BuffViewBase)
BuffViewStopUnscaledCountDown = BuffViewStopUnscaledCountDown

function BuffViewStopUnscaledCountDown:PlayView(TT)
  local res = self._buffResult
  local flagID = res:GetFlagID()
  local bHideGlobalUI = res:GetHideGlobalUI()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.UnscaledCountDownRender)
  for i, e in ipairs(group:GetEntities()) do
    local cdCmpt = e:UnscaledCountDownRender()
    if flagID == cdCmpt:GetFlagID() then
      if cdCmpt:GetIsActive() then
        cdCmpt:Reset()
        if bHideGlobalUI then
          self._world:EventDispatcher():Dispatch(GameEventType.UIEnableUnscaledCountDown, false)
          self._world:EventDispatcher():Dispatch(GameEventType.UIShowUnscaledCountDown, false)
        end
        Log.info("UnscaledCD StopCoundDown, flagID:", flagID)
      end
      break
    end
  end
end
