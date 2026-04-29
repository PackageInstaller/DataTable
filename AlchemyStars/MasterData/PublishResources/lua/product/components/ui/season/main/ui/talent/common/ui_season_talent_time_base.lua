_class("UISeasonTalentTimeBase", UICustomWidget)
UISeasonTalentTimeBase = UISeasonTalentTimeBase

function UISeasonTalentTimeBase:SetData(endTime, callback)
  self._timeTex = self:GetUIComponent("UILocalizationText", "txtTime")
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._endTime = endTime
  self._callback = callback
  self:ShowTex()
  self:AddTimer()
end

function UISeasonTalentTimeBase:ShowTex()
  local nowTime = math.ceil(self._svrTimeModule:GetServerTime() * 0.001)
  local gap = self._endTime - nowTime
  local timeTex = ""
  if 0 <= gap then
    local minAll = gap // 60
    local min = minAll % 60
    local hourAll = minAll // 60
    local hour = hourAll % 24
    local day = hourAll // 24
    if day and 0 < day then
      if hour and 0 < hour then
        timeTex = StringTable.Get("str_week_tower_reset_time_day_and_hour", day, hour)
      else
        timeTex = StringTable.Get("str_week_tower_reset_time_day", day)
      end
    elseif hour and 0 < hour then
      if min and 0 < min then
        timeTex = StringTable.Get("str_week_tower_reset_time_hour_and_min", hour, min)
      else
        timeTex = StringTable.Get("str_week_tower_reset_time_hour", hour)
      end
    elseif min and 0 < min then
      timeTex = StringTable.Get("str_week_tower_reset_time_only_min", min)
    else
      timeTex = StringTable.Get("str_week_tower_reset_time_only_sec")
    end
  else
    timeTex = StringTable.Get("str_week_tower_reset_time_only_sec")
    if self._callback then
      self._callback()
      self._callback = nil
    end
  end
  local showTex = StringTable.Get(self:Time_Tex(), timeTex)
  self._timeTex:SetText(showTex)
end

function UISeasonTalentTimeBase:AddTimer()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowTex()
  end)
end

function UISeasonTalentTimeBase:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonTalentTimeBase:RichTextTag_Out_Left()
  return ""
end

function UISeasonTalentTimeBase:RichTextTag_Out_Right()
  return ""
end

function UISeasonTalentTimeBase:RichTextTag_Num_Left()
  return ""
end

function UISeasonTalentTimeBase:RichTextTag_Num_Right()
  return ""
end

function UISeasonTalentTimeBase:Set_Time_Tex(texStr)
  self._timeTexStr = texStr
end

function UISeasonTalentTimeBase:Time_Tex()
  if self._timeTexStr then
    return self._timeTexStr
  end
  return "str_season_talent_tree_line_time_tex"
end
