_class("UISeasonMazeEnter", UISideEnterCenterContentBase)
UISeasonMazeEnter = UISeasonMazeEnter

function UISeasonMazeEnter:Constructor()
end

function UISeasonMazeEnter:DoInit()
  self._campaign = self._data
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._sample = self._seasonMazeModule:GetCurSample()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UISeasonMazeEnter:DoShow(uiParams)
  local key = UISeasonMazeEnterBtn.GetLocalDBKey()
  LocalDB.SetInt(key, 1)
  self:GetComponents()
  self.te = UIActivityHelper.StartTimerEvent(self.te, function()
    self:OnRefreshTime()
  end)
end

function UISeasonMazeEnter:GetComponents()
  self.restTimeText = self:GetUIComponent("UILocalizationText", "RestTimeText")
end

function UISeasonMazeEnter:OnRefreshTime()
  if self.restTimeText then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local endTime = self._sample.end_time
    if curTime < endTime then
      local str = StringTable.Get("str_season_maze_less_adven_time") .. UIActivityHelper.GetFormatTimerStr(endTime - curTime)
      self.restTimeText:SetText(str)
    else
      self.restTimeText:SetText(StringTable.Get("str_activity_error_109"))
    end
  end
end

function UISeasonMazeEnter:BtnOnClick()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonClose_ShowClientError(self._seasonId) then
    return
  end
  if self._sample == nil then
    ToastManager.ShowToast(StringTable.Get("str_world_boss_season_end"))
    return
  end
  if not self._sample.is_open then
    ToastManager.ShowToast(StringTable.Get("str_world_boss_season_end"))
    return
  end
  self:ShowDialog("UISeasonMazeEnterController", true)
end

function UISeasonMazeEnter:DoHide()
  UIActivityHelper.CancelTimerEvent(self.te)
end

function UISeasonMazeEnter:DoDestroy()
end
