local UI_HandBookBackground = class("UI_HandBookBackground", UIBaseWindow)
local base = UIBaseWindow

function UI_HandBookBackground:OnInit()
  self.handBookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
end

function UI_HandBookBackground:HBBGPalyerEnterTween()
  self:__PlayDoTweenAnimation("bg_fromBlack")
  self:__PlayDoTweenAnimation("bg_grigUp")
end

function UI_HandBookBackground:__PlayDoTweenAnimation(id)
  self.ui.DoTweenAnimation:DORestartAllById(id)
end

function UI_HandBookBackground:HBBGSetTop(index, viewLayerList)
  if IsNull(self.ui.tex_Top) then
    return
  end
  self.ui.tex_Top:SetIndex(index, viewLayerList[1], viewLayerList[2], viewLayerList[3], viewLayerList[4])
end

function UI_HandBookBackground:ShowHBBGSetTop(flag)
  if IsNull(self.ui.top) then
    return
  end
  self.ui.top.gameObject:SetActive(flag)
end

function UI_HandBookBackground:ShowHBBGTime(flag)
  if IsNull(self.ui.time) then
    return
  end
  self.ui.time:SetActive(flag)
  if flag then
    if self._timerId == nil then
      self:__RefreshTime()
      self._timerId = TimerManager:StartTimer(1, function()
        self:__RefreshTime()
      end)
    end
  elseif self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UI_HandBookBackground:__RefreshTime()
  local time = TimeUtil:TimestampToDate(math.floor(PlayerDataCenter.timestamp), flag, true)
  self.ui.tex_Time.text = string.format("%d/%02d/%02d %02d:%02d", time.year, time.month, time.day, time.hour, time.min)
end

function UI_HandBookBackground:__OnClickBack()
  self:Delete()
end

function UI_HandBookBackground:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  base.OnDelete(self)
end

return UI_HandBookBackground
