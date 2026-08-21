_class("UIN39TimeBase", UICustomWidget)
UIN39TimeBase = UIN39TimeBase

function UIN39TimeBase:SetData(endTime, callback)
  self._timeTex = self:GetUIComponent("UILocalizationText", "txtTime")
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._endTime = endTime
  self._callback = callback
  self:ShowTex()
  self:AddTimer()
end

function UIN39TimeBase:ShowTex()
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
        timeTex = StringTable.Get("str_n39_exchange_time_day_hour", self:RichTextTag_Num_Left(), day, self:RichTextTag_Num_Right(), self:RichTextTag_Num_Left(), hour, self:RichTextTag_Num_Right())
      else
        timeTex = StringTable.Get("str_n39_exchange_time_day", self:RichTextTag_Num_Left(), day, self:RichTextTag_Num_Right())
      end
    elseif hour and 0 < hour then
      if min and 0 < min then
        timeTex = StringTable.Get("str_n39_exchange_time_hour_min", self:RichTextTag_Num_Left(), hour, self:RichTextTag_Num_Right(), self:RichTextTag_Num_Left(), min, self:RichTextTag_Num_Left())
      else
        timeTex = StringTable.Get("str_n39_exchange_time_hour", self:RichTextTag_Num_Left(), hour, self:RichTextTag_Num_Right())
      end
    elseif min and 0 < min then
      timeTex = StringTable.Get("str_n39_exchange_time_min", self:RichTextTag_Num_Left(), min, self:RichTextTag_Num_Right())
    else
      timeTex = StringTable.Get("str_n39_exchange_time_less_min", self:RichTextTag_Num_Left(), self:RichTextTag_Num_Right())
    end
  else
    timeTex = StringTable.Get("str_n39_exchange_time_less_min", self:RichTextTag_Num_Left(), self:RichTextTag_Num_Right())
    if self._callback then
      self._callback()
    end
  end
  local showTex = StringTable.Get(self:Time_Tex(), self:RichTextTag_Out_Left(), timeTex, self:RichTextTag_Out_Right())
  self._timeTex:SetText(showTex)
end

function UIN39TimeBase:AddTimer()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowTex()
  end)
end

function UIN39TimeBase:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIN39TimeBase:RichTextTag_Out_Left()
  return ""
end

function UIN39TimeBase:RichTextTag_Out_Right()
  return ""
end

function UIN39TimeBase:RichTextTag_Num_Left()
  return ""
end

function UIN39TimeBase:RichTextTag_Num_Right()
  return ""
end

function UIN39TimeBase:Set_Time_Tex(texStr)
  self._timeTexStr = texStr
end

function UIN39TimeBase:Time_Tex()
  if self._timeTexStr then
    return self._timeTexStr
  end
  return "str_n39_exchange_remain_time"
end

_class("UIN39TimeLine", UIN39TimeBase)
UIN39TimeLine = UIN39TimeLine

function UIN39TimeLine:RichTextTag_Out_Left()
  return "<color=#cb9d8f>"
end

function UIN39TimeLine:RichTextTag_Out_Right()
  return "</color>"
end

function UIN39TimeLine:Time_Tex()
  return "str_n39_line_remain_time"
end

_class("UIN39TimeExchange", UIN39TimeBase)
UIN39TimeExchange = UIN39TimeExchange

function UIN39TimeExchange:RichTextTag_Num_Left()
  return "<size=34><color=#9fafee>"
end

function UIN39TimeExchange:RichTextTag_Num_Right()
  return "</color></size>"
end

function UIN39TimeExchange:Time_Tex()
  return "str_n39_exchange_remain_time"
end
